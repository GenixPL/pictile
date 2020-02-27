import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/services/db_helper.dart';
import 'package:pictile/themes/text_styles.dart';

import 'package:pictile/ui/common/basic_page.dart';
import 'package:pictile/ui/common/buttons/my_flat_button.dart';
import 'package:pictile/ui/common/buttons/my_raised_button.dart';
import 'package:pictile/utils/validator.dart';
import 'package:provider/provider.dart';

class EditPairPage extends StatefulWidget {
  final Map map;

  EditPairPage(this.map);

  @override
  _EditPairPageState createState() => _EditPairPageState();
}

class _EditPairPageState extends State<EditPairPage> {
  File _img;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _img = File(widget.map[pairsImgPathKey]);
    _titleController.text = widget.map[pairsTitleKey];
    _descriptionController.text = widget.map[pairsDescriptionKey];
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('EDIT PAIR', style: blackTextStyle),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: _buildImg(),
              ),
              Expanded(
                flex: 3,
                child: _buildTexts(),
              ),
            ],
          ),
        ),
        _buildBottomButtons(context),
      ],
    );
  }

  Widget _buildImg() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          if (_img != null)
            Align(
              child: Image.file(_img),
              alignment: Alignment.center,
            ),
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => _onImgTap(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('TAP TO CHANGE', style: smallWhiteTextStyle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTexts() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('TITLE', style: blackTextStyle),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              maxLines: 1,
              validator: Validator.validatePairTitle,
            ),
            SizedBox(height: 8),
            Text('DESCRIPTION', style: blackTextStyle),
            Expanded(
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                expands: true,
                maxLines: null,
                maxLength: 1000,
                validator: Validator.validatePairDescription,
              ),
            ),
//        Expanded(child: Container(color: Colors.redAccent,),)
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MyFlatButton(
          text: 'CANCEL',
          onTap: () => Navigator.pop(context),
        ),
        Builder(
          builder: (context) => MyRaisedButton(
            text: 'SAVE',
            onTap: () => _onSaveTap(context),
          ),
        ),
      ],
    );
  }

  // FUNCTIONS

  _onImgTap(BuildContext context) async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.photos],
    );

    var img;
    try {
      img = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content:
              Text('IMAGE COULD NOT BE LOADED', style: smallWhiteTextStyle),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _img = img;
    });
  }

  _onSaveTap(BuildContext context) async {
    if (!_formKey.currentState.validate() || _img == null) {
      if (_img == null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('IMAGE CAN NOT BE EMPTY', style: smallWhiteTextStyle),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    final db = Provider.of<DbHelper>(context, listen: false);
    await db.updatePair(
      widget.map[pairsIdKey],
      widget.map[pairsSetIdKey],
      _img.path,
      _titleController.text,
      _descriptionController.text,
    );

    Navigator.pop(context);
  }
}
