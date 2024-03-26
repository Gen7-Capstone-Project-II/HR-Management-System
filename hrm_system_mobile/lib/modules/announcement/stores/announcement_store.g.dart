// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnouncementStore on _AnnouncementStoreBase, Store {
  late final _$announcementModelAtom =
      Atom(name: '_AnnouncementStoreBase.announcementModel', context: context);

  @override
  AnnouncementModel get announcementModel {
    _$announcementModelAtom.reportRead();
    return super.announcementModel;
  }

  @override
  set announcementModel(AnnouncementModel value) {
    _$announcementModelAtom.reportWrite(value, super.announcementModel, () {
      super.announcementModel = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_AnnouncementStoreBase.status', context: context);

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
      Atom(name: '_AnnouncementStoreBase.service', context: context);

  @override
  AnnouncementService get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(AnnouncementService value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$getAnnouncementAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getAnnouncement', context: context);

  @override
  Future<dynamic> getAnnouncement() {
    return _$getAnnouncementAsyncAction.run(() => super.getAnnouncement());
  }

  late final _$_AnnouncementStoreBaseActionController =
      ActionController(name: '_AnnouncementStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_AnnouncementStoreBaseActionController.startAction(
        name: '_AnnouncementStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_AnnouncementStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
announcementModel: ${announcementModel},
status: ${status},
service: ${service}
    ''';
  }
}
