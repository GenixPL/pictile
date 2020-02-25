import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pictile/services/db.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/basic_page.dart';

class ShowTapModePage extends StatefulWidget {
  final List<Map> maps;

  ShowTapModePage(this.maps);

  @override
  _ShowTapModePageState createState() => _ShowTapModePageState();
}

class _ShowTapModePageState extends State<ShowTapModePage> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        SizedBox(height: 16),
        Text('(TAP TO SHOW OR HIDE)', style: blackSmallTextStyle),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: GestureDetector(
              onTap: () => print('TAPPED'),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _buildContent(widget.maps[_i]),
              ),
            ),
          ),
        ),
        _buildBottomButtons()
      ],
    );
  }

  Widget _buildContent(Map map) {
    final _img = File(map[pairsImgPathKey]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(_img),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
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
              child: Text('PREVIOUS', style: whiteTextStyle),
              onPressed: _onPrevTap(),
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
              child: Text('NEXT', style: whiteTextStyle),
              onPressed: _onNextTap(),
            ),
          ),
        ),
      ],
    );
  }

  Function() _onPrevTap() {
    if (_i == 0) {
      return null;
    } else {
      return () {
        _i--;
        setState(() {});
      };
    }
  }

  Function() _onNextTap() {
    final max = widget.maps.length;

    if (_i == max - 1) {
      return null;
    } else {
      return () {
        _i++;
        setState(() {});
      };
    }
  }
}
