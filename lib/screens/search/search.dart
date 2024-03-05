import 'package:flutter/material.dart';
import '../../API/controller/friend.controller.dart';
import '../../API/models/friends.model.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  final String query;

  const SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Friends>?> _searchResults = Future.value([]);
  final friendController = FriendController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
    _searchUsers(widget.query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find People'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildSearchResults(),
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
              decoration: const InputDecoration(
                hintText: 'Search Users',
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
              ),
              onChanged: _onSearchTextChanged,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _searchUsers(_searchController.text);
            },
          ),
        ],
      ),
    );
  }

  void _onSearchTextChanged(String query) {
    if (query.isNotEmpty) {
      _searchUsers(query);
    } else {
      setState(() {
        _searchResults = Future.value([]);
      });
    }
  }

  Future<void> _searchUsers(String query) async {
    setState(() {
      _searchResults = friendController.searchPeople('/search', query);
    });
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: FutureBuilder<List<Friends>?>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final searchResults = snapshot.data!;
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index].username ?? ''),
                  subtitle: Text(searchResults[index].bio ?? ''),
                  // Add onTap functionality as needed
                );
              },
            );
          } else {
            return const Center(child: Text('No search results'));
          }
        },
      ),
    );
  }
}
