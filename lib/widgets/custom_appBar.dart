import 'package:flash_news_getx/constants/color_constants.dart';
import 'package:flash_news_getx/constants/size_constants.dart';
import 'package:flutter/material.dart';

customAppBar(String title, BuildContext context,
    {bool? automaticallyImplyLeading, Widget? leading, List<Widget>? actions}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return AppBar(
    iconTheme: const IconThemeData(color: AppColors.white),
    automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    leading: leading,
    backgroundColor: AppColors.burgundy,
    elevation: 3.0,
    centerTitle: true,
    toolbarHeight: Sizes.dimen_64,
    actions: actions,
    title: Column(
      children: [
        const SizedBox(
          height: Sizes.dimen_12,
        ),
        Text(
          title,
          style: textTheme.headline5!.copyWith(
              fontSize: Sizes.dimen_22,
              color: AppColors.white,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
        ),
      ],
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(Sizes.dimen_10),
        bottomRight: Radius.circular(Sizes.dimen_10),
      ),
    ),
  );
}
