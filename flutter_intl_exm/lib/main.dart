import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  await initializeDateFormatting('ar', null);
  runApp(const IntlDemoApp());
}

class IntlDemoApp extends StatelessWidget {
  const IntlDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  void _changeLocale(String locale) {
    setState(() {
      _locale = locale;
    });
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
              const PopupMenuItem(value: 'en_US', child: Text('English (US)')),
              const PopupMenuItem(value: 'ar', child: Text('العربية')),
              const PopupMenuItem(value: 'fr_FR', child: Text('Français')),
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
                title: 'Localized Greeting:',
                value: 'مرحبًا! كيف حالك؟',
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
