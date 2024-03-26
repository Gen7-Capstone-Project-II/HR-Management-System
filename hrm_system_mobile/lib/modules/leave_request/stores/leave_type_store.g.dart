// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LeaveTypeStore on _LeaveTypeStoreBase, Store {
  late final _$leaveTypeListAtom =
      Atom(name: '_LeaveTypeStoreBase.leaveTypeList', context: context);

  @override
  LeaveTypeListModel get leaveTypeList {
    _$leaveTypeListAtom.reportRead();
    return super.leaveTypeList;
  }

  @override
  set leaveTypeList(LeaveTypeListModel value) {
    _$leaveTypeListAtom.reportWrite(value, super.leaveTypeList, () {
      super.leaveTypeList = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_LeaveTypeStoreBase.service', context: context);

  @override
  LeaveTypeService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(LeaveTypeService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_LeaveTypeStoreBase.status', context: context);

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

  late final _$getLeaveTypeListAsyncAction =
      AsyncAction('_LeaveTypeStoreBase.getLeaveTypeList', context: context);

  @override
  Future<dynamic> getLeaveTypeList() {
    return _$getLeaveTypeListAsyncAction.run(() => super.getLeaveTypeList());
  }

  late final _$_LeaveTypeStoreBaseActionController =
      ActionController(name: '_LeaveTypeStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_LeaveTypeStoreBaseActionController.startAction(
        name: '_LeaveTypeStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_LeaveTypeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
leaveTypeList: ${leaveTypeList},
service: ${service},
status: ${status}
    ''';
  }
}
