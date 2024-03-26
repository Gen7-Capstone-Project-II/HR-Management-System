// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_to_login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScanToLoginStore on _ScanToLoginStoreBase, Store {
  late final _$userModelAtom =
      Atom(name: '_ScanToLoginStoreBase.userModel', context: context);

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
      Atom(name: '_ScanToLoginStoreBase.loadingStatus', context: context);

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

  late final _$scanToLoginServiceAtom =
      Atom(name: '_ScanToLoginStoreBase.scanToLoginService', context: context);

  @override
  ScanToLoginService get scanToLoginService {
    _$scanToLoginServiceAtom.reportRead();
    return super.scanToLoginService;
  }

  @override
  set scanToLoginService(ScanToLoginService value) {
    _$scanToLoginServiceAtom.reportWrite(value, super.scanToLoginService, () {
      super.scanToLoginService = value;
    });
  }

  late final _$signInAsyncAction =
      AsyncAction('_ScanToLoginStoreBase.signIn', context: context);

  @override
  Future<dynamic> signIn({required String token, required String userId}) {
    return _$signInAsyncAction
        .run(() => super.signIn(token: token, userId: userId));
  }

  late final _$_ScanToLoginStoreBaseActionController =
      ActionController(name: '_ScanToLoginStoreBase', context: context);

  @override
  void setLoadingStatus(LoadingStatus status) {
    final _$actionInfo = _$_ScanToLoginStoreBaseActionController.startAction(
        name: '_ScanToLoginStoreBase.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_ScanToLoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void signOut() {
    final _$actionInfo = _$_ScanToLoginStoreBaseActionController.startAction(
        name: '_ScanToLoginStoreBase.signOut');
    try {
      return super.signOut();
    } finally {
      _$_ScanToLoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userModel: ${userModel},
loadingStatus: ${loadingStatus},
scanToLoginService: ${scanToLoginService}
    ''';
  }
}
