import 'package:mobx/mobx.dart';

part 'customers_store.g.dart';

class CustomersStore = _CustomersStoreBase with _$CustomersStore;
abstract class _CustomersStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}