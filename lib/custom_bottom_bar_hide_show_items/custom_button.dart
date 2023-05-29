import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CustomButton(
      {required this.icon, required this.label, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: isSelected ? Colors.green : Colors.black,
          ),
          child: IconButton(
            icon: Icon(widget.icon),
            onPressed: () {
              setState(() {
                isSelected = true;
              });
              widget.onPressed();
            },
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12.0,
            color: isSelected ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
