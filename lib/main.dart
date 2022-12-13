import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';
import 'package:local_data_storage/local_data_storage.dart';
import 'firebase_options.dart';
import 'src/app.dart';

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

final connectivityProvider = Provider((ref) => Connectivity());

final localDataStorageProvider = Provider((ref) {
  final storage = LocalDataStorage();
  return storage;
});
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await dotenv.load(fileName: '.env');

  runApp(const ProviderScope(child: App()));
}
