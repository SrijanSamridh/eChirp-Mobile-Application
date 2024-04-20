import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../API/provider/notification_provider.dart';


class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final notifications = notificationProvider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: notifications != null && notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  leading: Lottie.asset(
                    'assets/animations/Animation - 1712302998944.json',
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  title: Text(notification.message.toString()),
                  subtitle: Text(notification.notificationId.toString(), overflow: TextOverflow.ellipsis,),
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
