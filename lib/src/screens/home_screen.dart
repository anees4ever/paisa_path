import 'package:flutter/foundation.dart';
import 'package:paisa_path/src/controllers/summary_controller.dart';
import 'package:paisa_path/src/screens/custom_widgets/update_check.dart';
import 'package:paisa_path/src/core/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/custom_widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:paisa_path/src/screens/expense_entry_screen.dart';
import 'package:paisa_path/src/screens/home_screen_tab_dashboard.dart';
import 'package:paisa_path/src/screens/home_screen_tab_expenses_list.dart';
import 'package:paisa_path/src/screens/home_screen_tab_settings.dart';
import 'package:paisa_path/src/screens/home_screen_tab_summary.dart';
import 'package:paisa_path/src/core/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Strings.current.appName,
      changeStyle: kDebugMode,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: PageView(
                controller: _pageController,
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DashboardScreen(callbackToSetPage: callbackToSetPage),
                  const SummaryScreen(),
                  const ExpensesListScreen(),
                  const SettingsScreen(),
                ],
              ),
            ),
          ),
          const UpdateChecker(),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          bool? result = await ExpenseEntryScreen.show(null);
          if (result ?? false) {
            SummaryController.refreshIf();
          }
        },
        shape: const CircleBorder(
          side: BorderSide(
            color: fontColorHightlightDark,
            width: 2,
          ),
        ),
        elevation: 4,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 8,
        child: Row(
          //children inside bottom appbar
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.dashboard,
                  color: currentPage == 0
                      ? fontColorError.theme
                      : fontColorHightlightDark),
              onPressed: () => currentPage = 0,
            ),
            IconButton(
              icon: Icon(Icons.pie_chart,
                  color: currentPage == 1
                      ? fontColorError.theme
                      : fontColorHightlightDark),
              onPressed: () => currentPage = 1,
            ),
            const SizedBox.square(dimension: 32),
            IconButton(
              icon: Icon(Icons.list,
                  color: currentPage == 2
                      ? fontColorError.theme
                      : fontColorHightlightDark),
              onPressed: () => currentPage = 2,
            ),
            IconButton(
              icon: Icon(Icons.settings,
                  color: currentPage == 3
                      ? fontColorError.theme
                      : fontColorHightlightDark),
              onPressed: () => currentPage = 3,
            ),
          ],
        ),
      ),
    );
  }

  callbackToSetPage(int page) {
    currentPage = page;
  }

  set currentPage(int value) {
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int get currentPage =>
      _pageController.hasClients ? _pageController.page?.round() ?? 0 : -1;
}
