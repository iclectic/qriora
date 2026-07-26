import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/scanner/domain/content_normaliser.dart';

void main() {
  late ContentNormaliser normaliser;

  setUp(() {
    normaliser = ContentNormaliser();
  });

  group('ContentNormaliser', () {
    test('trims whitespace', () {
      expect(normaliser.normalise('  hello  '), 'hello');
    });

    test('collapses multiple spaces', () {
      expect(normaliser.normalise('hello    world'), 'hello world');
    });

    test('lowercases URL scheme', () {
      expect(normaliser.normalise('HTTPS://Example.com'), 'https://Example.com');
    });

    test('lowercases HTTP scheme', () {
      expect(normaliser.normalise('HTTP://example.com'), 'http://example.com');
    });

    test('preserves non-URL content', () {
      expect(normaliser.normalise('Hello World'), 'Hello World');
    });

    test('masks sensitive values', () {
      final masked = normaliser.mask('password123');
      expect(masked, 'pa••••23');
    });

    test('masks short values', () {
      final masked = normaliser.mask('abc');
      expect(masked, 'a••••');
    });

    test('masks empty string', () {
      final masked = normaliser.mask('');
      expect(masked, '');
    });
  });
}
