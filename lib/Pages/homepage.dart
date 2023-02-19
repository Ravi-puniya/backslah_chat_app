

import 'package:backslah_chat_app/Pages/auth/login_page.dart';
import 'package:backslah_chat_app/Pages/profile_page.dart';
import 'package:backslah_chat_app/Pages/search_page.dart';
import 'package:backslah_chat_app/services/authservice.dart';
import 'package:backslah_chat_app/services/database_service.dart';
import 'package:backslah_chat_app/widget/grouptile.dart';
import 'package:backslah_chat_app/widget/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();
  String groupnamw = '';
  Stream? groups;

  @override
  void initState() {
    super.initState();
    getUserdata();
  }


  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  getUserdata() async {
    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUsergroup()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextscreen(context, SearchPage());
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Groupi',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            const Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'UserName',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              onTap: () {},
              leading: const Icon(Icons.group),
              title: const Text('Groups'),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              // onTap: () {
              //   nextscreen(context, ProfilePage());
              // },
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Log Out'),
                      content: const Text('Are you sure to logout?'),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel_sharp,
                              color: Colors.red,
                            )),
                        IconButton(
                          onPressed: () async {
                            authService.signout().whenComplete(() {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false);
                            });
                          },
                          icon: Icon(Icons.done),
                          color: Colors.green,
                        )
                      ],
                    );
                  },
                );
              },
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
            )
          ],
        ),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          popUpDialog(context);
        },
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: () async {
                  if (groupnamw != "") {
                    DatabaseServices(
                            uid: FirebaseAuth.instance.currentUser!.uid)
                        .creatGroup(groupnamw,
                            FirebaseAuth.instance.currentUser!.uid, 'null')
                        .whenComplete(() {
                      Navigator.of(context).pop();
                    });
                  }
                },
                icon: Icon(
                  Icons.done,
                  color: Colors.green,
                ))
          ],
          elevation: 0,
          shape: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(20)),
          title: const Text('Create a group'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    groupnamw = value;
                  });
                },
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            return ListView.builder(
              itemCount: snapshot.data['groups'].length,
              itemBuilder: (context, index) {
                return GroupTile(groupId: getId(snapshot.data['groups'][index]), groupName: getName(snapshot.data['groups'][index]), username: snapshot.data['fullName']);
              },
            );
          } else {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          }
        } else {
          return Center(
            child: Text('No Group found'),
          );
        }
      },
    );
  }
}
