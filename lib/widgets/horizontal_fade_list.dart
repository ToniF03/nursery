import 'package:flutter/material.dart';

class HorizontalFadeList extends StatefulWidget {
  final List<Widget> children;
  final double fadeWidth; // Width ratio of the fade effect (0.15 = 15%)
  final double fadeRampDistance; // Scroll distance in pixels to smoothly fade in/out

  const HorizontalFadeList({
    super.key,
    required this.children,
    this.fadeWidth = 0.15,
    this.fadeRampDistance = 40.0,
  });

  @override
  State<HorizontalFadeList> createState() => _HorizontalFadeListState();
}

class _HorizontalFadeListState extends State<HorizontalFadeList> {
  final ScrollController _controller = ScrollController();
  double _leftStop = 0.0;
  double _rightStop = 1.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateScrollState);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollState());
  }

  // Re-evaluate scroll bounds when children change dynamically
  @override
  void didUpdateWidget(covariant HorizontalFadeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollState());
  }

  void _updateScrollState() {
    if (!_controller.hasClients) return;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;

    if (maxScroll <= 0) {
      if (_leftStop != 0.0 || _rightStop != 1.0) {
        setState(() {
          _leftStop = 0.0;
          _rightStop = 1.0;
        });
      }
      return;
    }

    // Clamp scroll offset to handle negative/excessive values during bounce overscroll
    final clampedScroll = currentScroll.clamp(0.0, maxScroll);

    // Smoothly interpolate from 0.0 to 1.0 over the first [fadeRampDistance] pixels
    final leftFactor = (clampedScroll / widget.fadeRampDistance).clamp(0.0, 1.0);
    // Smoothly interpolate from 0.0 to 1.0 over the last [fadeRampDistance] pixels
    final rightFactor = ((maxScroll - clampedScroll) / widget.fadeRampDistance).clamp(0.0, 1.0);

    final newLeftStop = widget.fadeWidth * leftFactor;
    final newRightStop = 1.0 - (widget.fadeWidth * rightFactor);

    // Only trigger a rebuild if the gradient visibly changes
    if ((newLeftStop - _leftStop).abs() > 0.005 ||
        (newRightStop - _rightStop).abs() > 0.005) {
      setState(() {
        _leftStop = newLeftStop;
        _rightStop = newRightStop;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      // Update fade when viewport size changes (e.g. window resize)
      onNotification: (_) {
        _updateScrollState();
        return false;
      },
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              Colors.transparent,
              Colors.white,
              Colors.white,
              Colors.transparent,
            ],
            // When _leftStop == 0.0, the transparent region has zero width (no fade)
            stops: [0.0, _leftStop, _rightStop, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          // Enables elastic overscroll bounce across all platforms (including desktop/Android)
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Row(children: widget.children),
        ),
      ),
    );
  }
}