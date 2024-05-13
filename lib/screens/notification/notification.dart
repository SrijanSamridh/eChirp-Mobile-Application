import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:echirp/API/models/notification.model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../API/provider/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/notification';

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationProvider _notificationProvider = NotificationProvider();
  List<NotificationElement>? notifications;
  @override
  void initState() {
    super.initState();
    initNotification();
  }

  Future<void> initNotification() async {
    setState(() {
      notifications = _notificationProvider.notifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    _notificationProvider;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeNotifications().createNotification(
              content: NotificationContent(id: 1, channelKey: "basic_channel", title: "Hello World!", body: "Yay! I have Local Notifications working now!"));
        },
        child: const Icon(Icons.notification_add),
      ),
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      // ignore: prefer_is_empty
      body: notifications != null && notifications?.length != 0
          ? ListView.builder(
              itemCount: notifications?.length,
              itemBuilder: (context, index) {
                final notification = notifications?[index];
                return ListTile(
                  leading: Lottie.asset(
                    'assets/animations/Animation - 1712302998944.json',
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  title: Text("${notification?.message}"),
                  subtitle: Text(
                    "${notification?.notificationId}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.abc),
                    onPressed: () {},
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Push notifications-rafiki 1.png'),
                  const Text('Nothing yet, but stay tuned'),
                  const Text(
                    'You’ll get group updates, event reminders, and new recommendations here.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
