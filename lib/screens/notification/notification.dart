import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../API/provider/notification_provider.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/notification';

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications when the screen is first initialized
    Provider.of<NotificationProvider>(context, listen: false)
        .fetchNotifications();
  }

  void doNothing(context) {}

  void actionOnNotification(
      BuildContext context, String notificationId, String reply) {
    setState(() {
      Provider.of<NotificationProvider>(context, listen: false)
          .replyToNotifications(notificationId, reply);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<NotificationProvider>(context, listen: false)
    //     .listenToSocketEvents(newNotification.toJson());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size.height * 0.02),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          final notifications = notificationProvider.notifications;
          return notifications != null && notifications.isNotEmpty
              ? ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: notification.type ==
                              "INCOMING_GROUP_INVITE"
                          ? ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 2,
                                  onPressed: (context) => actionOnNotification(
                                      context,
                                      "${notification.notificationId}",
                                      "accept"),
                                  backgroundColor:
                                      GlobalVariables.kPrimaryColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.check_box,
                                  label: 'Accept',
                                ),
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 2,
                                  onPressed: (context) => actionOnNotification(
                                      context,
                                      "${notification.notificationId}",
                                      "decline"),
                                  backgroundColor: const Color(0xFF4D4D4D),
                                  foregroundColor: Colors.white,
                                  icon: Icons.dangerous,
                                  label: 'Reject',
                                ),
                              ],
                            )
                          : ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                // SlidableAction(
                                //   onPressed: doNothing,
                                //   backgroundColor: const Color(0xFF21B7CA),
                                //   foregroundColor: Colors.white,
                                //   icon: Icons.share,
                                //   label: 'Share',
                                // ),
                              ],
                            ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: ListTile(
                        leading: Lottie.asset(
                          'assets/animations/Animation - 1712302998944.json',
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                        title: Text(
                          "${notification.message}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${notification.type?.replaceAll('_', " ")}",
                          overflow: TextOverflow.ellipsis,
                        ),
                        // trailing: notification.type == "INCOMING_GROUP_INVITE"
                        //     ? Column(
                        //       children: [
                        //         IconButton(
                        //             icon: const Icon(Icons.abc),
                        //             onPressed: () {},
                        //           ),
                        //       ],
                        //     )
                        //     : IconButton(
                        //         icon: const Icon(Icons.abc),
                        //         onPressed: () {},
                        //       ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/images/Push notifications-rafiki 1.png'),
                      ),
                      Text('Nothing yet, but stay tuned'),
                      Text(
                        'You’ll get group updates, event reminders, and new recommendations here.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
