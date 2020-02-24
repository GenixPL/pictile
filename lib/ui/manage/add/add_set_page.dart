import 'package:flutter/material.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/basic_page.dart';

class AddSetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('CREATE NEW SET', style: blackTextStyle),
        ),
        Expanded(
          child: Column(),
        ),
        _buildBottomButtons(),
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
            child: FlatButton(
              child: Text('CANCEL', style: blackSmallTextStyle),
              onPressed: () => print('CREATE'),
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
              onPressed: () => print('CREATE'),
            ),
          ),
        ),
      ],
    );
  }
}
