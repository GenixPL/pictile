import 'package:flutter/material.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/services/db_helper.dart';
import 'package:pictile/themes/text_styles.dart';

import 'package:pictile/ui/common/basic_page.dart';
import 'package:pictile/ui/common/header.dart';
import 'package:pictile/ui/common/set_tile.dart';
import 'package:provider/provider.dart';

class ShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Header('SELECT SET'),
          ],
        ),
        Expanded(child: _buildTiles(context)),
      ],
    );
  }

  Widget _buildTiles(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);

    return FutureBuilder(
      future: dbHelper.getSets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length == 0) {
            return _buildEmptyInfo();
          }

          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                for (int i = 0; i < snapshot.data.length; i++)
                  SetTile(
                    setMap: snapshot.data[i],
                    onTap: () => _onTileTap(context, snapshot.data[i]),
                  ),
              ],
            ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildEmptyInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('YOU HAVE NO SETS', style: blackTextStyle),
      ],
    );
  }

  _onTileTap(BuildContext context, Map map) async {
    final db = Provider.of<DbHelper>(context, listen: false);
    final pairMaps = await db.getPairsForSet(map[setsIdKey]);

    if (pairMaps.length == 0) {
      // TODO show info
      return;
    }

    Navigator.pushNamed(context, showTapModeRoute, arguments: pairMaps);
  }
}
