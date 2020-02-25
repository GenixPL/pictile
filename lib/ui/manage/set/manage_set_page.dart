import 'package:flutter/material.dart';
import 'package:pictile/main.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/services/db_helper.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/basic_page.dart';
import 'package:pictile/ui/common/circle_button.dart';
import 'package:provider/provider.dart';

class ManageSetPage extends StatefulWidget {
  final Map map;

  ManageSetPage(this.map);

  @override
  _ManageSetPageState createState() => _ManageSetPageState();
}

class _ManageSetPageState extends State<ManageSetPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.map[setsNameKey];
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        SizedBox(height: 16),
        Text('MANAGE SET', style: blackTextStyle),
        _buildTitle(),
        Expanded(child: Container()),
        _buildBottomButtons(context),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Column(
        children: <Widget>[
          Text('TITLE', style: blackSmallTextStyle),
          SizedBox(height: 8),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                border: OutlineInputBorder(),
              ),
              validator: _validateName,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: CircleButton(
                //TODO make it floating over pair tiles
                onTap: () => _onPlusTap(context),
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.black,
                paddingSize: 8,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 32,
                child: FlatButton(
                  child: Text('CANCEL', style: blackSmallTextStyle),
                  onPressed: () => Navigator.pop(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 32,
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  splashColor: Colors.white,
                  child: Text('SAVE', style: whiteTextStyle),
                  onPressed: () => _onSaveTap(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 50) {
      return 'Max 50 characters';
    }

    return null;
  }

  // FUNCTIONS

  _onSaveTap(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final db = Provider.of<DbHelper>(context, listen: false);
    await db.updateSet(widget.map[setsIdKey], _nameController.text);

    Navigator.pop(context);
  }

  _onPlusTap(BuildContext context) {
    print('ADD');
  }
}
