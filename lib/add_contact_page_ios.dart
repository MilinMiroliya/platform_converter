import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/globals/utils.dart';
import 'package:provider/provider.dart';
import 'add_contact_page.dart';
import 'globals/models.dart';
import 'main_provider.dart';

class AddContactPageIOS extends StatefulWidget {
  const AddContactPageIOS({Key? key}) : super(key: key);

  @override
  State<AddContactPageIOS> createState() => _AddContactPageIOSState();
}

ImagePicker picker = ImagePicker();

TextStyle hintStyle = const TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

class _AddContactPageIOSState extends State<AddContactPageIOS> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) => CupertinoPageScaffold(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    // onTap: () async {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: const Align(
                    //           alignment: Alignment.topLeft,
                    //           child: Text("Options"),
                    //         ),
                    //         content: const Text(
                    //           "Choose an option to add photo",
                    //         ),
                    //         icon: Align(
                    //           alignment: Alignment.topRight,
                    //           child: IconButton(
                    //             onPressed: () {
                    //               Navigator.of(context).pop();
                    //             },
                    //             icon: const Icon(Icons.clear),
                    //           ),
                    //         ),
                    //         actions: [
                    //           Column(
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceEvenly,
                    //                 children: [
                    //                   ElevatedButton(
                    //                     child: const Text(
                    //                       "Camera",
                    //                     ),
                    //                     onPressed: () async {
                    //                       XFile? img = await picker.pickImage(
                    //                         source: ImageSource.camera,
                    //                       );
                    //
                    //                       setState(() {
                    //                         Global.image =
                    //                             File(img!.path as String);
                    //                       });
                    //
                    //                       Navigator.of(context).pop();
                    //                     },
                    //                   ),
                    //                   ElevatedButton(
                    //                     child: Text("Gallery"),
                    //                     onPressed: () async {
                    //                       XFile? img = await picker.pickImage(
                    //                         source: ImageSource.gallery,
                    //                       );
                    //
                    //                       setState(() {
                    //                         Global.image =
                    //                             File(img!.path as String);
                    //                       });
                    //
                    //                       Navigator.of(context).pop();
                    //                     },
                    //                   )
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   );
                    // },
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
                                    Global.image = File(img!.path as String);
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
                                    Global.image = File(img!.path as String);
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
                      radius: 60,
                      foregroundImage: (Global.image != null)
                          ? FileImage(Global.image as File)
                          : null,
                      child: Icon(
                        CupertinoIcons.camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
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
                        controller: firstNameController,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: (provider.isDarkView)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        onSaved: (val) {
                          Global.firstName = val;
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
                      const Text(
                        "Enter Phone Number",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      CupertinoTextFormFieldRow(
                        onSaved: (val) {
                          Global.phone = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Phone Number First....";
                          }
                          if (val.length != 10) {
                            return "Enter Correct Phone Number....";
                          }
                          return null;
                        },
                        controller: phoneNumberController,
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
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Enter Chat Conversation",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      CupertinoTextFormFieldRow(
                        onSaved: (val) {
                          Global.chat = val;
                        },
                        controller: chatsConversationController,
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
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.calendar),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 300,
                          width: double.infinity,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            minimumYear: 1900,
                            maximumYear: 3000,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (val) {
                              setState(
                                () {
                                  provider.selectedDate = val.toString();
                                },
                              );
                              // print(provider.selectedDate);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      (provider.selectedDate == "Pick Date")
                          ? provider.selectedDate.substring(0, 9)
                          : provider.selectedDate.substring(0, 10),
                      style: TextStyle(
                        color:
                            (Provider.of<MainProvider>(context, listen: false)
                                    .isDarkView)
                                ? Colors.white
                                : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.clock),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 300,
                          width: double.infinity,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            use24hFormat: false,
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (time) => setState(
                              () {
                                provider.selectedTime = time.toString();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      // provider.selectedTime,
                      (provider.selectedTime == "Pick Time")
                          ? provider.selectedTime.substring(0, 9)
                          : provider.selectedTime.substring(10, 15),
                      style: TextStyle(
                        color:
                            (Provider.of<MainProvider>(context, listen: false)
                                    .isDarkView)
                                ? Colors.white
                                : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                color: (provider.isDarkView) ? Colors.blue : Colors.blue,
                onPressed: () {
                  if (addContactKey.currentState!.validate()) {
                    addContactKey.currentState!.save();

                    Contact c1 = Contact(
                      firstName: Global.firstName,
                      phone: Global.phone,
                      chat: Global.chat,
                      image: Global.image,
                    );
                    Global.allContacts.add(c1);
                  }
                  print(Global.firstName);
                  print(Global.phone);
                  print(Global.chat);

                  setState(
                    () {
                      addContactKey.currentState!.reset();

                      firstNameController.clear();
                      phoneNumberController.clear();
                      chatsConversationController.clear();
                    },
                  );
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
