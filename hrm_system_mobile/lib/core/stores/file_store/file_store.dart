import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
part 'file_store.g.dart';

// ignore: library_private_types_in_public_api
class FileStore = _FileStoreBase with _$FileStore;

abstract class _FileStoreBase with Store {
  @observable
  File? file;

  @action
  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
    }
  }
}
