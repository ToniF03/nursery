import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/data/demo_patient_data_generator.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/models/shift_handover_note.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';

class DashboardShiftHandover extends StatefulWidget {
  const DashboardShiftHandover({super.key});

  @override
  State<DashboardShiftHandover> createState() => _DashboardShiftHandoverState();
}

class _DashboardShiftHandoverState extends State<DashboardShiftHandover> {
  static const double _fadeWidth = 0.15;
  static const double _fadeRampDistance = 40;

  final ScrollController _scrollController = ScrollController();
  late final List<ShiftHandoverNote> _handoverNotes;
  double _topFadeStop = 0;
  double _bottomFadeStop = 1;

  @override
  void initState() {
    super.initState();
    _handoverNotes = DemoPatientDataGenerator().generateShiftHandoverNotes(12);
    _scrollController.addListener(_updateFadeStops);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFadeStops());
  }

  void _updateFadeStops() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final maxScroll = position.maxScrollExtent;
    if (maxScroll <= 0) {
      if (_topFadeStop != 0 || _bottomFadeStop != 1) {
        setState(() {
          _topFadeStop = 0;
          _bottomFadeStop = 1;
        });
      }
      return;
    }

    final scroll = position.pixels.clamp(0.0, maxScroll);
    final topFactor = (scroll / _fadeRampDistance).clamp(0.0, 1.0);
    final bottomFactor = ((maxScroll - scroll) / _fadeRampDistance).clamp(
      0.0,
      1.0,
    );
    final nextTopStop = _fadeWidth * topFactor;
    final nextBottomStop = 1 - _fadeWidth * bottomFactor;

    if ((nextTopStop - _topFadeStop).abs() > 0.005 ||
        (nextBottomStop - _bottomFadeStop).abs() > 0.005) {
      setState(() {
        _topFadeStop = nextTopStop;
        _bottomFadeStop = nextBottomStop;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(layoutPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${AppLocalizations.of(context)!.shiftHandover} ${AppLocalizations.of(context)!.notes} (${AppLocalizations.of(context)!.early} → ${AppLocalizations.of(context)!.late})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Pill(text: '${AppLocalizations.of(context)!.today}, 12:41 PM'),
              ],
            ),

            Divider(color: Colors.grey[100], thickness: .75),

            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: NotificationListener<ScrollMetricsNotification>(
                onNotification: (_) {
                  _updateFadeStops();
                  return false;
                },
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.transparent,
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                    ],
                    stops: [0, _topFadeStop, _bottomFadeStop, 1],
                  ).createShader(bounds),
                  blendMode: BlendMode.dstIn,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        for (final handoverNote in _handoverNotes)
                          _buildShiftHandoverNote(
                            context,
                            '${handoverNote.patientName} '
                            '(${handoverNote.room})',
                            handoverNote.note,
                            handoverNote.color,
                          ),
                        SizedBox(height: layoutPadding),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Divider(color: Colors.grey[100], thickness: .75),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: true,
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.indigo,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF1F1F1),
                      hintText: AppLocalizations.of(context)!.addANewNote,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.save),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const NotImplementedDialog(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftHandoverNote(
    BuildContext context,
    String header,
    String note,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: layoutPadding / 2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(layoutPadding),
          child: Row(
            children: [
              Transform.scale(
                scale: 0.5,
                child: Icon(Icons.circle, color: color),
              ),
              SizedBox(width: layoutPadding),
              Expanded(
                child: RichText(
                  text: header != ""
                      ? TextSpan(
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.bold,
                          ),
                          text: '$header: ',
                          children: [
                            TextSpan(
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.normal,
                              ),
                              text: note,
                            ),
                          ],
                        )
                      : TextSpan(
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.normal,
                          ),
                          text: note,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
