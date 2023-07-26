
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../common/custom_ui/hoz_list_view.dart';
import '../../common/custom_ui/shimmer_image.dart';
import '../../../utils/my_const/COLOR_CONST.dart';

class WidgetHomeBanner extends StatefulWidget {
  @override
  _WidgetHomeBannerState createState() => _WidgetHomeBannerState();
}

class _WidgetHomeBannerState extends State<WidgetHomeBanner> {
  final aspectRatioBanner = 16 / 9;
  var currentIndex = 0;
  List banners = ["assets/6169474.jpg", "assets/18001771.jpg"];

  @override
  Widget build(BuildContext context) {
    return _buildCarouselSlider();
  }

  Widget _buildCarouselSlider() {
    return Column(
      children: <Widget>[
        CarouselSlider(
          items: banners.map((banner) {
            return ShimmerImage(
              banner,
              fit: BoxFit.fill,
              assest: true,
              aspectRatio: aspectRatioBanner,
              iconHolderSize: 56,
            );
          }).toList(),
          options: CarouselOptions(
            aspectRatio: aspectRatioBanner,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            pauseAutoPlayOnTouch: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 15,),
        _buildIndicators(),
      ],
    );
  }

  _buildIndicators() {
    return Container(
      child: WrapContentHozListView(
        list: banners,
        itemBuilder: (context, index) {
          return _buildIndicatorNormal(currentIndex == index);
        },
      ),
    );
  }

  _buildIndicatorNormal(bool isSelected) {
    return Container(
      height: isSelected ? 5 : 4,
      width: isSelected ? 18 : 16,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? COLOR_CONST.BLACK : COLOR_CONST.GRAY1,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}


