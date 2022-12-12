import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _baseUrlProvider = Provider((ref) => dotenv.env['BASE_URL']!);
final _publicKeyProvider = Provider((ref) => dotenv.env['PUBLIC_KEY']!);
final _privateKeyProvider = Provider((ref) => dotenv.env['PRIVATE_KEY']!);
final _dioProvider = Provider((ref) {
  final baseUrl = ref.watch(_baseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
});
final heroesRepositoryProvider = Provider((ref) {
  final publicKey = ref.watch(_publicKeyProvider);
  final apiClient = ref.watch(_dioProvider);
  final privateKey = ref.watch(_privateKeyProvider);
  return HeroesRepositoryImpl(publicKey, privateKey, apiClient: apiClient);
});

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
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
          icon: 'launch_background',
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await dotenv.load(fileName: '.env');

  runApp(const ProviderScope(child: App()));
}
