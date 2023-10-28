import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_admin_white_label/app/core/models/transaction_model.dart';
import 'package:delivery_admin_white_label/app/modules/financial/widgets/financial_data_source.dart';
import 'package:mobx/mobx.dart';

part 'financial_store.g.dart';

class FinancialStore = _FinancialStoreBase with _$FinancialStore;

abstract class _FinancialStoreBase with Store {
  final int rowsPerPage = 25;

  @observable
  bool selectMonth = false;
  @observable
  int monthSelected = DateTime.now().month;
  @observable
  ObservableList<TransactionM> transactions = <TransactionM>[].asObservable();
  @observable
  FinancialDataSource? financialDataSource;

  @action
  void setSelectMonth(_selectMonth) => selectMonth = _selectMonth;
  @action
  void setMonthSelected(_monthSelected) => monthSelected = _monthSelected;
  @action
  double getPageCount() => transactions.length / rowsPerPage;

  @action
  Future<void> setFinancialDataSource({String? sellerId}) async {
    if (sellerId == null) {
      final transQue = await FirebaseFirestore.instance
          .collection("transactions")
          .orderBy("created_at", descending: true)
          .get();

      for (DocumentSnapshot transDoc in transQue.docs) {
        transactions.add(TransactionM.fromDoc(transDoc));
      }
    } else {}
    financialDataSource = FinancialDataSource(transactions);
  }
}
