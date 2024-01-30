import 'package:paisa_path/src/screens/custom_widgets/update_check.dart';
import 'package:paisa_path/src/localization/flutter_lang.dart';
import 'package:paisa_path/src/screens/custom_widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:paisa_path/src/screens/expense_entry_screen.dart';
import 'package:paisa_path/src/screens/home_screen_tab_dashboard.dart';
import 'package:paisa_path/src/screens/home_screen_tab_summary.dart';
import 'package:paisa_path/src/theme/colors.dart';

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
      changeStyle: true,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: PageView(
                controller: _pageController,
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DashboardScreen(),
                  SummaryScreen(),
                  Text('Page 3'),
                  Text('Page 4'),
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
            currentPage = 0;
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
        height: 48,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 12,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.dashboard, color: fontColorHightlightDark),
              onPressed: () => currentPage = 0,
            ),
            IconButton(
              icon: const Icon(Icons.add_chart, color: fontColorHightlightDark),
              onPressed: () => currentPage = 1,
            ),
            const SizedBox(width: 32),
            IconButton(
              icon: const Icon(Icons.list, color: fontColorHightlightDark),
              onPressed: () => currentPage = 2,
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: fontColorHightlightDark),
              onPressed: () => currentPage = 3,
            ),
          ],
        ),
      ),
    );
  }

  set currentPage(int value) {
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
