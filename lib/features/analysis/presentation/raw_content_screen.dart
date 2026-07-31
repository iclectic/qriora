import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../scanner/presentation/scanner_screen.dart';
import '../../../core/services/providers.dart';
import '../../../core/services/screenshot_protection_service.dart';

/// Raw content screen — shows the raw, unprocessed scanned value.
class RawContentScreen extends ConsumerStatefulWidget {
  final String scanId;

  const RawContentScreen({super.key, required this.scanId});

  @override
  ConsumerState<RawContentScreen> createState() => _RawContentScreenState();
}

class _RawContentScreenState extends ConsumerState<RawContentScreen> {
  late final ScreenshotProtectionService _screenshotProtection;

  @override
  void initState() {
    super.initState();
    _screenshotProtection = ref.read(screenshotProtectionProvider);
    // Enable screenshot protection on sensitive screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenshotProtection.enable();
    });
  }

  @override
  void dispose() {
    // Disable screenshot protection when leaving
    _screenshotProtection.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lastScan = ref.watch(lastScanResultProvider);
    final record = (lastScan?.id == widget.scanId) ? lastScan : null;

    if (record == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Raw content')),
        body: const Center(child: Text('Scan record not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Raw content'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Raw value', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 8),
                    SelectableText(
                      record.payload.rawValue,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Normalised value', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 8),
                    SelectableText(
                      record.payload.normalisedValue,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'monospace',
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
