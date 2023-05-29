import 'package:flutter/material.dart';
import 'package:ticket/pages/Nav01.dart';
import 'package:ticket/pages/loginscreen.dart';
import 'package:ticket/pages/navitem2.dart';
import 'package:ticket/pages/navitem3.dart';
import 'package:ticket/pages/navitem4.dart';

import 'package:ticket/repository/customhelper.dart';

void main() => runApp(const Homepage());

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  final _pageController = PageController(initialPage: 0);
  int _selectedPage = 0;

  String fullname = '';

  @override
  void initState() {
    super.initState();
    fetchFullname();
  }

  Future<void> fetchFullname() async {
    try {
      final jsonData = await readJsonData(fullname);
      String name = jsonData['fullname'];
      setState(() {
        fullname = name;
      });
      print(fullname);
    } catch (e) {
      debugPrint('Error loading fullname: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (value) => setState(() => _selectedPage = value),
          children: const <Widget>[
            Nav01(
              fullName: '',
            ),
            NavItem2(),
            NavItem3(),
            NavItem4(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue[600],
          onTap: (value) {
            if (value == 2) {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.account_box_outlined),
                            title: Text(fullname),
                            onTap: () {},
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.list),
                            title: const Text('Logs'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.approval),
                            title: const Text('Approvals'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.report,
                              color: Colors.red,
                            ),
                            title: const Text('Report'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            title: const Text('Settings'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.logout_outlined,
                              color: Colors.black,
                            ),
                            title: const Text(
                              'Logout',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(
                                    'Thank you $fullname',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: const Text(
                                    'Please Come back again!',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text(
                                          'Okay',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              _pageController.animateToPage(
                value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Others',
            ),
          ],
        ),
      ),
    );
  }
}
