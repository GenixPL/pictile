import 'package:flutter/material.dart';
import 'package:pictile/main.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/basic_page.dart';
import 'package:pictile/ui/common/circle_button.dart';

import 'add_set_dialog.dart';

class ManageMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('YOUR SETS', style: blackTextStyle),
        ),
        Expanded(child: _buildTiles()),
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

  Widget _buildTiles() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('GET SETS'),
          onPressed: () async {
            print(await db.getSets());
          },
        ),
        RaisedButton(
          child: Text('ADD SET'),
          onPressed: () async {
            await db.createSet('A');
          },
        ),
        RaisedButton(
          child: Text('DEL id 1'),
          onPressed: () async {
            await db.deleteSet(1);
          },
        ),
        RaisedButton(
          child: Text('update id 2'),
          onPressed: () async {
            await db.updateSet(2, "DUPA");
          },
        ),
        RaisedButton(
          child: Text('DEL DB'),
          onPressed: () {
            db.deleteDb();
          },
        ),
        RaisedButton(
          child: Text('INIT DB'),
          onPressed: () {
            db.init();
          },
        ),
      ],
    );
  }

  _onPlusTap(BuildContext context) {
    showDialog(context: context, child: AddSetDialog());
  }
}
