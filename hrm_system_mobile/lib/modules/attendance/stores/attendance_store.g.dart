// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AttendanceStore on _AttendanceStoreBase, Store {
  late final _$attendanceListAtom =
      Atom(name: '_AttendanceStoreBase.attendanceList', context: context);

  @override
  AttendanceListModel get attendanceList {
    _$attendanceListAtom.reportRead();
    return super.attendanceList;
  }

  @override
  set attendanceList(AttendanceListModel value) {
    _$attendanceListAtom.reportWrite(value, super.attendanceList, () {
      super.attendanceList = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_AttendanceStoreBase.service', context: context);

  @override
  AttendanceService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(AttendanceService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_AttendanceStoreBase.status', context: context);

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

  late final _$scanToLoginStoreAtom =
      Atom(name: '_AttendanceStoreBase.scanToLoginStore', context: context);

  @override
  ScanToLoginStore get scanToLoginStore {
    _$scanToLoginStoreAtom.reportRead();
    return super.scanToLoginStore;
  }

  @override
  set scanToLoginStore(ScanToLoginStore value) {
    _$scanToLoginStoreAtom.reportWrite(value, super.scanToLoginStore, () {
      super.scanToLoginStore = value;
    });
  }

  late final _$getAttendanceListAsyncAction =
      AsyncAction('_AttendanceStoreBase.getAttendanceList', context: context);

  @override
  Future<dynamic> getAttendanceList(String id, String month) {
    return _$getAttendanceListAsyncAction
        .run(() => super.getAttendanceList(id, month));
  }

  late final _$_AttendanceStoreBaseActionController =
      ActionController(name: '_AttendanceStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_AttendanceStoreBaseActionController.startAction(
        name: '_AttendanceStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_AttendanceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
attendanceList: ${attendanceList},
service: ${service},
status: ${status},
scanToLoginStore: ${scanToLoginStore}
    ''';
  }
}
