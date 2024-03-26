// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LeaveRequestStore on _LeaveRequestStoreBase, Store {
  late final _$leaveRequestListAtom =
      Atom(name: '_LeaveRequestStoreBase.leaveRequestList', context: context);

  @override
  LeaveRequestModelList get leaveRequestList {
    _$leaveRequestListAtom.reportRead();
    return super.leaveRequestList;
  }

  @override
  set leaveRequestList(LeaveRequestModelList value) {
    _$leaveRequestListAtom.reportWrite(value, super.leaveRequestList, () {
      super.leaveRequestList = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_LeaveRequestStoreBase.service', context: context);

  @override
  LeaveRequestService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(LeaveRequestService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_LeaveRequestStoreBase.status', context: context);

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

  late final _$storeAtom =
      Atom(name: '_LeaveRequestStoreBase.store', context: context);

  @override
  ScanToLoginStore get store {
    _$storeAtom.reportRead();
    return super.store;
  }

  @override
  set store(ScanToLoginStore value) {
    _$storeAtom.reportWrite(value, super.store, () {
      super.store = value;
    });
  }

  late final _$getLeaveRequestListAsyncAction = AsyncAction(
      '_LeaveRequestStoreBase.getLeaveRequestList',
      context: context);

  @override
  Future<dynamic> getLeaveRequestList(String id) {
    return _$getLeaveRequestListAsyncAction
        .run(() => super.getLeaveRequestList(id));
  }

  late final _$filterLeaveRequestListAsyncAction = AsyncAction(
      '_LeaveRequestStoreBase.filterLeaveRequestList',
      context: context);

  @override
  Future<dynamic> filterLeaveRequestList(
      {required String userId, required dynamic param}) {
    return _$filterLeaveRequestListAsyncAction
        .run(() => super.filterLeaveRequestList(userId: userId, param: param));
  }

  @override
  String toString() {
    return '''
leaveRequestList: ${leaveRequestList},
service: ${service},
status: ${status},
store: ${store}
    ''';
  }
}
