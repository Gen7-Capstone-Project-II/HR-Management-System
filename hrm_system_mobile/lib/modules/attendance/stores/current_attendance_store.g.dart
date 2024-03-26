// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_attendance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurrentAttendanceStore on _CurrentAttendanceStoreBase, Store {
  late final _$currentAttendanceAtom = Atom(
      name: '_CurrentAttendanceStoreBase.currentAttendance', context: context);

  @override
  CurrentAttendanceModel get currentAttendance {
    _$currentAttendanceAtom.reportRead();
    return super.currentAttendance;
  }

  @override
  set currentAttendance(CurrentAttendanceModel value) {
    _$currentAttendanceAtom.reportWrite(value, super.currentAttendance, () {
      super.currentAttendance = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_CurrentAttendanceStoreBase.status', context: context);

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

  late final _$serviceAtom =
      Atom(name: '_CurrentAttendanceStoreBase.service', context: context);

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

  late final _$getCurrentAttendanceAsyncAction = AsyncAction(
      '_CurrentAttendanceStoreBase.getCurrentAttendance',
      context: context);

  @override
  Future<dynamic> getCurrentAttendance(
      {required String id, required String month}) {
    return _$getCurrentAttendanceAsyncAction
        .run(() => super.getCurrentAttendance(id: id, month: month));
  }

  @override
  String toString() {
    return '''
currentAttendance: ${currentAttendance},
status: ${status},
service: ${service}
    ''';
  }
}
