import 'package:mobx/mobx.dart';

part 'sellers_store.g.dart';

class SellersStore = _SellersStoreBase with _$SellersStore;
abstract class _SellersStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}