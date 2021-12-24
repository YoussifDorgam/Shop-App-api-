import 'package:flutter/material.dart';
import 'package:shopapp/models/models.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<onbordModel> screens = [
  onbordModel(
      title: 'Explore',
      body:
          'Choose What ever the Product you wish for with the easiest way possible using Salla',
      image: 'assets/images/image1.gif'),
  onbordModel(
      body:
          'Yor Order will be shipped to you as fast as possible by our carrier',
      title: 'Shipping',
      image: 'assets/images/image2.gif'),
  onbordModel(
      body: 'Pay with the safest way possible either by cash or credit cards',
      title: 'Make the Payment',
      image: 'assets/images/image3.gif'),
];

class OnBording_Screen extends StatefulWidget {
  @override
  State<OnBording_Screen> createState() => _OnBording_ScreenState();
}

class _OnBording_ScreenState extends State<OnBording_Screen> {
  var Pagecontrolar = PageController();

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                cachHelper.Savedataa(key: 'ShowOnBoard', value: false)
                    .then((value) {
                  if (value) {
                    print(value);
                    NavegatandFinish(context, ShopLoginScreen());
                  }
                });
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                if (index == screens.length - 1) {
                  setState(() {
                    islast = true;
                  });
                } else {
                  setState(() {
                    islast = false;
                  });
                }
              },
              physics: const BouncingScrollPhysics(),
              controller: Pagecontrolar,
              itemBuilder: (context, index) =>
                  buildonbordingScreen(screens[index]),
              itemCount: screens.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: Pagecontrolar,
                  count: screens.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                    spacing: 5.0,
                    expansionFactor: 4,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      cachHelper.Savedataa(key: 'ShowOnBoard', value: false)
                          .then((value) {
                        if (value) {
                          print(value);
                          NavegatandFinish(context, ShopLoginScreen());
                        }
                      });
                    } else {
                      Pagecontrolar.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  backgroundColor: Colors.deepOrange,
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}

Widget buildonbordingScreen(onbordModel model) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(
              model.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 100.0,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Text(
            model.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
        ),
        separator(0, 10),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model.body,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
