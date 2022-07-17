import 'package:flash_news_getx/constants/color_constants.dart';
import 'package:flash_news_getx/constants/size_constants.dart';
import 'package:flash_news_getx/constants/ui_constants.dart';
import 'package:flash_news_getx/contollers/news_controller.dart';
import 'package:flash_news_getx/utils/utils.dart';
import 'package:flash_news_getx/widgets/dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer sideDrawer(NewsController newsController) {
  return Drawer(
    backgroundColor: AppColors.lightGrey,
    child: ListView(
      children: <Widget>[
        GetBuilder<NewsController>(
          builder: (controller) {
            return Container(
              decoration: const BoxDecoration(
                  color: AppColors.burgundy,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.dimen_10),
                    bottomRight: Radius.circular(Sizes.dimen_10),
                  )),
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_18, vertical: Sizes.dimen_18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.cName.isNotEmpty
                      ? Text(
                          "Country: ${controller.cName.value.toUpperCase()}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                  vertical15,
                  controller.category.isNotEmpty
                      ? Text(
                          "Category: ${controller.category.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                  vertical15,
                  controller.channel.isNotEmpty
                      ? Text(
                          "Category: ${controller.channel.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
          init: NewsController(),
        ),

        /// For Selecting the Country
        ExpansionTile(
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text("Select Country"),
          children: <Widget>[
            for (int i = 0; i < listOfCountry.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.country.value = listOfCountry[i]['code']!;
                  newsController.cName.value =
                      listOfCountry[i]['name']!.toUpperCase();
                  newsController.getAllNews();
                  newsController.getBreakingNews();
                },
                name: listOfCountry[i]['name']!.toUpperCase(),
              ),
          ],
        ),

        /// For Selecting the Category
        ExpansionTile(
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text("Select Category"),
          children: [
            for (int i = 0; i < listOfCategory.length; i++)
              drawerDropDown(
                  onCalled: () {
                    newsController.category.value = listOfCategory[i]['code']!;
                    newsController.getAllNews();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),

        /// For Selecting the Channel
        ExpansionTile(
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text("Select Channel"),
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.channel.value = listOfNewsChannel[i]['code']!;
                  newsController.getAllNews(
                      channel: listOfNewsChannel[i]['code']);
                  newsController.cName.value = '';
                  newsController.category.value = '';
                  newsController.update();
                },
                name: listOfNewsChannel[i]['name']!.toUpperCase(),
              ),
          ],
        ),
        const Divider(),
        ListTile(
            trailing: const Icon(
              Icons.done_sharp,
              size: Sizes.dimen_28,
              color: Colors.black,
            ),
            title: const Text(
              "Done",
              style: TextStyle(fontSize: Sizes.dimen_16, color: Colors.black),
            ),
            onTap: () => Get.back()),
      ],
    ),
  );
}
