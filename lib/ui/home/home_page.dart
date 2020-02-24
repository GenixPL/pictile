import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/basic_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      showBackArrow: false,
      showWhiteBackground: false,
      children: <Widget>[
        Expanded(
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "The point isn't to win the game. The point is to play a beautiful game.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                        child: Text('SHOW', style: whiteTextStyle),
                        splashColor: Colors.white,
                        highlightedBorderColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        padding: EdgeInsets.all(0),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          showMenuRoute,
                        ),
                      ),
                      SizedBox(height: 8),
                      OutlineButton(
                        child: Text('MANAGE', style: whiteTextStyle),
                        splashColor: Colors.white,
                        highlightedBorderColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        padding: EdgeInsets.all(0),
                        onPressed: () => Navigator.pushNamed(
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
      ],
    );
  }
}
