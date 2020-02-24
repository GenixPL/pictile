import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pictile/ui/common/circle_button.dart';

class BasicPage extends StatelessWidget {
  final bool showBackArrow;
  final bool showWhiteBackground;
  final List<Widget> children;

  BasicPage({
    this.showBackArrow = true,
    this.showWhiteBackground = true,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildTop(context),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 64,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    if (showBackArrow)
                      CircleButton(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                'Pictile',
                style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Expanded(child: Row()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    BoxDecoration background;
    if (showWhiteBackground) {
      background = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
//        boxShadow: [
//          BoxShadow(
//            color: Colors.grey[200],
//            blurRadius: 2,
//          ),
//        ],
      );
    } else {
      background = BoxDecoration();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.grey[200],
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: background,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
