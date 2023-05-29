import 'package:flutter/material.dart';

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
    const double iconSize = 24.0; // Tamaño de los íconos
    final double maxWidth =
        MediaQuery.of(context).size.width; // Ancho máximo de la pantalla
    final int maxVisibleItems = (maxWidth / (iconSize + 32))
        .floor(); // Cálculo de la cantidad máxima de botones visibles

    List<Widget> buttons = []; // Lista de widgets para los botones
    for (int i = 0; i < maxVisibleItems && i < icons.length; i++) {
      buttons.add(
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), // Borde redondeado
                color: Colors.black, // Color de fondo negro
              ),
              child: IconButton(
                icon: Icon(icons[i]), // Ícono del botón
                onPressed: actions[i], // Acción al presionar el botón
                color: Colors.white, // Color del ícono blanco
              ),
            ),
            const SizedBox(
                height: 4.0), // Espaciado entre el ícono y la etiqueta
            Text(
              labels[i], // Etiqueta del botón
              style: const TextStyle(fontSize: 12.0), // Estilo de la etiqueta
            ),
          ],
        ),
      );
    }

    if (icons.length > maxVisibleItems) {
      // Si hay más íconos que los visibles
      buttons.add(
        PopupMenuButton<int>(
          // Botón "ver más" con menú emergente
          icon: const Icon(Icons.more_horiz), // Ícono "más"
          itemBuilder: (context) {
            return List.generate(
              icons.length - maxVisibleItems, // Generamos los ítems adicionales
              (index) {
                return PopupMenuItem(
                  value: index + maxVisibleItems,
                  child: ListTile(
                    leading: Icon(icons[
                        index + maxVisibleItems]), // Ícono del ítem adicional
                    onTap: actions[
                        index + maxVisibleItems], // Acción del ítem adicional
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return buttons; // Retornamos la lista de botones
  }
}
