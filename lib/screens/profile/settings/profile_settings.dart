import 'package:echirp/API/provider/user_provider.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  static const String routeName = '/profile-settings';
  const ProfileSettings({super.key, this.loggedUser = true, required this.id});

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
    return Scaffold(
      appBar: AppBar(title: const Text("General"),),
      body: Column(children: [
        Card(
          child: Row(children: [
            Image.network("${_userProvider.userData?.user?.provider}")
          ],),
        )
      ],),
    );
  }
}