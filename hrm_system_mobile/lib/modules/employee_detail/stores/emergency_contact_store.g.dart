// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmergencyContactStore on _EmergencyContactStoreBase, Store {
  late final _$emergencyContactsAtom = Atom(
      name: '_EmergencyContactStoreBase.emergencyContacts', context: context);

  @override
  AllEmergencyContactModel get emergencyContacts {
    _$emergencyContactsAtom.reportRead();
    return super.emergencyContacts;
  }

  @override
  set emergencyContacts(AllEmergencyContactModel value) {
    _$emergencyContactsAtom.reportWrite(value, super.emergencyContacts, () {
      super.emergencyContacts = value;
    });
  }

  late final _$servicesAtom =
      Atom(name: '_EmergencyContactStoreBase.services', context: context);

  @override
  EmergencyContactService get services {
    _$servicesAtom.reportRead();
    return super.services;
  }

  @override
  set services(EmergencyContactService value) {
    _$servicesAtom.reportWrite(value, super.services, () {
      super.services = value;
    });
  }

  late final _$relativeTypeListModelAtom = Atom(
      name: '_EmergencyContactStoreBase.relativeTypeListModel',
      context: context);

  @override
  RelativeTypeListModel get relativeTypeListModel {
    _$relativeTypeListModelAtom.reportRead();
    return super.relativeTypeListModel;
  }

  @override
  set relativeTypeListModel(RelativeTypeListModel value) {
    _$relativeTypeListModelAtom.reportWrite(value, super.relativeTypeListModel,
        () {
      super.relativeTypeListModel = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_EmergencyContactStoreBase.state', context: context);

  @override
  LoadingStatus get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(LoadingStatus value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$storeAtom =
      Atom(name: '_EmergencyContactStoreBase.store', context: context);

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

  late final _$getEmergencyContactAsyncAction = AsyncAction(
      '_EmergencyContactStoreBase.getEmergencyContact',
      context: context);

  @override
  Future<dynamic> getEmergencyContact(String userId) {
    return _$getEmergencyContactAsyncAction
        .run(() => super.getEmergencyContact(userId));
  }

  late final _$getRelativeTypeListAsyncAction = AsyncAction(
      '_EmergencyContactStoreBase.getRelativeTypeList',
      context: context);

  @override
  Future<dynamic> getRelativeTypeList() {
    return _$getRelativeTypeListAsyncAction
        .run(() => super.getRelativeTypeList());
  }

  late final _$_EmergencyContactStoreBaseActionController =
      ActionController(name: '_EmergencyContactStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_EmergencyContactStoreBaseActionController
        .startAction(name: '_EmergencyContactStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_EmergencyContactStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emergencyContacts: ${emergencyContacts},
services: ${services},
relativeTypeListModel: ${relativeTypeListModel},
state: ${state},
store: ${store}
    ''';
  }
}
