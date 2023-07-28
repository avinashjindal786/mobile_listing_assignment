import 'package:flutter/material.dart';
import 'package:mobile_listing_app/UI/home/home_categories/best_deal_list_widget.dart';
import 'package:mobile_listing_app/UI/home/home_categories/brand_widget.dart';
import 'package:mobile_listing_app/UI/home/home_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import '../../utils/my_const/COLOR_CONST.dart';
import '../../utils/my_const/FONT_CONST.dart';
import '../common/custom_ui/svg_image.dart';
import 'home_banner/widget_home_banner.dart';
import 'home_categories/widget_home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async => await viewModel.init(),
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
                  child: _buildToolBar(model),
                ),
                body: Container(
                  color: const Color(0xFFfbfbfb),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      model.isBusy
                          ? Center(
                              child: CircularProgressIndicator(
                                color: COLOR_CONST.BLUE,
                              ),
                            )
                          : model.search
                              ? _buildSearch(model)
                              : _buildContent(model),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildContent(HomeViewModel model) {
    return Expanded(
      child: SmartRefresher(
        enablePullUp: true,
        enablePullDown: false,
        footer: const RefreshWidget(),
        controller: model.topPostsRefreshController,
        onLoading: () async {
          await model.getHomeData();
        },
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 20),
            HomeBrandsWidget(),
            WidgetHomeBanner(),
            const SizedBox(height: 20),
            WidgetHomeCategories(),
            const SizedBox(height: 30),
            HomeBestDealWidget(
              model: model,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch(HomeViewModel model) {
    return model.searchController.text == ""
        ? Center(
            child: Text(
              "Please Enter a Search Word",
              style: FONT_CONST.MEDIUM_BLACK2_16,
            ),
          )
        : Expanded(
            child: model.searchModel != null
                ? ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text('Brands', style: FONT_CONST.REGULAR.copyWith(fontSize: 12)),
                      const SizedBox(height: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          model.searchModel!.makes!.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(model.searchModel!.makes![index], style: FONT_CONST.MEDIUM_BLACK2_16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text('Mobile Model', style: FONT_CONST.REGULAR.copyWith(fontSize: 12)),
                      const SizedBox(height: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          model.searchModel!.models!.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(model.searchModel!.models![index], style: FONT_CONST.MEDIUM_BLACK2_16),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: COLOR_CONST.BLUE,
                    ),
                  ));
  }

  Widget _buildToolBar(HomeViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: COLOR_CONST.BLUE,
      height: 100,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              _buildAvatar(),
              _buildNames(),
              _buildActions(),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: COLOR_CONST.WHITE, borderRadius: BorderRadius.circular(5)),
            child: model.search
                ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: model.searchController,
                          onChanged: (va) async {
                            model.changeSearchOption(va != "" ? true : false);
                            await model.getSearch(va);
                          },
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          style: FONT_CONST.REGULAR_BLACK2,
                          decoration: InputDecoration(border: InputBorder.none, hintText: 'Search', hintStyle: FONT_CONST.REGULAR_GRAY4_14),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          model.changeSearchOption(false);
                          model.searchController.text = "";
                          model.searchModel = null;
                        },
                        child: MySvgImage(
                          path: "assets/ic_close.svg",
                          width: 20,
                          height: 20,
                          color: COLOR_CONST.BLACK,
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      model.changeSearchOption(true);
                    },
                    child: Row(children: [
                      Icon(
                        Icons.search,
                        color: COLOR_CONST.BLACK,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('Search with make and model ......', style: FONT_CONST.MEDIUM_BLACK2),
                    ]),
                  ),
          )
        ],
      ),
    );
  }

  _buildActions() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: <Widget>[
          Text('India', style: FONT_CONST.SEMIBOLD_WHITE_16),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouter.LIST_MY_TICKET);
              },
              child: Icon(
                Icons.location_on,
                color: COLOR_CONST.WHITE,
                size: 30,
              )),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouter.LIST_MY_TICKET);
              },
              child: Icon(
                Icons.notifications,
                color: COLOR_CONST.WHITE,
                size: 30,
              )),
        ],
      ),
    );
  }

  _buildNames() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Avinash', style: FONT_CONST.SEMIBOLD_WHITE_16),
        ],
      ),
    );
  }

  _buildAvatar() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(
          Icons.menu,
          color: COLOR_CONST.WHITE,
          size: 30,
        ));
  }
}
