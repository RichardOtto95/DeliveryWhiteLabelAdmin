import 'package:delivery_admin_white_label/app/modules/attendence/attendence_Page.dart';
import 'package:delivery_admin_white_label/app/modules/attendence/attendence_store.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AttendenceModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AttendenceStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AttendencePage()),
  ];

  @override
  Widget get view => AttendencePage();
}
