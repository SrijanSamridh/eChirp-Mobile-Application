import 'package:flutter/material.dart';
import 'package:echirp/API/controller/friend.controller.dart';
import 'package:echirp/components/custom_search_bar.dart';
import '../../API/models/friends.model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<Friends>?> _searchResults = Future.value([]);
  final friendController = FriendController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find People'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(),
            SizedBox(height: 16),
            FutureBuilder<List<Friends>?>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final searchResults = snapshot.data!;
                  return _buildSearchResults(searchResults);
                } else {
                  return Center(child: Text('No search results'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Users',
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  _searchUsers(query);
                } else {
                  setState(() {
                    _searchResults = Future.value([]);
                  });
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchUsers(_searchController.text);
            },
          ),
        ],
      ),
    );
  }

  void _searchUsers(String query) {
    setState(() {
      _searchResults = friendController.searchPeople('/search', query);
    });
  }

  Widget _buildSearchResults(List<Friends> searchResults) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index].username ?? ''),
            subtitle: Text(searchResults[index].bio ?? ''),
            // Add onTap functionality as needed
          );
        },
      ),
    );
  }
}
