import 'package:flutter/material.dart' as material;

class Text extends material.StatelessWidget {
  const Text({
    required this.text,
    super.key
  });

  final String text;

  @override
  material.Widget build(material.BuildContext context) {
    return material.Text(text);
  }
}
