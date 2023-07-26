
import 'package:flutter/material.dart';
import 'package:mobile_listing_app/utils/my_const/COLOR_CONST.dart';

import '../../common/custom_ui/svg_image.dart';
import '../../../utils/my_const/FONT_CONST.dart';

class WidgetHomeCategories extends StatefulWidget {
  @override
  _WidgetHomeCategoriesState createState() => _WidgetHomeCategoriesState();
}

class _WidgetHomeCategoriesState extends State<WidgetHomeCategories> {
  List<_ItemCategoryVM> items = [
    _ItemCategoryVM(title: "Phone with Warrenty", image : "assets/online-guarantee.svg",),
    _ItemCategoryVM(title:"Verify Device Only", image :"assets/verify.svg"),

  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Shop By', style: FONT_CONST.MEDIUM_BLACK2_14),
          const SizedBox(height: 14),
          _buildListCategory(),
        ],
      ),
    );
    
  }

  _buildListCategory() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var item = items[index];

          return _WidgetItemCategory(item);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 20);
        },
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
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
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 84,
            height: 64,
            color: COLOR_CONST.WHITE,
            child: Center(
              child: MySvgImage(
                path: item.image,
                width: 48,
                height: 38,
                applyColorFilter: false,
              ),
            ),
          ),
          // const SizedBox(height: 4),
          SizedBox(
            width: 84,
            child: Text(item.title, 
            textAlign: TextAlign.center,
            style: FONT_CONST.REGULAR_BLACK2_12,)),
        ],
      ),
    );
  }

  void openAllShows() {
    
  }
}

class _ItemCategoryVM {
  final String image;
  final String title;

  _ItemCategoryVM({required this.image, required this.title});
}
