import 'package:flutter/material.dart';
import 'package:flutter_test_widgets/files/drop_custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          /// switch
          Container(
            color: Colors.red,
            child: Switch(value: null != 0, onChanged: (bool newvalue) {}),
          ),

          /// dropdown custom
          Container(
            padding: const EdgeInsets.only(top: 54),
            child: CustomDropdown(
              items: const [
                "1",
                "2",
              ],
              submenuColor: Colors.red,
              buttonColor: Colors.yellow,
              textButton: 'Selecciona una opción',
              onChanged: (String) {
                "hola";
              },
              children: const [
                Icon(Icons.abc),
                Icon(Icons.abc),
                Icon(Icons.abc),
              ],
            ),
          ),

          /// contenedor mobible
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            builder: (context, controller) => ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: const [
                      Text(
                        "1",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "2",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "3",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "4",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "5",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "6",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "7",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "8",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "9",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "10",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "11",
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        "12",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// menu
        ],
      ),
    );
  }
}
