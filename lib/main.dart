import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';

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
  int index = 0;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (Provider.of<MainProvider>(context, listen: false).isDarkView)
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(
              useMaterial3: true,
            ),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<MainProvider>(context, listen: false).changeTheme();
              },
              icon: Icon(CupertinoIcons.sun_min),
            ),
            (Provider.of<MainProvider>(context, listen: false).isIOS)
                ? CupertinoSwitch(
                    onChanged: (val) {
                      Provider.of<MainProvider>(context, listen: false)
                          .changePlatform();
                    },
                    value: Provider.of<MainProvider>(context).isIOS,
                  )
                : Switch(
                    value:
                        Provider.of<MainProvider>(context, listen: false).isIOS,
                    onChanged: (val) {
                      Provider.of<MainProvider>(context, listen: false)
                          .changePlatform();
                    },
                  ),
          ],
          title: const Text("Platform Converter"),
        ),
        body: DefaultTabController(
          length: 4,
          child: Consumer<MainProvider>(
            builder: (context, provider, child) => Column(
              children: [
                TabBar(
                  onTap: (int val) {
                    index = val;

                    provider.pageList.elementAt(val);

                    // ignore: avoid_print
                    print(val);
                  },
                  tabs: const [
                    Tab(
                      icon: Icon(
                        Icons.person_add_alt_1_outlined,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "CHATS",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "CALLS",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "SETTINGS",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                // CustomScrollView(
                //   slivers: [
                //     provider.pageList.elementAt(index),
                //   ],
                //
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
