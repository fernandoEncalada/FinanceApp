import 'package:finance_app/src/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FinanceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(color: Colors.indigo),
        ),
        home: TabsPage()
      ),
    );
  }
}