import 'package:flutter/material.dart';
import 'package:pictile/services/db.dart';

class SetTile extends StatelessWidget {
  final Map setMap;
  final Function() onTap;

  SetTile({
    @required this.setMap,
    @required this.onTap,
  })  : assert(setMap != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(child: _buildClickableInfo(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClickableInfo(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent, // to expand clickable area
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Icon(Icons.folder_open, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Text(
                setMap[setsNameKey],
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
