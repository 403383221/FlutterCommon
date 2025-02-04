import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common/common/common_index.dart';
import 'package:flutter_common/common/ui/button.dart';
import 'package:flutter_common/common/ui/change_appbar.dart';
import 'package:flutter_common/common/ui/countdown_widget.dart';
import 'package:flutter_common/common/ui/custom_text_field.dart';
import 'package:flutter_common/common/ui/gradual_change_view.dart';
import 'package:flutter_common/common/ui/icon_text.dart';
import 'package:flutter_common/common/ui/image_load_view.dart';
import 'package:flutter_common/common/ui/line.dart';
import 'package:flutter_common/common/ui/line_view_line.dart';
import 'package:flutter_common/common/ui/loader.dart';
import 'package:flutter_common/common/ui/search_bar.dart';
import 'package:flutter_common/common/ui/section_view.dart';
import 'package:flutter_common/common/ui/select_text_item.dart';
import 'package:flutter_common/common/ui/selected_text.dart';
import 'package:flutter_common/common/ui/suspension_tag.dart';
import 'package:flutter_common/common/ui/text_field_item.dart';
import 'package:flutter_common/common/ui/toolbar.dart';
import 'package:flutter_common/components/wanandroid/index_wanandroid_component.dart';

import 'baixing_life/index_life_component.dart';

class IndexComponent extends StatefulWidget {
  @override
  _IndexComponentState createState() => _IndexComponentState();
}

class _IndexComponentState extends State<IndexComponent> {
  TextEditingController _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('功能列表'),
      ),
      body: Container(
        child: GridView.count(
            //水平子Widget之间间距
            crossAxisSpacing: 10.0,
            //垂直子Widget之间间距
            mainAxisSpacing: 30.0,
            //GridView内边距
            padding: EdgeInsets.all(10.0),
            //一行的Widget数量
            crossAxisCount: 2,
            //子Widget宽高比例
            childAspectRatio: 2.0,
            //子Widget列表
            children: [
              _buildItemWidget('玩Android项目', 0),
              _buildItemWidget('电商完整项目', 1),
            ]),
      ),
    );
  }

  Widget _buildItemWidget(obj, index) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            pushAndRemovePage(context, IndexWanAndroidComponent());
            break;
          case 1:
            pushAndRemovePage(context, IndexBxLifeComponent());
            break;
        }
      },
      child: Container(
        alignment: Alignment.center,
        color: blue700Color,
        child: Text(
          '${obj}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
