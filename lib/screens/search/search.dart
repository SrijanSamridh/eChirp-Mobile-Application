import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../API/controller/friend.controller.dart';
import '../../API/models/friends.model.dart';
import '../../utils/global_variabes.dart';
import '../friends/components/custom_tile.dart';

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
        title: Text(
          'Find People',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size.height * 0.02),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSearchBar(),
          ),
          const SizedBox(height: 16),
          _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Material(
      color: GlobalVariables.colors.primary,
      borderRadius: BorderRadius.circular(18),
      elevation: 1,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (value) =>
                  {_searchUsers(_searchController.text)},
              controller: _searchController,
              style: const TextStyle(
                color: Colors.black,
              ),
              cursorColor: GlobalVariables.colors.primary,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(
                    Icons.search,
                    color: GlobalVariables.colors.primary,
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
                  borderSide: BorderSide(
                    color: GlobalVariables.colors.primary,
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
                hintText: 'Search for people',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 158, 158, 158),
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
    Size size = MediaQuery.of(context).size;
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
                final data = searchResults[index];
                return CustomTile(
                  title: data.username!,
                  subTitle: 'Potential Friend Subtitle',
                  image: data.profilePicture ?? '',
                  mutuals: '1', // Dummy data
                  myFriend: false,
                  id: data.id!,
                );
              },
            );
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/Animation - 1712302998944.json',
                    height: size.height * 0.35),
                const Text("Opps! No result Found."),
              ],
            ));
          }
        },
      ),
    );
  }
}
