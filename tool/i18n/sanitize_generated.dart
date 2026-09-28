import 'dart:io';

const generatedDir = 'lib/i18n';

void main() {
  final directory = Directory(generatedDir);

  if (!directory.existsSync()) {
    stderr.writeln('Directory not found: $generatedDir');
    exitCode = 1;
    return;
  }

  var filesChanged = 0;

  for (final entity in directory.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }

    final original = entity.readAsStringSync();
    final escaped = _escapeBidirectionalControls(original);

    if (escaped == original) {
      continue;
    }

    entity.writeAsStringSync(escaped);
    filesChanged++;

    stdout.writeln('Escaped bidirectional controls: ${entity.path}');
  }

  stdout.writeln('Updated $filesChanged generated file(s).');
}

String _escapeBidirectionalControls(String value) {
  return value.replaceAll('\u202A', r'\u202A').replaceAll('\u202B', r'\u202B');
}
