import 'dart:io';
import 'package:grinder/grinder.dart';

void main(List<String> args) => grind(args);

@Task('Clean build artifacts')
void clean() {
  log('Cleaning...');
  Process.runSync('flutter', ['clean']);
}

@Task('Get dependencies')
void pubget() {
  log('Getting dependencies...');
  Process.runSync('flutter', ['pub', 'get']);
}

@Task('Build APK')
void apk() {
  log('Building APK...');
  Process.runSync('flutter', ['build', 'apk']);
}

@Task('Run build_runner')
void buildRunner() {
  log('Running build_runner...');
  Process.runSync('flutter', [
    'pub',
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
}

@DefaultTask('Run everything')
@Depends(clean, pubget, cleanGenerated, buildRunner)
void buildAll() {
  log('Finished all tasks.');
}

@Task('Clean all generated code from Freezed, Riverpod, etc.')
void cleanGenerated() {
  final directory = Directory.current;
  final extensions = ['.g.dart', '.freezed.dart', '.riverpod.dart'];

  int deletedCount = 0;

  void deleteGeneratedFiles(Directory dir) {
    for (var entity in dir.listSync(recursive: true)) {
      if (entity is File) {
        final name = entity.path;
        if (extensions.any((ext) => name.endsWith(ext))) {
          entity.deleteSync();
          deletedCount++;
          log('Deleted: $name');
        }
      }
    }
  }

  log('Cleaning generated files...');
  deleteGeneratedFiles(directory);
  log('Deleted $deletedCount generated file(s).');
}
