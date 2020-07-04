
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageViewModel extends GetxController {

  PageController pageController;
   var _currentIndex = 0;

  get currentIndex => _currentIndex;



  void updatePage(value,  {bool updateController}) async {
     pageController.animateToPage(value, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    _currentIndex = value;
     update(["bottomNav"]);
  }


  @override
  void onInit() {

    print("Controller initialized");

    pageController = PageController();


  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}