import 'package:flutter/material.dart';
import 'package:remember_switch/shared_perfs_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Switch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isActive;
  PreferenceUtils _instance;
  @override
  void initState() {
    _instance = PreferenceUtils.instance;
    _isActive = _instance.getValue<bool>("value") ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You are ${_isActive ? "Active" : "off the grid"}.",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Switch.adaptive(
                value: _isActive,
                onChanged: (value) async {
                  setState(() => _isActive = value);
                  await _instance.saveValueWithKey<bool>("value", value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
