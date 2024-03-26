// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_type_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MissionTypeStore on _MissionTypeStoreBase, Store {
  late final _$missionTypeListAtom =
      Atom(name: '_MissionTypeStoreBase.missionTypeList', context: context);

  @override
  MissionTypeListModel get missionTypeList {
    _$missionTypeListAtom.reportRead();
    return super.missionTypeList;
  }

  @override
  set missionTypeList(MissionTypeListModel value) {
    _$missionTypeListAtom.reportWrite(value, super.missionTypeList, () {
      super.missionTypeList = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_MissionTypeStoreBase.service', context: context);

  @override
  MissionTypeService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(MissionTypeService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_MissionTypeStoreBase.status', context: context);

  @override
  LoadingStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LoadingStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$getMissionTypeListStoreAsyncAction = AsyncAction(
      '_MissionTypeStoreBase.getMissionTypeListStore',
      context: context);

  @override
  Future<dynamic> getMissionTypeListStore() {
    return _$getMissionTypeListStoreAsyncAction
        .run(() => super.getMissionTypeListStore());
  }

  @override
  String toString() {
    return '''
missionTypeList: ${missionTypeList},
service: ${service},
status: ${status}
    ''';
  }
}
