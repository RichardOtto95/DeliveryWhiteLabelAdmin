import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'firebase_options.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/shared/color_theme.dart';
import 'app/shared/utilities.dart';
import 'dart:math' as math;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Intl.defaultLocale = 'pt_BR';

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  colors = WidgetsBinding.instance.window.platformBrightness == Brightness.light
      ? MyThemes.lightTheme.colorScheme
      : MyThemes.darkTheme.colorScheme;

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stacked list example',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Stacked list example"),
            backgroundColor: Colors.black,
          ),
          body: StackedList()),
    );
  }
}

class StackedList extends StatelessWidget {
  final List<Color> _colors = Colors.primaries;
  static const _minHeight = 16.0;
  static const _maxHeight = 120.0;

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: _colors
            .map(
              (color) => StackedListChild(
                minHeight: _minHeight,
                maxHeight: _colors.indexOf(color) == _colors.length - 1
                    ? MediaQuery.of(context).size.height
                    : _maxHeight,
                pinned: true,
                child: Container(
                  color: _colors.indexOf(color) == 0
                      ? Colors.black
                      : _colors[_colors.indexOf(color) - 1],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(_minHeight)),
                      color: color,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );
}

class StackedListChild extends StatelessWidget {
  final double minHeight;
  final double maxHeight;
  final bool pinned;
  final bool floating;
  final Widget child;

  SliverPersistentHeaderDelegate get _delegate => _StackedListDelegate(
      minHeight: minHeight, maxHeight: maxHeight, child: child);

  const StackedListChild({
    Key? key,
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.pinned = false,
    this.floating = false,
  })  : assert(child != null),
        assert(minHeight != null),
        assert(maxHeight != null),
        assert(pinned != null),
        assert(floating != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
      key: key, pinned: pinned, floating: floating, delegate: _delegate);
}

class _StackedListDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StackedListDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StackedListDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
