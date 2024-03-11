import 'package:flutter/material.dart';
import '../../API/controller/friend.controller.dart';
import '../../API/models/friends.model.dart';
import '../../utils/global_variabes.dart';

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
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Find People', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.02),
                  ),
                  centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
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
    return Material(
      color: GlobalVariables.kPrimaryColor,
      borderRadius: BorderRadius.circular(18),
      elevation: 1,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (value) => {
                _searchUsers(_searchController.text)
        },
              controller: _searchController,
              style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: GlobalVariables.kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Icon(
              Icons.search,
              color: GlobalVariables.kPrimaryColor,
              size: 18,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(top: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: GlobalVariables.kPrimaryColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          hintText: 'Search for Users',
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 158, 158, 158),
            fontSize: 15,
          ),
        ),
              onChanged: _onSearchTextChanged,
            ),
          ),
          
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {
          //     _searchUsers(_searchController.text);
          //   },
          // ),
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
