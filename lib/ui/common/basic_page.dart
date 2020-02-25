import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {
  final List<Widget> children;

  BasicPage({
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: children,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Pictile',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontWeight: FontWeight.w600,
          letterSpacing: 4,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
