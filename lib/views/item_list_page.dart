import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/item_viewmodel.dart';
import '../viewmodels/user_viewmodel.dart';
import 'item_detail_page.dart';
import 'item_search_delegate.dart';
import 'login_page.dart';

class ItemListPage extends StatefulWidget {
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  @override
  void initState() {
    super.initState();
    final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);
    itemViewModel.fetchItems();
  }

  void _logout(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemViewModel = Provider.of<ItemViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD54F),
        title: Text(
          'Recipe',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ItemSearchDelegate());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFFD54F),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: itemViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : itemViewModel.items.isEmpty
          ? Center(child: Text('Resep tidak ada'))
          : ListView.builder(
        itemCount: itemViewModel.items.length,
        itemBuilder: (context, index) {
          final item = itemViewModel.items[index];
          return Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              leading: Image.network(
                item.image,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              title: Text(
                item.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Source: ${item.source}',
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailPage(recipe: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
