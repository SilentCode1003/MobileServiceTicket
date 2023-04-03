import 'package:flutter/material.dart';

class NavItem2 extends StatefulWidget {
  const NavItem2({Key? key}) : super(key: key);

  @override
  NavItem2State createState() => NavItem2State();
}

class NavItem2State extends State<NavItem2> {
  List<Map<String, dynamic>> stores = [
    {
      'name': 'Store A',
      'number': '1234',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'name': 'Store B',
      'number': '5678',
      'description': 'Pellentesque habitant morbi tristique senectus et netus.'
    },
    {
      'name': 'Store C',
      'number': '9101',
      'description': 'Mauris id enim id nulla dictum dapibus nec eu nulla.'
    },
    {
      'name': 'Store D',
      'number': '1121',
      'description': 'Aliquam eget metus quis justo rhoncus mattis a eu ipsum.'
    },
    {
      'name': 'Store E',
      'number': '3141',
      'description': 'Proin quis odio sed lacus imperdiet hendrerit id eu quam.'
    },
  ];

  String filter = '';

  @override
  Widget build(BuildContext context) {
    final filteredStores = stores.where((store) {
      return store['name'].toLowerCase().contains(filter.toLowerCase()) ||
          store['number'].toLowerCase().contains(filter.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search for a store...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStores.length,
              itemBuilder: (context, index) {
                final store = filteredStores[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreDetailsPage(store: store),
                        ),
                      );
                    },
                    title: Text(store['name']),
                    subtitle: Text(store['number']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StoreDetailsPage extends StatelessWidget {
  final Map<String, dynamic> store;

  const StoreDetailsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(store['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Store Number: ${store['number']}'),
            const SizedBox(height: 16.0),
            Text('Description: ${store['description']}'),
          ],
        ),
      ),
    );
  }
}
