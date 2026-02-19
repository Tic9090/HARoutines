import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shortcut 2 URL GET', home: const TextBoxPage());
  }
}

class TextBoxPage extends StatefulWidget {
  const TextBoxPage({super.key});

  @override
  State<TextBoxPage> createState() => _TextBoxPageState();
}

class _TextBoxPageState extends State<TextBoxPage> {
  final TextEditingController namebox1 = TextEditingController();
  final TextEditingController urlbox1 = TextEditingController();
  final TextEditingController namebox2 = TextEditingController();
  final TextEditingController urlbox2 = TextEditingController();
  final TextEditingController namebox3 = TextEditingController();
  final TextEditingController urlbox3 = TextEditingController();
  final TextEditingController namebox4 = TextEditingController();
  final TextEditingController urlbox4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _loadSavedData(); // wait until data is loaded
    _initializeQuickActions(); // now shortcuts have correct values
  }

  void _initializeQuickActions() {
    final QuickActions quickActions = const QuickActions();
    quickActions.initialize((String shortcutType) async {
      if (shortcutType == 'action_1') {
        await http.get(Uri.parse(urlbox1.text));
        SystemNavigator.pop();
      }
      if (shortcutType == 'action_2') {
        await http.get(Uri.parse(urlbox2.text));
        SystemNavigator.pop();
      }
      if (shortcutType == 'action_3') {
        await http.get(Uri.parse(urlbox3.text));
        SystemNavigator.pop();
      }
      if (shortcutType == 'action_4') {
        await http.get(Uri.parse(urlbox4.text));
        SystemNavigator.pop();
      }
    });

    quickActions.setShortcutItems([
      ShortcutItem(type: 'action_1', localizedTitle: namebox1.text),
      ShortcutItem(type: 'action_2', localizedTitle: namebox2.text),
      ShortcutItem(type: 'action_3', localizedTitle: namebox3.text),
      ShortcutItem(type: 'action_4', localizedTitle: namebox4.text),
    ]);
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      namebox1.text = prefs.getString('namebox1') ?? '';
      urlbox1.text = prefs.getString('urlbox1') ?? '';
      namebox2.text = prefs.getString('namebox2') ?? '';
      urlbox2.text = prefs.getString('urlbox2') ?? '';
      namebox3.text = prefs.getString('namebox3') ?? '';
      urlbox3.text = prefs.getString('urlbox3') ?? '';
      namebox4.text = prefs.getString('namebox4') ?? '';
      urlbox4.text = prefs.getString('urlbox4') ?? '';
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('namebox1', namebox1.text);
    await prefs.setString('urlbox1', urlbox1.text);
    await prefs.setString('namebox2', namebox2.text);
    await prefs.setString('urlbox2', urlbox2.text);
    await prefs.setString('namebox3', namebox3.text);
    await prefs.setString('urlbox3', urlbox3.text);
    await prefs.setString('namebox4', namebox4.text);
    await prefs.setString('urlbox4', urlbox4.text);

    //Refresh shortcuts after saving new data
    _initializeQuickActions();
  }

  Future<void> _testButton() async {
    // await http.get(
    //   Uri.parse(
    //     "https://assistant.stpn.cc/api/webhook/toggle-max-light-webhook-yUK8PH7MXUTXopWiqQeigMTV",
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shortcut 2 URL GET")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namebox1,
              decoration: const InputDecoration(labelText: "Name 1"),
            ),
            TextField(
              controller: urlbox1,
              decoration: const InputDecoration(labelText: "URL 1"),
            ),
            TextField(
              controller: namebox2,
              decoration: const InputDecoration(labelText: "Name 2"),
            ),
            TextField(
              controller: urlbox2,
              decoration: const InputDecoration(labelText: "URL 2"),
            ),
            TextField(
              controller: namebox3,
              decoration: const InputDecoration(labelText: "Name 3"),
            ),
            TextField(
              controller: urlbox3,
              decoration: const InputDecoration(labelText: "URL 3"),
            ),
            TextField(
              controller: namebox4,
              decoration: const InputDecoration(labelText: "Name 4"),
            ),
            TextField(
              controller: urlbox4,
              decoration: const InputDecoration(labelText: "URL 4"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveData, child: const Text("Save")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _testButton, child: const Text("Test")),
          ],
        ),
      ),
    );
  }
}
