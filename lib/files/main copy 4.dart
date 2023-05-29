import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.settings,
    Icons.person,
    Icons.email,
    Icons.camera,
    Icons.favorite,
    Icons.music_note,
    Icons.movie,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: _buildButtonList(context),
      ),
    );
  }

  List<Widget> _buildButtonList(BuildContext context) {
    final double iconSize = 24.0;
    final double maxWidth = MediaQuery.of(context).size.width;
    final int maxVisibleItems = (maxWidth / (iconSize + 32)).floor();

    print('Max Visible Items: $maxVisibleItems');

    List<Widget> buttons = [];
    for (int i = 0; i < maxVisibleItems && i < icons.length; i++) {
      buttons.add(
        IconButton(
          icon: Icon(icons[i]),
          onPressed: () {
            // Acción cuando se presiona un botón
          },
        ),
      );
    }

    if (icons.length > maxVisibleItems) {
      buttons.add(
        PopupMenuButton<int>(
          icon: Icon(Icons.more_horiz),
          itemBuilder: (context) {
            return List.generate(
              icons.length - maxVisibleItems,
              (index) {
                return PopupMenuItem(
                  value: index + maxVisibleItems,
                  child: ListTile(
                    leading: Icon(icons[index + maxVisibleItems]),
                    onTap: () {
                      // Acción cuando se presiona un botón del menú desplegable
                    },
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return buttons;
  }
}

// Ejemplo de uso:
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Bottom Bar Example'),
        ),
        body: Container(),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
