import 'package:finance_app/src/screens/expense_screen.dart';
import 'package:finance_app/src/screens/loan_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: const _Screens(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        currentIndex: navigationModel.actualScreen,
        onTap: (i) => navigationModel.actualScreen = i,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.money_off), label: 'Expenses'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Loans'),
        ]);
  }
}

class _Screens extends StatelessWidget {
  const _Screens({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ExpenseScreen(),
        LoanScreen(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _actualScreen = 0;
  final PageController _pageController = PageController();

  int get actualScreen => _actualScreen;

  set actualScreen(int value) {
    _actualScreen = value;
    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
