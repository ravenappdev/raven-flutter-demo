import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:raven_flutter_sdk/raven_flutter_sdk.dart';
import 'package:raven_flutter_test/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.appId,
    required this.apiKey,
  }) : super(key: key);

  final String title;
  final String appId;
  final String apiKey;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements RavenResponseCallback {
  String userID = "akshay-test-user-2";
  String userMobile = "9999999999";
  String userEmail = "example@gmail.com";
  String successTitle = "Success";
  String successBody = "Operation perfomed successfully";
  String errTitle = "Error";

  @override
  void onFailure(String? error) {
    _showDialog(errTitle, error.toString());
  }

  @override
  void onSuccess() {
    _showDialog(successTitle, successTitle);
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "This is local notif",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  void sendMessage() async {
    const eventName = "Flutter Raven";
    try {
      await RavenSdk.sendMessage(eventName, userID, this);
      _showDialog(successTitle, successTitle);
    } catch (e) {
      _showDialog(errTitle, e.toString());
    }
  }

  Future<void> setUser() async {
    try {
      await RavenSdk.setUser(userID, userMobile, userEmail);
      _showDialog(successTitle, successTitle);
    } catch (e) {
      _showDialog(errTitle, e.toString());
    }
  }

  Future<void> setEmail() async {
    try {
      await RavenSdk.setUserEmail(userID, userEmail);
      _showDialog(successTitle, successTitle);
    } catch (e) {
      _showDialog(errTitle, e.toString());
    }
  }

  Future<void> setToken() async {
    try {
      await RavenSdk.setDeviceToken(token);
      _showDialog(successTitle, successTitle);
    } catch (e) {
      _showDialog(errTitle, e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await RavenSdk.logout();
      _showDialog(successTitle, successTitle);
    } catch (e) {
      _showDialog(errTitle, e.toString());
    }
  }

  void _showDialog(String? title, String? body) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title ?? ""),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(body ?? "")],
              ),
            ),
          );
        });
  }

  String token = "";

  void _onMessageHandler(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    String notificationId = message.data["raven_notification_id"];

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    }

    RavenSdk.updateStatus(notificationId, Status.DELIVERED);
  }

  void _onMessageOpenHandler(RemoteMessage message) {
    String notificationId = message.data["raven_notification_id"];

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _showDialog(notification.title, notification.body);
    }

    RavenSdk.updateStatus(notificationId, Status.CLICKED);
  }

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _onMessageOpenHandler(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) => _onMessageOpenHandler(message));
  }

  @override
  void initState() {
    super.initState();

    // Foreground Notification Handling
    FirebaseMessaging.onMessage
        .listen((RemoteMessage message) => _onMessageHandler(message));

    // Interaction when clicked in background
    setupInteractedMessage();

    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        this.token = token ?? "";
      });
      print("token ============= > " + token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'FCM token = ' + token,
            ),
            OutlinedButton(onPressed: setUser, child: const Text("Set User")),
            OutlinedButton(
              onPressed: setToken,
              child: const Text("Set Device Token"),
            ),
            OutlinedButton(
                onPressed: sendMessage, child: const Text("Send Message")),
            OutlinedButton(
              onPressed: setEmail,
              child: const Text("Set Email"),
            ),
            OutlinedButton(
              onPressed: logOut,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
