import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/main_provider.dart';
import 'package:provider/provider.dart';

import 'globals/utils.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) => Scaffold(
        body: (Global.allContacts.isEmpty)
            ? Center(
                child: Text(
                  'No any chats yet...',
                  style: TextStyle(
                    color: (provider.isDarkView) ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : Column(
                children: Global.allContacts
                    .map((e) => GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => Container(
                                height: 300,
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: Text(
                                        "${e.firstName![0].toUpperCase()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Text(
                                      "${e.firstName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {},
                                        ),
                                        MaterialButton(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        e.firstName![0].toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${e.firstName}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${e.chat}",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          (provider.selectedDate == "Pick Date")
                                              ? provider.selectedDate
                                                  .substring(0, 9)
                                              : provider.selectedDate
                                                  .substring(0, 10),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          (provider.selectedTime == "Pick Time")
                                              ? provider.selectedTime
                                                  .substring(0, 9)
                                              : provider.selectedTime
                                                  .substring(10, 15),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
