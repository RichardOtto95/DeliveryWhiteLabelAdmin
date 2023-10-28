import 'package:mobx/mobx.dart';

part 'attendence_store.g.dart';

class AttendenceStore = _AttendenceStoreBase with _$AttendenceStore;
abstract class _AttendenceStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}