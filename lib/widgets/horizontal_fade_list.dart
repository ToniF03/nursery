import 'package:flutter/material.dart';

class HorizontalFadeList extends StatefulWidget {
  final List<Widget> children;

  const HorizontalFadeList({super.key, required this.children});

  @override
  State<HorizontalFadeList> createState() => _HorizontalFadeListState();
}

class _HorizontalFadeListState extends State<HorizontalFadeList> {
  final ScrollController _controller = ScrollController();
  bool _canScrollRight = false;
  bool _canScrollLeft = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateScrollState);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollState());
  }

  // Wichtig, falls sich die Anzahl der Children dynamisch ändert
  @override
  void didUpdateWidget(covariant HorizontalFadeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollState());
  }

  void _updateScrollState() {
    if (!_controller.hasClients) return;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    final canScroll = maxScroll > 0 && currentScroll < maxScroll - 1.0;

    if (canScroll != _canScrollRight) {
      setState(() => _canScrollRight = canScroll);
    }

    if (currentScroll > 1.0 && !_canScrollLeft) {
      setState(() => _canScrollLeft = true);
    } else if (currentScroll <= 1.0 && _canScrollLeft) {
      setState(() => _canScrollLeft = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            _canScrollLeft ? Colors.transparent : Colors.white,
            Colors.white,
            Colors.white,
            _canScrollRight ? Colors.transparent : Colors.white,
          ],
          stops: const [0.0, 0.15, 0.85, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: Row(children: widget.children),
      ),
    );
  }
}
