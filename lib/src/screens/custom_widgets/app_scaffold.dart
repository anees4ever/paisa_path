import 'package:paisa_path/src/core/theme/dimens.dart';
import 'package:paisa_path/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppScaffold extends StatefulWidget {
  final String title;
  final List<Widget> actions;
  final Widget body;
  final bool changeStyle;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottomChild;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    super.key,
    required this.title,
    this.actions = const [],
    required this.body,
    this.changeStyle = false,
    this.automaticallyImplyLeading = true,
    this.bottomChild,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    this.bottomNavigationBar,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
        title: Text(widget.title),
        bottom: widget.bottomChild,
        actions: [
          if (widget.changeStyle) getAppStyleChanger(),
          ...widget.actions,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(appDefaultPadding),
        child: widget.body,
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget getAppStyleChanger() {
    return GetX<ThemeController>(builder: (controller) {
      return Switch(
        value: controller.currentThemeMode.value == ThemeMode.dark,
        onChanged: (value) => controller.toggleTheme(),
      );
    });
  }
}
