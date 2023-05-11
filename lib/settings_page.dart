import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/main_provider.dart';
import 'package:platform_converter/settings_page_ios.dart';
import 'package:provider/provider.dart';
import 'add_contact_page.dart';
import 'globals/models.dart';
import 'globals/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

GlobalKey<FormState> addProfileKey = GlobalKey();

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (Provider.of<MainProvider>(context, listen: false).isDarkView)
          ? ThemeData.dark(
              useMaterial3: true,
            )
          : ThemeData.light(
              useMaterial3: true,
            ),
      home: Consumer<MainProvider>(
        builder: (context, provider, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                ListTile(
                  trailing: Switch(
                      value: provider.isUpdate,
                      onChanged: (val) {
                        provider.changeStatus();
                      }),
                  title: const Text("Profile"),
                  leading: Icon(
                    Icons.person,
                    color: (provider.isDarkView) ? Colors.white : null,
                    size: 30,
                  ),
                  subtitle: const Text("Update Profile Data"),
                ),
                (provider.isUpdate)
                    ? SizedBox(
                        child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Options"),
                                    ),
                                    content: const Text(
                                      "Choose an option to add photo",
                                    ),
                                    icon: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    ),
                                    actions: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                child: Text(
                                                  "Camera",
                                                ),
                                                onPressed: () async {
                                                  XFile? img =
                                                      await picker.pickImage(
                                                    source: ImageSource.camera,
                                                  );

                                                  setState(() {
                                                    Global.profileImage = File(
                                                        img!.path as String);
                                                  });

                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ElevatedButton(
                                                child: Text("Gallery"),
                                                onPressed: () async {
                                                  XFile? img =
                                                      await picker.pickImage(
                                                    source: ImageSource.gallery,
                                                  );

                                                  setState(() {
                                                    Global.profileImage = File(
                                                        img!.path as String);
                                                  });

                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: const Color(0xffeadeff),
                              radius: 70,
                              foregroundImage: (Global.profileImage != null)
                                  ? FileImage(Global.profileImage as File)
                                  : null,
                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                size: 40,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                          Form(
                            key: addProfileKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: profileNameController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Your Name...",
                                    ),
                                    onSaved: (val) {
                                      Global.profileName = val;
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Enter First Name First....";
                                      }
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    onSaved: (val) {
                                      Global.bio = val;
                                    },
                                    controller: bioController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Bio...",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                child: const Text("Save"),
                                onPressed: () {
                                  () {
                                    if (addContactKey.currentState!
                                        .validate()) {
                                      addContactKey.currentState!.save();

                                      Contact c1 = Contact(
                                        firstName: Global.firstName,
                                        phone: Global.phone,
                                        chat: Global.chat,
                                        image: Global.image,
                                      );
                                      Global.allContacts.add(c1);
                                    }

                                    setState(
                                      () {
                                        addContactKey.currentState!.reset();

                                        profileNameController.clear();
                                        bioController.clear();

                                        Global.firstName = null;
                                        Global.bio = null;
                                      },
                                    );
                                  };
                                },
                              ),
                              TextButton(
                                child: const Text("Clear"),
                                onPressed: () {
                                  setState(() {
                                    profileNameController.clear();
                                    bioController.clear();
                                    Global.profileName == null;
                                    Global.bio == null;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ))
                    : Container(),
                Divider(
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                ListTile(
                  trailing: Switch(
                    value: provider.isDarkView,
                    onChanged: (val) {
                      setState(() {
                        provider.changeTheme();
                      });
                    },
                  ),
                  title: const Text("Theme"),
                  leading: Icon(
                    color: (provider.isDarkView) ? Colors.white : null,
                    Icons.wb_sunny_outlined,
                    size: 30,
                  ),
                  subtitle: const Text("Change Theme"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
