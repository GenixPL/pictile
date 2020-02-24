import 'package:flutter/material.dart';
import 'package:pictile/main.dart';
import 'package:pictile/ui/common/app_text_style.dart';

class ConfirmDeleteSetDialog extends StatelessWidget {
  final int setId;

  ConfirmDeleteSetDialog(this.setId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'DO YOU WANT TO DELETE THIS SET',
                            textAlign: TextAlign.center,
                            style: blackTextStyle,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '(THIS CAN NOT BE UNDONE)',
                            style: blackSmallTextStyle,
                          ),
                        ],
                      ),
                    ),
                    _buildBottomButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ],
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
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              splashColor: Colors.white,
              child: Text('DELETE', style: blackSmallTextStyle),
              onPressed: () => _onDeleteTap(context),
            ),
          ),
        ),
      ],
    );
  }

  _onDeleteTap(BuildContext context) async {
    await db.deleteSet(setId);
    Navigator.pop(context);
  }
}
