import 'package:echirp/API/provider/user_provider.dart';
import 'package:echirp/components/custom_btn.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/auth.dart';

class ProfileSettings extends StatefulWidget {
  static const String routeName = '/profile-settings';
  const ProfileSettings({
    super.key,
    required this.id,
    this.loggedUser = true,
  });

  final String id;
  final bool loggedUser;

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    _initProfileData();
  }

  Future<void> _initProfileData() async {
    await _userProvider.fetchUserData(widget.id, widget.loggedUser);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 2)),
      ),
      body: FutureBuilder(
        future: _userProvider.profileData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final userData = snapshot.data;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Card(
                          margin: EdgeInsets.only(bottom: size.height * 0.03),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8.0),
                            child: Row(
                              children: [
                                userData?.profilePicture != '' ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      "${userData?.profilePicture}",
                                      height: size.height * 0.06,
                                    )) : CircleAvatar(
                                      radius: size.height * 0.03,
                                        child: Center(
                                          child: Text(
                                            (userData?.username)
                                                .toString()
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData?.firstName == ''
                                          ? (userData?.username).toString()
                                          : "${userData?.firstName} ${userData?.lastName}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Text('Artist')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Card(
                            shadowColor: GlobalVariables.kPrimaryColor,
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('Edit profile',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              trailing: Icon(Icons.arrow_circle_right),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomBtn(
                        text: 'Logout',
                        size: size,
                        onPressed: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.remove('x-auth-token');
                          pref.remove('_id');
                          pref.remove('username');
                          Navigator.pushNamedAndRemoveUntil(
                              // ignore: use_build_context_synchronously
                              context,
                              AuthScreen.routeName,
                              (route) => false);
                        })
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No user data available'));
          }
        },
      ),
    );
  }
}
