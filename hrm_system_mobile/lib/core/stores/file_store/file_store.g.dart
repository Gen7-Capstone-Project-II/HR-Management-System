// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FileStore on _FileStoreBase, Store {
  late final _$fileAtom = Atom(name: '_FileStoreBase.file', context: context);

  @override
  File? get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(File? value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  late final _$getFileAsyncAction =
      AsyncAction('_FileStoreBase.getFile', context: context);

  @override
  Future<dynamic> getFile() {
    return _$getFileAsyncAction.run(() => super.getFile());
  }

  @override
  String toString() {
    return '''
file: ${file}
    ''';
  }
}
