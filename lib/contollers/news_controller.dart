import 'dart:convert';
import 'package:flash_news_getx/constants/newsApi_constants.dart';
import 'package:flash_news_getx/models/article_model.dart';
import 'package:flash_news_getx/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  // for list view
  List<ArticleModel> allNews = <ArticleModel>[];
  // for carousel
  List<ArticleModel> breakingNews = <ArticleModel>[];
  ScrollController scrollController = ScrollController();
  RxBool articleNotFound = false.obs;
  RxBool isLoading = false.obs;
  RxString cName = ''.obs;
  RxString country = ''.obs;
  RxString category = ''.obs;
  RxString channel = ''.obs;
  RxString searchNews = ''.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  String baseUrl = "https://newsapi.org/v2/top-headlines?"; // ENDPOINT

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    getAllNews();
    getBreakingNews();
    super.onInit();
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      getAllNews();
    }
  }

  // function to load and display breaking news on to UI
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      breakingNews = [];

      pageNum.value = 2;
    }
    // default language is set to English
    /// ENDPOINT
    baseUrl =
        "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&";
    // default country is set to US
    baseUrl += country.isEmpty ? 'country=us&' : 'country=$country&';
    //baseApi += category.isEmpty ? '' : 'category=$category&';
    baseUrl += 'apiKey=${NewsApiConstants.newsApiKey}';
    print([baseUrl]);
    // calling the API function and passing the URL here
    getBreakingNewsFromApi(baseUrl);
  }

  // function to load and display all news and searched news on to UI
  getAllNews({channel = '', searchKey = '', reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      country.value = '';
      category.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
    } else {
      allNews = [];

      pageNum.value = 2;
    }
    // ENDPOINT
    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";
    // default country is set to India
    baseUrl += country.isEmpty ? 'country=in&' : 'country=$country&';
    // default category is set to Business
    baseUrl += category.isEmpty ? 'category=business&' : 'category=$category&';
    baseUrl += 'apiKey=${NewsApiConstants.newsApiKey}';
    if (channel != '') {
      country.value = '';
      category.value = '';
      baseUrl =
          "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${NewsApiConstants.newsApiKey}";
    }
    if (searchKey != '') {
      country.value = '';
      category.value = '';
      baseUrl =
          "https://newsapi.org/v2/everything?q=$searchKey&from=2022-07-01&sortBy=popularity&pageSize=10&apiKey=${NewsApiConstants.newsApiKey}";
    }
    print(baseUrl);
    // calling the API function and passing the URL here
    getAllNewsFromApi(baseUrl);
  }

  // function to retrieve a JSON response for breaking news from newsApi.org
  getBreakingNewsFromApi(url) async {
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          breakingNews = [...breakingNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            breakingNews = newsData.articles;
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }

  // function to retrieve a JSON response for all news from newsApi.org
  getAllNewsFromApi(url) async {
    //Creates a new Uri object by parsing a URI string.
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      //Parses the string and returns the resulting Json object.
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          allNews = [...allNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            allNews = newsData.articles;
            // list scrolls back to the start of the screen
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }
}
