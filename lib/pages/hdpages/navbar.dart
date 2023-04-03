import 'package:flutter/material.dart';
import 'package:ticket/pages/navitem1.dart';
import 'package:ticket/pages/navitem2.dart';
import 'package:ticket/pages/navitem3.dart';

void main() => runApp(const Homepage());

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  final int _pageAmount = 3;
  final _pageController = PageController(initialPage: 0);
  int _selectedPage = 0;
  String _currentAccount = 'Account 1';
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
            NavItem1(),
            NavItem2(),
            NavItem3(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue[600],
          onTap: (value) {
            if (value == 2) {
              // Show user profile as a bottom modal sheet
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.list),
                            title: const Text('Logs'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.report),
                            title: const Text('Report'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.approval),
                            title: const Text('Approvals'),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text('Settings'),
                            onTap: () {},
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                          ExpansionTile(
                            leading: const Icon(Icons.account_circle),
                            title: const Text('Account'),
                            subtitle: Text(_currentAccount),
                            children: <Widget>[
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey[400],
                              ),
                              SizedBox(
                                height: 200.0,
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      leading: const Icon(Icons.account_circle),
                                      title: Text('Account ${index + 1}'),
                                      onTap: () {
                                        setState(() {
                                          _currentAccount =
                                              'Account ${index + 1}';
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              // Navigate to the corresponding page
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
