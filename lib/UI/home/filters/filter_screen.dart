import 'package:flutter/material.dart';
import 'package:mobile_listing_app/UI/home/home_view_model.dart';
import 'package:mobile_listing_app/utils/my_const/COLOR_CONST.dart';

import '../../../utils/my_const/FONT_CONST.dart';

class FilterBottomSheet extends StatefulWidget {
  HomeViewModel? model;
  FilterBottomSheet({required this.model});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 15, right: 25, bottom: 10),
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Filter', style: FONT_CONST.BOLD_BLACK.copyWith(fontSize: 20)), Text('Clear Filter', style: FONT_CONST.BOLD_BLACK.copyWith(fontSize: 14).copyWith(color: Colors.orange, decoration: TextDecoration.underline))],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text("Brand".toUpperCase(), style: FONT_CONST.REGULAR_BLACK2),
        const SizedBox(height: 8),
        _buildListCategory(widget.model!.filterModel!.filters!.make!),
        const SizedBox(height: 24),
        Text("condition".toUpperCase(), style: FONT_CONST.REGULAR_BLACK2),
        const SizedBox(height: 8),
        _buildListCategory(widget.model!.filterModel!.filters!.condition!),
        const SizedBox(height: 24),
        Text("storage".toUpperCase(), style: FONT_CONST.REGULAR_BLACK2),
        const SizedBox(height: 8),
        _buildListCategory(widget.model!.filterModel!.filters!.condition!),
        const SizedBox(height: 24),
        Text("ram".toUpperCase(), style: FONT_CONST.REGULAR_BLACK2),
        const SizedBox(height: 8),
        _buildListCategory(widget.model!.filterModel!.filters!.condition!),
        const SizedBox(height: 24),
        ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(MediaQuery.sizeOf(context).width, 45)), backgroundColor: MaterialStatePropertyAll(COLOR_CONST.BLUE)),
            child: Center(
              child: Text("Apply".toUpperCase()),
            )),
        const SizedBox(height: 8),
      ]),
    );
  }

  _buildListCategory(List<String> list) {
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var item = list[index];

          return WidgetItemCategory(item,index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
      ),
    );
  }
}

// ignore: must_be_immutable
class WidgetItemCategory extends StatelessWidget {
  String item;
  int index;

  WidgetItemCategory(this.item,this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 70,
        decoration: BoxDecoration(color: index == 0 ? COLOR_CONST.GRAY1_50 : COLOR_CONST.WHITE, borderRadius: BorderRadius.circular(12),border: Border.all(color: COLOR_CONST.GRAY1)),
        child: Center(
            child: Text(
          item,
          style: const TextStyle(fontSize: 10, color: Colors.black),
        )),
      ),
    );
  }
}


/* 
{
  "filters": {
    "make": [
      "Apple",
      "OnePlus",
      "Samsung",
      "Xiomi",
      "Realme",
      "Vivo"
    ],
    "condition": [
      "Like New",
      "Excellent",
      "Good",
      "Fair",
      "Needs Repair"
    ],
    "storage": [
      "32 GB",
      "64 GB",
      "128 GB",
      "256 GB",
      "512 GB",
      "1 TB"
    ],
    "ram": [
      "4 GB",
      "6 GB",
      "8 GB",
      "12 GB",
      "16 GB",
      "32 GB",
      "64 GB",
      "128 GB"
    ]
  },
  "message": "Filters fetched successfully"
}*/