import 'package:flutter/material.dart';
import 'package:pictile/main.dart';
import 'package:pictile/ui/common/app_text_style.dart';
import 'package:pictile/ui/common/buttons/my_flat_button.dart';
import 'package:pictile/ui/common/buttons/my_raised_button.dart';

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
        MyFlatButton(
          text: 'CANCEL',
          onTap: () => Navigator.pop(context),
        ),
        MyRaisedButton(
          text: 'DELETE',
          onTap: () => _onDeleteTap(context),
          backgroundColor: Colors.redAccent,
          textStyle: blackSmallTextStyle,
        ),
      ],
    );
  }

  _onDeleteTap(BuildContext context) async {
    await db.deleteSet(setId);
    Navigator.pop(context);
  }
}
