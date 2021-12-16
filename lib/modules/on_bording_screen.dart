import 'package:flutter/material.dart';
import 'package:shopapp/models/models.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
List<onbordModel> screens = [
  onbordModel(
      title: 'On bording Screen 1',
      body: 'Screen body 1',
      image: 'assets/images/image1.png'),
  onbordModel(
      title: 'On bording Screen 2',
      body: 'Screen body 2',
      image: 'assets/images/image2.png'),
  onbordModel(
      title: 'On bording Screen 3',
      body: 'Screen body 3',
      image: 'assets/images/image3.png'),
];

class OnBording_Screen extends StatefulWidget {
  @override
  State<OnBording_Screen> createState() => _OnBording_ScreenState();
}

class _OnBording_ScreenState extends State<OnBording_Screen> {
  var Pagecontrolar = PageController();

  bool islast = false;
  // void onbording_pef( )
  // {
  //   cachHelper.Savedataa(key: 'ShowOnBoardd', value: true).then((value)
  //   {
  //    if(value)
  //      {
  //        print('object');
  //        NavegatandFinish(context, ShopLoginScreen());
  //      }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                cachHelper.Savedataa(key: 'ShowOnBoard', value: false).then((value)
                {
                  if(value)
                  {
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
                      cachHelper.Savedataa(key: 'ShowOnBoard', value: false).then((value)
                      {
                        if(value)
                        {
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
      children: [
        Expanded(
          child: Image.asset(
            model.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 100.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          model.body,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15.0,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
