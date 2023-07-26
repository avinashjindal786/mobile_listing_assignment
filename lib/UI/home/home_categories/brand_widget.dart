import 'package:flutter/material.dart';
import 'package:mobile_listing_app/utils/my_const/COLOR_CONST.dart';

import '../../common/custom_ui/svg_image.dart';
import '../../../utils/my_const/FONT_CONST.dart';

class HomeBrandsWidget extends StatefulWidget {
  @override
  _HomeBrandsWidgetState createState() => _HomeBrandsWidgetState();
}

class _HomeBrandsWidgetState extends State<HomeBrandsWidget> {
  List<_ItemCategoryVM> items = [
    _ItemCategoryVM( image: "assets/apple.svg"),
    _ItemCategoryVM( image: "assets/nokia.svg"),
    _ItemCategoryVM( image: "assets/motorola.svg"),
    _ItemCategoryVM( image: "assets/asus.svg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Buy Top Brands', style: FONT_CONST.MEDIUM_BLACK2_14),
          const SizedBox(height: 8),
          _buildListCategory(),
        ],
      ),
    );
    ;
  }

  _buildListCategory() {
    return SizedBox(
      height: 88,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var item = items[index];

            return _WidgetItemCategory(item);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
        ),
      ),
    );
  }
}

class _WidgetItemCategory extends StatelessWidget {
  _ItemCategoryVM item;

  _WidgetItemCategory(this.item);

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return GestureDetector(
      onTap: () {
        openAllShows();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: 84,
        height: 64,
        decoration: BoxDecoration(color: COLOR_CONST.WHITE, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: MySvgImage(
            path: item.image,
            width: 38,
            height: 38,
            applyColorFilter: false,
          ),
        ),
      ),
    );
  }

  void openAllShows() {}
}

class _ItemCategoryVM {
  final String image;
  _ItemCategoryVM({required this.image, });
}
