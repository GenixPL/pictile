import 'package:flutter/material.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/themes/text_styles.dart';

import 'package:pictile/ui/common/basic_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: _buildQuote()),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildHomeButton(
                          text: 'SHOW',
                          onTap: () => Navigator.pushNamed(
                            context,
                            showMenuRoute,
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildHomeButton(
                          text: 'MANAGE',
                          onTap: () => Navigator.pushNamed(
                            context,
                            manageMenuRoute,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuote() {
    final text =
        '"The point isn\'t to win the game. The point is to play a beautiful game."';

    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'RobotoSlab',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildHomeButton({String text, Function() onTap}) {
    return OutlineButton(
      child: Text(text, style: smallBlackTextStyle),
      splashColor: Colors.white,
      highlightedBorderColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      borderSide: BorderSide(
        width: 2,
      ),
      padding: EdgeInsets.all(0),
      onPressed: onTap,
    );
  }
}
