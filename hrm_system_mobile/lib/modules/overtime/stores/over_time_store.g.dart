// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'over_time_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OverTimeStore on _OverTimeStoreBase, Store {
  late final _$overTimeListAtom =
      Atom(name: '_OverTimeStoreBase.overTimeList', context: context);

  @override
  OverTimeListModel get overTimeList {
    _$overTimeListAtom.reportRead();
    return super.overTimeList;
  }

  @override
  set overTimeList(OverTimeListModel value) {
    _$overTimeListAtom.reportWrite(value, super.overTimeList, () {
      super.overTimeList = value;
    });
  }

  late final _$pendingOverTimeAtom =
      Atom(name: '_OverTimeStoreBase.pendingOverTime', context: context);

  @override
  OverTimeListModel get pendingOverTime {
    _$pendingOverTimeAtom.reportRead();
    return super.pendingOverTime;
  }

  @override
  set pendingOverTime(OverTimeListModel value) {
    _$pendingOverTimeAtom.reportWrite(value, super.pendingOverTime, () {
      super.pendingOverTime = value;
    });
  }

  late final _$approvedOverTimeAtom =
      Atom(name: '_OverTimeStoreBase.approvedOverTime', context: context);

  @override
  OverTimeListModel get approvedOverTime {
    _$approvedOverTimeAtom.reportRead();
    return super.approvedOverTime;
  }

  @override
  set approvedOverTime(OverTimeListModel value) {
    _$approvedOverTimeAtom.reportWrite(value, super.approvedOverTime, () {
      super.approvedOverTime = value;
    });
  }

  late final _$rejectedOverTimeAtom =
      Atom(name: '_OverTimeStoreBase.rejectedOverTime', context: context);

  @override
  OverTimeListModel get rejectedOverTime {
    _$rejectedOverTimeAtom.reportRead();
    return super.rejectedOverTime;
  }

  @override
  set rejectedOverTime(OverTimeListModel value) {
    _$rejectedOverTimeAtom.reportWrite(value, super.rejectedOverTime, () {
      super.rejectedOverTime = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_OverTimeStoreBase.service', context: context);

  @override
  OverTimeService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(OverTimeService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_OverTimeStoreBase.status', context: context);

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

  late final _$getOverTimeListAsyncAction =
      AsyncAction('_OverTimeStoreBase.getOverTimeList', context: context);

  @override
  Future<dynamic> getOverTimeList(String id) {
    return _$getOverTimeListAsyncAction.run(() => super.getOverTimeList(id));
  }

  late final _$filterOverTimeListAsyncAction =
      AsyncAction('_OverTimeStoreBase.filterOverTimeList', context: context);

  @override
  Future<dynamic> filterOverTimeList(
      {required String userId, required dynamic param}) {
    return _$filterOverTimeListAsyncAction
        .run(() => super.filterOverTimeList(userId: userId, param: param));
  }

  @override
  String toString() {
    return '''
overTimeList: ${overTimeList},
pendingOverTime: ${pendingOverTime},
approvedOverTime: ${approvedOverTime},
rejectedOverTime: ${rejectedOverTime},
service: ${service},
status: ${status}
    ''';
  }
}
