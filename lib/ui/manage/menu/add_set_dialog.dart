import 'package:flutter/material.dart';
import 'package:pictile/main.dart';
import 'package:pictile/themes/text_styles.dart';

import 'package:pictile/ui/common/buttons/my_flat_button.dart';
import 'package:pictile/ui/common/buttons/my_raised_button.dart';
import 'package:pictile/utils/validator.dart';

class AddSetDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

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
                      child: Text('CREATE NEW SET', style: blackTextStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                            border: OutlineInputBorder(),
                            hintText: 'Set name...',
                            labelText: 'Set name',
                          ),
                          validator: Validator.validateSetName,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
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
          text: 'CREATE',
          onTap: () => _onCreateTap(context),
        )
      ],
    );
  }

  _onCreateTap(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    await db.createSet(_nameController.text);
    Navigator.pop(context);
  }
}
