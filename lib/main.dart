import 'package:flutter/material.dart';
import 'package:platform_converter/chats_page.dart';
import 'package:platform_converter/main_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Switch(
              value: Provider.of<MainProvider>(context, listen: false).isIOS,
              onChanged: (val) {
                Provider.of<MainProvider>(context, listen: false)
                    .changePlatform();
              },
            ),
          ],
          title: Text("Platform Converter"),
        ),
        body: Column(
          children: [
            BottomNavigationBar(
              currentIndex: 0,
              items: [
                BottomNavigationBarItem(
                  label: "ADD",
                  icon: Icon(
                    Icons.account_circle_rounded,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Chats",
                  icon: Icon(
                    Icons.chat_rounded,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Calls",
                  icon: Icon(
                    Icons.call_end_rounded,
                  ),
                ),
                // BottomNavigationBarItem(
                //   label: "Settings",
                //   icon: Icon(
                //     Icons.settings,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
