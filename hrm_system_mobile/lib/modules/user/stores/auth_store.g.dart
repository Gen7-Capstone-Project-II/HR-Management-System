// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  late final _$userModelAtom =
      Atom(name: '_AuthStoreBase.userModel', context: context);

  @override
  UserModel? get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel? value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  late final _$loadingStatusAtom =
      Atom(name: '_AuthStoreBase.loadingStatus', context: context);

  @override
  LoadingStatus get loadingStatus {
    _$loadingStatusAtom.reportRead();
    return super.loadingStatus;
  }

  @override
  set loadingStatus(LoadingStatus value) {
    _$loadingStatusAtom.reportWrite(value, super.loadingStatus, () {
      super.loadingStatus = value;
    });
  }

  late final _$userServicesAtom =
      Atom(name: '_AuthStoreBase.userServices', context: context);

  @override
  UserServices get userServices {
    _$userServicesAtom.reportRead();
    return super.userServices;
  }

  @override
  set userServices(UserServices value) {
    _$userServicesAtom.reportWrite(value, super.userServices, () {
      super.userServices = value;
    });
  }

  late final _$signInAsyncAction =
      AsyncAction('_AuthStoreBase.signIn', context: context);

  @override
  Future<dynamic> signIn(String username, String password) {
    return _$signInAsyncAction.run(() => super.signIn(username, password));
  }

  late final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase', context: context);

  @override
  void setLoadingStatus(LoadingStatus status) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void signOut() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.signOut');
    try {
      return super.signOut();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userModel: ${userModel},
loadingStatus: ${loadingStatus},
userServices: ${userServices}
    ''';
  }
}
