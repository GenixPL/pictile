import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/basic_page.dart';

class AddPairPage extends StatefulWidget {
  @override
  _AddPairPageState createState() => _AddPairPageState();
}

class _AddPairPageState extends State<AddPairPage> {
  File _img;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('CREATE NEW PAIR', style: blackTextStyle),
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
          GestureDetector(
            onTap: _onImgTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text('TAP TO CHANGE', style: whiteTextStyle),
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
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
              validator: _validateTitle,
            ),
            SizedBox(height: 8),
            Text('DESCRIPTION', style: blackTextStyle),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  border: OutlineInputBorder(),
                ),
                expands: true,
                maxLines: null,
                validator: _validateDescription,
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
              child: Text('CREATE', style: whiteTextStyle),
              onPressed: _onCreateTap,
            ),
          ),
        ),
      ],
    );
  }

  _onImgTap() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.photos],
    );

    var img;
    try {
      img = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print(e);
    }
    setState(() {
      _img = img;
    });
  }

  _onCreateTap() {
    if (!_formKey.currentState.validate()) {
      return;
    }


  }

  String _validateTitle(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 50) {
      return 'Max 50 characters';
    }

    return null;
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }

    if (value.length > 500) {
      return 'Max 500 characters';
    }

    return null;
  }
}
