import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  /// Lista de strings a ser usados en el DropDownCustom.
  final List<String>? items;

  /// Lista de widgets a ser usados en el DropDownCustom.
  final List<Widget>? children;

  /// Valor cambiante en el DropDownCustom.
  final ValueChanged<String>? onChanged;

  /// Color del submenu del DropDownCustom.
  final Color? submenuColor;

  /// Tamaño del submenu del DropDownCustom, por defecto es 300.
  final double? submenuWidth;

  /// Tamaño del botón base del DropDownCustom, por defecto es 300.
  final double? buttonWidth;

  /// Color del botón base del DropDownCustom.
  final Color? buttonColor;

  /// Titulo del botón base del DropDownCustom.
  final String? textButton;

  /// Icono del botón base del DropDownCustom.
  final IconData? iconButton;

  /// SVG del botón base del DropDownCustom.
  ///final SvgPicture? svgButton;

  /// Se usa para validar si se debe mostrar el icono del botón base del DropDownCustom.
  /// por defecto es false.
  final bool hideIcon;

  /// Valida si se necesitan los botones de soporte y version, por defecto es false.
  final bool actionButtons;

  const CustomDropdown({
    Key? key,
    this.items,
    this.children,
    this.onChanged,
    this.submenuColor,
    this.submenuWidth = 300,
    this.buttonWidth = 300,
    this.buttonColor,
    this.textButton,
    this.iconButton,
    //this.svgButton,
    this.hideIcon = false,
    this.actionButtons = false,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isOpen = false;

  void toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: toggle,
              child: Container(
                width: widget.buttonWidth,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: widget.buttonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.iconButton != null) Icon(widget.iconButton),
                    if (widget.textButton != null)
                      Text(widget.textButton ?? ""),
                    // if (widget.svgButton != null)
                    // widget.svgButton,
                    if (!widget.hideIcon)
                      RotatedBox(
                        quarterTurns: _isOpen ? -2 : 0,
                        child: const Icon(Icons.expand_more),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_isOpen)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.4),
                          offset: const Offset(0, 1095),
                          spreadRadius: 1000,
                          blurRadius: 200,
                        ),
                      ],
                    ),
                    width: widget.submenuWidth,
                    child: Card(
                      elevation: 24,
                      clipBehavior: Clip.hardEdge,
                      color: widget.submenuColor,
                      child: Column(
                        children: widget.children ??
                            widget.items!.map(
                              (item) {
                                return InkWell(
                                  onTap: () {
                                    widget.onChanged!(item);
                                    toggle();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.4),
                                          offset: const Offset(0, 1095),
                                          spreadRadius: 1000,
                                          blurRadius: 200,
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Text(item),
                                  ),
                                );
                              },
                            ).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.actionButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Botón de version.
                        SizedBox(
                          width: 72,
                          height: 56,
                          child: Text("b1"),
                          // child: FluwinButtonWidget(
                          //   contentPadding: const EdgeInsets.all(0),
                          //   buttonText: "v1.0.0",
                          //   onTap: widget.onTapVersion,
                          //   backgroundColor: context.colors.surface1(),
                          //   textColor: context.colors.onPrimaryContainer,
                          // ),
                        ),

                        /// Espacio entre los dos botones.
                        const SizedBox(
                          width: 8,
                        ),

                        /// Botón de soporte.
                        SizedBox(
                          width: 72,
                          height: 56,
                          child: Text("b2"),
                          // child: FluwinButtonWidget(
                          //   contentPadding: const EdgeInsets.all(0),
                          //   icon: const Icon(
                          //     Icons.support_agent_outlined,
                          //     size: 24,
                          //   ),
                          //   onTap: () {
                          //     //TODO: realizar pagina o enviar al soporte.
                          //   },
                          //   backgroundColor: context.colors.surface1(),
                          //   textColor: context.colors.onPrimaryContainer,
                          // ),
                        ),
                      ],
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
