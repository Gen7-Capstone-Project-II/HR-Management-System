// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MissionStore on _MissionStoreBase, Store {
  late final _$missionListAtom =
      Atom(name: '_MissionStoreBase.missionList', context: context);

  @override
  MissionListModel get missionList {
    _$missionListAtom.reportRead();
    return super.missionList;
  }

  @override
  set missionList(MissionListModel value) {
    _$missionListAtom.reportWrite(value, super.missionList, () {
      super.missionList = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_MissionStoreBase.service', context: context);

  @override
  MissionService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(MissionService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_MissionStoreBase.status', context: context);

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

  late final _$getMissionListAsyncAction =
      AsyncAction('_MissionStoreBase.getMissionList', context: context);

  @override
  Future<dynamic> getMissionList(String userId) {
    return _$getMissionListAsyncAction.run(() => super.getMissionList(userId));
  }

  late final _$filterMissionListAsyncAction =
      AsyncAction('_MissionStoreBase.filterMissionList', context: context);

  @override
  Future<dynamic> filterMissionList(
      {required String userId, required dynamic param}) {
    return _$filterMissionListAsyncAction
        .run(() => super.filterMissionList(userId: userId, param: param));
  }

  @override
  String toString() {
    return '''
missionList: ${missionList},
service: ${service},
status: ${status}
    ''';
  }
}
