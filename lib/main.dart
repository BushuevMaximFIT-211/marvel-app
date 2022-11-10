import 'package:flutter/material.dart';
import 'package:marvel_app/src/features/detailed_heroes/view/detailed_hero_page.dart';
// import 'package:marvel_app/pages/detail_page.dart';
import 'package:marvel_app/src/features/heroes/view/heroes_page.dart';
// import 'package:marvel_app/pages/home_page.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroes_repository/heroes_repository.dart';

final _baseUrlProvider = Provider((ref) => dotenv.env['BASE_URL']!);
final _apiKeyProvider = Provider((ref) => dotenv.env['PUBLIC_KEY']!);
final _hashProvider = Provider((ref) => dotenv.env['HASH']!);
final _dioProvider = Provider((ref) {
  final baseUrl = ref.watch(_baseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
});
final heroesRepositoryProvider = Provider((ref) {
  final apiKey = ref.watch(_apiKeyProvider);
  final apiClient = ref.watch(_dioProvider);
  final hash = ref.watch(_hashProvider);
  return HeroesRepositoryImpl(
    apiClient: apiClient,
    apiKey: apiKey,
    hash: hash,
  );
});

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HeroesPage.routeName: (context) => const HeroesPage(),
        DetailedHeroPage.routeName: (context) => const DetailedHeroPage()
      },
      theme: ThemeData(),
      initialRoute: HeroesPage.routeName,
    );
  }
}
