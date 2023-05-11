import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/main_provider.dart';
import 'package:provider/provider.dart';

class SettingsPageIOS extends StatefulWidget {
  const SettingsPageIOS({super.key});

  @override
  State<SettingsPageIOS> createState() => _SettingsPageIOSState();
}

class _SettingsPageIOSState extends State<SettingsPageIOS> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) => CupertinoPageScaffold(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              ListTile(
                trailing: CupertinoSwitch(value: true, onChanged: (val) {}),
                title: const Text("Profile"),
                leading: Icon(
                  Icons.person,
                  size: 30,
                  color: (provider.isDarkView) ? Colors.white : null,
                ),
                subtitle: const Text("Update Profile Data"),
              ),
              const Divider(
                height: 2,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                trailing: CupertinoSwitch(
                  value: provider.isDarkView,
                  onChanged: (val) {
                    setState(
                      () {
                        provider.isDarkView = !provider.isDarkView;
                      },
                    );
                  },
                ),
                title: const Text("Theme"),
                leading: Icon(
                  Icons.wb_sunny_outlined,
                  size: 30,
                  color: (provider.isDarkView) ? Colors.white : null,
                ),
                subtitle: const Text("Change Theme"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
