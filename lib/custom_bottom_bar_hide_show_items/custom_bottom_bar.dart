import 'package:flutter/material.dart';
import 'package:flutter_test_widgets/custom_bottom_bar_hide_show_items/custom_button.dart';

class CustomBottomBar extends StatelessWidget {
  final List<IconData> icons; // Lista de íconos para los botones
  final List<String> labels; // Lista de etiquetas para los botones
  final List<VoidCallback> actions; // Lista de acciones para los botones

  CustomBottomBar({
    required this.icons,
    required this.labels,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // Barra inferior
      child: Padding(
        // Agregamos padding para el espaciado de los botones
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Wrap(
          // Utilizamos Wrap para colocar los botones en una línea
          alignment: WrapAlignment
              .spaceBetween, // Distribución uniforme de los botones
          children:
              _buildButtonList(context), // Construimos la lista de botones
        ),
      ),
    );
  }

  List<Widget> _buildButtonList(BuildContext context) {
    final double iconSize = 24.0;
    final double maxWidth = MediaQuery.of(context).size.width;
    final int maxVisibleItems = (maxWidth / (iconSize + 32)).floor();

    List<Widget> buttons = [];
    for (int i = 0; i < maxVisibleItems && i < icons.length; i++) {
      buttons.add(
        CustomButton(
          icon: icons[i],
          label: labels[i],
          onPressed: actions[i],
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
                    onTap: actions[index + maxVisibleItems],
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
