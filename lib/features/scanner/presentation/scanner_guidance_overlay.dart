import 'package:flutter/material.dart';

/// A guidance overlay shown on the scanner when conditions are suboptimal.
///
/// Displays tips for improving scan quality: better lighting, holding steady,
/// and moving closer to the code.
class ScannerGuidanceOverlay extends StatefulWidget {
  final bool isPaused;
  final bool isProcessing;

  const ScannerGuidanceOverlay({
    super.key,
    this.isPaused = false,
    this.isProcessing = false,
  });

  @override
  State<ScannerGuidanceOverlay> createState() => _ScannerGuidanceOverlayState();
}

class _ScannerGuidanceOverlayState extends State<ScannerGuidanceOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _showGuidance = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // Show guidance after a delay if no scan is detected
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !widget.isProcessing && !widget.isPaused) {
        setState(() => _showGuidance = true);
        _fadeController.forward();
      }
    });
  }

  @override
  void didUpdateWidget(ScannerGuidanceOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Hide guidance when processing or paused
    if (widget.isProcessing || widget.isPaused) {
      if (_showGuidance) {
        _fadeController.reverse().then((_) {
          if (mounted) setState(() => _showGuidance = false);
        });
      }
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showGuidance) return const SizedBox.shrink();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Positioned(
        bottom: 80,
        left: 16,
        right: 16,
        child: Semantics(
          liveRegion: true,
          label:
              'Scanning tips: Ensure good lighting, hold the device steady, '
              'and centre the code in the scan area.',
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          size: 20, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Scanning tips',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _TipRow(text: 'Ensure good lighting on the code'),
                  _TipRow(text: 'Hold the device steady'),
                  _TipRow(text: 'Centre the code in the scan area'),
                  _TipRow(text: 'Move closer if the code is small'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final String text;

  const _TipRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline,
              size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
