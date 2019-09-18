import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/common/common_index.dart';
import 'package:flutter_common/res/json_strings.dart';

import 'data/theme_change_data.dart';

//修改主图
class ChangeThemeWanAndroidComponent extends StatefulWidget {
  @override
  _ChangeThemeWanAndroidComponentState createState() =>
      _ChangeThemeWanAndroidComponentState();
}

class _ChangeThemeWanAndroidComponentState
    extends State<ChangeThemeWanAndroidComponent> {
  @override
  Widget build(BuildContext context) {
    final localThemeJson = json.decode(JsonStrings.wanAndroidTheme);
    final localThemeObjects =
        localThemeJson.map((o) => ThemeChangeData.fromJson(o));
    final listOfLocalThemeObjects = localThemeObjects.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('修改主题'),
      ),
      body: ListView.builder(
          itemCount: listOfLocalThemeObjects.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildBodyItemWidget(listOfLocalThemeObjects[index], index);
          }),
    );
  }

  Widget _buildBodyItemWidget(obj, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Store.value<ConfigProvider>(context)
              .setTheme(int.parse('${obj?.theme}'));
        });
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              color: Color(int.parse('${obj?.theme}')),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                '${obj?.themeName}',
                style: TextStyle(color: Color(int.parse('${obj?.theme}'))),
              ),
            ),
            Offstage(
                offstage: true,
                child: Icon(
                  Icons.check,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
