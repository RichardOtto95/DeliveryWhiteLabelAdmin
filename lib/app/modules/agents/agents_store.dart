import 'package:mobx/mobx.dart';

part 'agents_store.g.dart';

class AgentsStore = _AgentsStoreBase with _$AgentsStore;
abstract class _AgentsStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}