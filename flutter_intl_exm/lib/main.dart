import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  await FlutterLocalization.instance.ensureInitialized();
  runApp(const IntlDemoApp());
}

class IntlDemoApp extends StatefulWidget {
  const IntlDemoApp({super.key});

  @override
  State<IntlDemoApp> createState() => _IntlDemoAppState();
}

class _IntlDemoAppState extends State<IntlDemoApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
        const MapLocale('fr', AppLocale.FR),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    WidgetsBinding.instance.addPostFrameCallback((s) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      locale: localization.currentLocale,
      title: 'Intl Package Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IntlDemoScreen(),
    );
  }
}

class IntlDemoScreen extends StatefulWidget {
  const IntlDemoScreen({super.key});

  @override
  _IntlDemoScreenState createState() => _IntlDemoScreenState();
}

class _IntlDemoScreenState extends State<IntlDemoScreen> {
  String _locale = 'en_US';
  final currentDate = DateTime.now();
  final number = 1234567.89;
  final percentage = 0.45;
  final FlutterLocalization localization = FlutterLocalization.instance;
  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
        const MapLocale('fr', AppLocale.FR),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

// the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  void _changeLocale(String locale) {
    setState(() {
      _locale = locale;
    });
    localization.translate(locale);
  }

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = _locale;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Intl Package Demo'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _changeLocale,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English (US)')),
              const PopupMenuItem(value: 'ar', child: Text('العربية')),
              const PopupMenuItem(value: 'fr', child: Text('Français')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Center(
                child: Text(
                  '🌍 Intl Package Features',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Date Formatting
              _buildSectionTitle('1. Date Formatting'),
              _buildCard(
                title: 'Formatted Date:',
                value: DateFormat(
                  'EEEE, d MMMM yyyy',
                ).format(currentDate),
              ),
              _buildCard(
                title: 'Formatted Time:',
                value: DateFormat(
                  'hh:mm a',
                ).format(currentDate),
              ),
              const SizedBox(height: 20),

              // Number Formatting
              _buildSectionTitle('2. Number Formatting'),
              _buildCard(
                title: 'Formatted Number:',
                value: NumberFormat(
                  '#,##0.00',
                ).format(number),
              ),
              _buildCard(
                title: 'Formatted Percentage:',
                value: NumberFormat.percentPattern().format(percentage),
              ),
              const SizedBox(height: 20),

              // Localization Placeholder
              _buildSectionTitle('3. Localization (Example Placeholder)'),
              _buildCard(
                title:
                    'Localized Greeting: need full restart to show the difference',
                value: AppLocale.title.getString(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
    );
  }

  Widget _buildCard({required String title, required String value}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

mixin AppLocale {
  static const String title = 'title';
  static const Map<String, dynamic> EN = {title: 'Hello , How Are You?'};
  static const Map<String, dynamic> AR = {title: 'مرحباً، كيف حالك؟'};
  static const Map<String, dynamic> FR = {title: 'Hi , pourque?'};
}
