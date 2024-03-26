import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';
part 'connectivity_store.g.dart';

// ignore: library_private_types_in_public_api
class ConnectivityStore = _ConnectivityStoreBase with _$ConnectivityStore;

abstract class _ConnectivityStoreBase with Store {
  @observable
  ObservableStream<ConnectivityResult> connectivityResult = ObservableStream(Connectivity().onConnectivityChanged);
}
