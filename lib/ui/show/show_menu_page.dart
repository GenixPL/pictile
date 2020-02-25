import 'package:flutter/material.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/services/db_helper.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/basic_page.dart';
import 'package:provider/provider.dart';

class ShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('SELECT SET', style: blackTextStyle),
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
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                for (int i = 0; i < snapshot.data.length; i++)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.black, blurRadius: 2),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildClickableInfo(
                                    context, snapshot.data[i]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

  Widget _buildClickableInfo(BuildContext context, Map map) {
    return GestureDetector(
      onTap: () => _onTileTap(context, map),
      child: Container(
        color: Colors.transparent, // to expand clickable area
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Icon(Icons.folder_open, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Text(
                map[setsNameKey],
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
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