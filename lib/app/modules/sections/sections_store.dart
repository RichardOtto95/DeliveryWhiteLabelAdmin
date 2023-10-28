import 'package:mobx/mobx.dart';

part 'sections_store.g.dart';

class SectionsStore = _SectionsStoreBase with _$SectionsStore;
abstract class _SectionsStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}