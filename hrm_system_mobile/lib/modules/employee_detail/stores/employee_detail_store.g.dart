// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmployeeDetailStore on _EmployeeDetailStoreBase, Store {
  late final _$employeeDetailsAtom =
      Atom(name: '_EmployeeDetailStoreBase.employeeDetails', context: context);

  @override
  EmployeeDetailModel get employeeDetails {
    _$employeeDetailsAtom.reportRead();
    return super.employeeDetails;
  }

  @override
  set employeeDetails(EmployeeDetailModel value) {
    _$employeeDetailsAtom.reportWrite(value, super.employeeDetails, () {
      super.employeeDetails = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_EmployeeDetailStoreBase.service', context: context);

  @override
  EmployeeDetailService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(EmployeeDetailService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_EmployeeDetailStoreBase.status', context: context);

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
      Atom(name: '_EmployeeDetailStoreBase.store', context: context);

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

  late final _$getEmployeeDetailsAsyncAction = AsyncAction(
      '_EmployeeDetailStoreBase.getEmployeeDetails',
      context: context);

  @override
  Future<dynamic> getEmployeeDetails(String id) {
    return _$getEmployeeDetailsAsyncAction
        .run(() => super.getEmployeeDetails(id));
  }

  late final _$_EmployeeDetailStoreBaseActionController =
      ActionController(name: '_EmployeeDetailStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_EmployeeDetailStoreBaseActionController.startAction(
        name: '_EmployeeDetailStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_EmployeeDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
employeeDetails: ${employeeDetails},
service: ${service},
status: ${status},
store: ${store}
    ''';
  }
}
