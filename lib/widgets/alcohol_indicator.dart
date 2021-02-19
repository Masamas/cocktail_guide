import 'package:flutter/material.dart';

class AlcoholIndicator extends StatelessWidget {
  final String alcoholic;

  const AlcoholIndicator({this.alcoholic});

  Widget _buildIcon() {
    if (alcoholic == 'Alcoholic') {
      return Icon(Icons.check, color: Colors.red);
    } else {
      return Icon(Icons.close, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: _buildIcon(),
    );
  }
}
