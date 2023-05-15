import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/main_provider.dart';
import 'package:provider/provider.dart';
import 'add_contact_page.dart';
import 'globals/models.dart';
import 'globals/utils.dart';

class SettingsPageIOS extends StatefulWidget {
  const SettingsPageIOS({super.key});

  @override
  State<SettingsPageIOS> createState() => _SettingsPageIOSState();
}

TextEditingController bioController = TextEditingController();
TextEditingController profileNameController = TextEditingController();

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
                trailing: CupertinoSwitch(
                    value: provider.isUpdate,
                    onChanged: (val) {
                      setState(() {
                        provider.changeStatus();
                      });
                    }),
                title: const Text("Profile"),
                leading: Icon(
                  CupertinoIcons.person,
                  size: 30,
                  color: Colors.blue,
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
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => Container(
                                  color: Colors.white,
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CupertinoButton(
                                        child: Text(
                                          "Camera",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        onPressed: () async {
                                          XFile? img = await picker.pickImage(
                                            source: ImageSource.camera,
                                          );

                                          setState(() {
                                            Global.profileImage =
                                                File(img!.path as String);
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text(
                                          "Photos",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        onPressed: () async {
                                          XFile? img = await picker.pickImage(
                                            source: ImageSource.gallery,
                                          );

                                          setState(() {
                                            Global.profileImage =
                                                File(img!.path as String);
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text(
                                          "Close",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        alignment: AlignmentDirectional.topEnd,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 70,
                              foregroundImage: (Global.profileImage != null)
                                  ? FileImage(Global.profileImage as File)
                                  : null,
                              child: const Icon(
                                CupertinoIcons.camera,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Form(
                            key: addContactKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Enter First Name",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  CupertinoTextFormFieldRow(
                                    controller: profileNameController,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: (provider.isDarkView)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    onSaved: (val) {
                                      Global.profileName = val;
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Enter Name First....";
                                      }
                                      return null;
                                    },
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Enter Your Bio...",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  CupertinoTextFormFieldRow(
                                    onSaved: (val) {
                                      Global.bio = val;
                                    },
                                    controller: bioController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: (provider.isDarkView)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
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
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
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

                                        firstNameController.clear();
                                        bioController.clear();

                                        Global.firstName = null;
                                        Global.bio = null;
                                      },
                                    );
                                  };
                                },
                              ),
                              CupertinoButton(
                                child: const Text(
                                  "Clear",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
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
                      ),
                    )
                  : Container(),
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
                  CupertinoIcons.sun_min,
                  size: 30,
                  color: Colors.blue,
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
