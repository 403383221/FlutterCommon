import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_common/common/common_index.dart';
import 'package:flutter_common/common/ui/web_view.dart';
import 'package:flutter_common/components/wanandroid/dio/home_article_work.dart';
import 'package:flutter_common/components/wanandroid/dio/home_banner_work.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'data/home_article_data.dart';
import 'data/home_banner_data.dart';

//玩android 首页 CustomScrollView使用
class HomeWanAndroidComponent extends StatefulWidget {
  @override
  _HomeWanAndroidComponentState createState() =>
      _HomeWanAndroidComponentState();
}

class _HomeWanAndroidComponentState extends State<HomeWanAndroidComponent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  HomeBannerWork _bannerWork;
  HomeArticleWork _articleWork;
  HomeBannerData _bannerData;
  HomeArticleData _articleData;

  @override
  void initState() {
    super.initState();
    loadBannerData();
    loadMore();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerWork?.cancel();
    _articleWork?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    if (_bannerData == null || _articleData == null) {
      return Container();
    }
    return Container(
      child: EasyRefresh(
          child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          _buildBannerWidget(_bannerData?.bannerData),
          _buildArticleWidget(_articleData?.articleData?.datas)
        ],
      )),
    );
  }

  //SliverToBoxAdapter Banner控件
  Widget _buildBannerWidget(List<BannerData> objs) {
    return SliverToBoxAdapter(
      child: Container(
        height: DeviceUtil.width * 0.5,
        child: Swiper(
          onTap: (int index)=>pushNewPage(context, WebViewPage(url: '${objs[index].url}',title: '${objs[index].title}',)),
          autoplay: objs.length != 1,
          itemCount: objs.length,
          itemBuilder: (BuildContext context, int index) {
            return Hero(
                tag: '${objs[index].imagePath}',
                child: ImageLoadView(
                  '${objs[index].imagePath}',
                ));
          },
        ),
      ),
    );
  }

  Widget _buildArticleWidget(List<Datas> objs) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildArticleItemWidget(objs[index], index);
        },
        childCount: objs?.length,
      ),
      itemExtent: 140,
    );
  }

  Widget _buildArticleItemWidget(Datas obj, int index) {
    return Material(
      child: InkWell(
          onTap: () {
            String link = obj.link;
            if (link.isEmpty) return;
            pushNewPage(
                context,
                WebViewPage(
                  url: link,
                  title: obj?.title,
                ));
          },
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                height: 130.0,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.supervised_user_circle,
                              size: 30.0,
                              color: grey500Color,
                            ),
                            Text(
                              '${obj.author}',
                              style: TextStyle(color: grey500Color),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(Icons.favorite_border,
                                  color: grey500Color),
                            ),
                            Icon(Icons.share, color: grey500Color)
                          ],
                        )
                      ],
                    ),
                    Text(
                      '${obj.title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                                text: '分类: ',
                                style: TextStyle(color: grey500Color),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '${obj.superChapterName}',
                                  style: TextStyle(color: blue500Color)),
                              TextSpan(
                                  text: ' / ',
                                  style: TextStyle(color: blue500Color)),
                              TextSpan(
                                  text: '${obj.chapterName}',
                                  style: TextStyle(color: blue500Color))
                            ])),
                        Text(
                          '${obj.niceDate}',
                          style: TextStyle(color: grey500Color, fontSize: 12.0),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 10.0,
                color: grey300Color,
              )
            ],
          )),
    );
  }

  void loadBannerData() {
    if (_bannerWork == null) _bannerWork = HomeBannerWork();
    _bannerWork.start().then((value) {
      if (value.success) {
        _bannerData = value.result;
        setState(() {});
      }
    });
  }

  void loadMore() {
    if (_articleWork == null) _articleWork = HomeArticleWork();
    _articleWork.start().then((value) {
      if (value.success) {
        _articleData = value.result;
        setState(() {});
      }
    });
  }
}
