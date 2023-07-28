import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_listing_app/UI/home/filters/filter_screen.dart';
import 'package:mobile_listing_app/UI/home/home_view_model.dart';
import 'package:mobile_listing_app/utils/my_const/COLOR_CONST.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../model/home_model.dart';
import '../../common/custom_ui/svg_image.dart';
import '../../../utils/my_const/FONT_CONST.dart';

class HomeBestDealWidget extends StatefulWidget {
  HomeViewModel model;
  HomeBestDealWidget({required this.model});
  @override
  _HomeBestDealWidgetState createState() => _HomeBestDealWidgetState();
}

class _HomeBestDealWidgetState extends State<HomeBestDealWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(text: "Best Deal Near You  ", style: FONT_CONST.MEDIUM_BLACK2_14),
                    const TextSpan(text: "India", style: TextStyle(color: Colors.orange, fontSize: 18, decoration: TextDecoration.underline)),
                  ])),
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                       shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                        ),
                      context: context, builder: (context) => FilterBottomSheet(model: widget.model,));
                  },
                  child: Text('Filter', style: FONT_CONST.BOLD_BLACK.copyWith(fontSize: 20))),
            ],
          ),
          const SizedBox(height: 8),
          _buildListBestDeal(widget.model.list),
        ],
      ),
    );
  }

  _buildListBestDeal(List<Listing> model) {
    return GridView.builder(
      itemCount: model.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: (1 / 1.5),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 140,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: COLOR_CONST.WHITE, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl : model[index].defaultImage!.fullImage!,
                  placeholder: (context, url) =>  CircularProgressIndicator(color: COLOR_CONST.BLUE,),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  memCacheHeight: 140,
                  memCacheWidth: 140,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text("₹${model[index].listingNumPrice.toString()}", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: COLOR_CONST.BLACK, fontSize: 18)),
              const SizedBox(
                height: 6,
              ),
              Text(model[index].marketingName.toString(), style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: COLOR_CONST.BLACK2, fontSize: 14)),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model[index].deviceStorage.toString(), style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, color: COLOR_CONST.BLACK2, fontSize: 12)),
                  Text(model[index].deviceCondition.toString(), style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, color: COLOR_CONST.BLACK2, fontSize: 12)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model[index].listingState.toString(), style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, color: COLOR_CONST.BLACK2, fontSize: 12)),
                  Text(model[index].listingDate.toString(), style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, color: COLOR_CONST.BLACK2, fontSize: 12)),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const SizedBox();
        } else if (mode == LoadStatus.loading) {
          body = CircularProgressIndicator(
            color: COLOR_CONST.BLUE,
          );
        } else if (mode == LoadStatus.failed) {
          body = Text(
            "Load Failed! Scroll Up to retry!",
            style: TextStyle(color: COLOR_CONST.BLUE),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            "Release to load more",
            style: TextStyle(color: COLOR_CONST.BLUE),
          );
        } else {
          body = Text(
            "",
            style: TextStyle(color: COLOR_CONST.BLUE),
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 25, bottom: 40),
          height: 35.0,
          child: Center(child: body),
        );
      },
    );
  }
}
