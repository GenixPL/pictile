import 'package:flutter/material.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/services/db_helper.dart';
import 'package:pictile/themes/text_styles.dart';

import 'package:pictile/ui/common/basic_page.dart';
import 'package:pictile/ui/common/buttons/circle_button.dart';
import 'package:pictile/ui/manage/menu/confirm_delete_set_dialog.dart';
import 'package:provider/provider.dart';

import 'add_set_dialog.dart';

class ManageMenuPage extends StatefulWidget {
  @override
  _ManageMenuPageState createState() => _ManageMenuPageState();
}

class _ManageMenuPageState extends State<ManageMenuPage> {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('YOUR SETS', style: blackTextStyle),
        ),
        Expanded(child: _buildTiles(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleButton(
                onTap: () => _onPlusTap(context),
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.black,
                paddingSize: 8,
              ),
            ),
          ],
        ),
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
                              CircleButton(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onTap: () =>
                                    _onTrashTap(snapshot.data[i][setsIdKey]),
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
      onTap: () => Navigator.pushNamed(context, manageSetRoute, arguments: map),
      child: Container(
        color: Colors.transparent, // to expand clickable area
        child: Row(
          children: <Widget>[
            Icon(Icons.folder_open, color: Colors.grey),
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

  _onPlusTap(BuildContext context) async {
    await showDialog(context: context, child: AddSetDialog());
    setState(() {});
  }

  _onTrashTap(int setId) async {
    await showDialog(context: context, child: ConfirmDeleteSetDialog(setId));
    setState(() {});
  }
}
