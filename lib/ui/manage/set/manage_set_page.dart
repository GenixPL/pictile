import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/services/db_helper.dart';
import 'package:pictile/themes/text_styles.dart';

import 'package:pictile/ui/common/basic_page.dart';
import 'package:pictile/ui/common/buttons/circle_button.dart';
import 'package:pictile/ui/common/buttons/my_flat_button.dart';
import 'package:pictile/ui/common/buttons/my_raised_button.dart';
import 'package:pictile/utils/validator.dart';
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
        Expanded(child: _buildPairs()),
        _buildBottomButtons(context),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Column(
        children: <Widget>[
          Text('TITLE', style: smallBlackTextStyle),
          SizedBox(height: 8),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                border: OutlineInputBorder(),
              ),
              validator: Validator.validateSetName,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPairs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Text('PAIRS', style: smallBlackTextStyle),
              SizedBox(height: 8),
              Expanded(child: _buildTiles(context)),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _buildPlusButton(),
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
            MyFlatButton(
              text: 'CANCEL',
              onTap: () => Navigator.pop(context),
            ),
            MyRaisedButton(
              text: 'SAVE',
              onTap: () => _onSaveTap(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlusButton() {
    return CircleButton(
      onTap: () => _onPlusTap(context),
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colors.black,
      paddingSize: 8,
    );
  }

  Widget _buildTiles(BuildContext context) {
    final dbHelper = Provider.of<DbHelper>(context);

    return FutureBuilder(
      future: dbHelper.getPairsForSet(widget.map[setsIdKey]),
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
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.grey[800], blurRadius: 2),
                        ],
                      ),
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: [
                                  _buildImg(snapshot.data[i]),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Padding(
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
                                            onTap: () => _onTrashTap(
                                                snapshot.data[i][pairsIdKey]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
      onTap: () => Navigator.pushNamed(
        context,
        manageEditPairRoute,
        arguments: map,
      ),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  map[pairsTitleKey],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImg(Map map) {
    final _img = File(map[pairsImgPathKey]);

    return FutureBuilder(
      future: _img.exists(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          if (snap.data == true) {
            return Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('IMAGE NOT FOUND', style: blackTextStyle);
          }
        }

        return CircularProgressIndicator();
      },
    );
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
    Navigator.pushNamed(context, manageAddPairRoute, arguments: widget.map);
  }

  _onTrashTap(int pairId) async {
    final db = Provider.of<DbHelper>(context, listen: false);
    await db.deletePair(pairId);

    setState(() {});
  }
}
