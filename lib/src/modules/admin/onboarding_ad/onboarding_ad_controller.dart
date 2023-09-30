import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:local_ad_view/src/shared/repositoryes/repository_firebase.dart';

class OnboardingAdController {
  final repositoryFirebase = RepositoryFirebase();

  void addAdImage(FilePickerResult file, {int screenTime = 10}) {
    repositoryFirebase.addAdImage(
        file: File(file.paths.first!), screenTime: screenTime);
  }
}
