import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/get_homedata.dart';
import 'package:shopapp/models/models.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeProductDataScreen extends StatelessWidget {
  var Pagecontrolar = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
        listener: (BuildContext context, state) {
        },
        builder: (context, state) {
      //    ProductDetailsModel? cubit = ShopAppcubit.get(context).productDetailsModel.status;
          return Scaffold();
          // return Scaffold(
          //   appBar: AppBar(
          //     backgroundColor: Colors.white,
          //     elevation: 0.0,
          //     actions: [
          //       TextButton(
          //           onPressed: () {
          //             cachHelper.Savedataa(key: 'ShowOnBoard', value: false)
          //                 .then((value) {
          //               if (value) {
          //                 print(value);
          //                 NavegatandFinish(context, ShopLoginScreen());
          //               }
          //             });
          //           },
          //           child: const Text(
          //             'SKIP',
          //             style: TextStyle(
          //               color: Colors.deepOrange,
          //             ),
          //           )),
          //     ],
          //   ),
          //   backgroundColor: Colors.white,
          //   body: Column(
          //     children: [
          //       Expanded(
          //         child: PageView.builder(
          //           physics: const BouncingScrollPhysics(),
          //           controller: Pagecontrolar,
          //           itemBuilder: (context, index) =>
          //               buildonbordingScreen(cubit.homeProductmodel!.data!.images!![index] ),
          //           itemCount:cubit.homeProductmodel!.data!.images!.length,
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(20.0),
          //         child: Row(
          //           children: [
          //             SmoothPageIndicator(
          //               controller: Pagecontrolar,
          //               count: cubit.homeProductmodel!.data!.images!.length,
          //               effect: const ExpandingDotsEffect(
          //                 activeDotColor: Colors.deepOrange,
          //                 spacing: 5.0,
          //                 expansionFactor: 4,
          //                 dotHeight: 10.0,
          //                 dotWidth: 10.0,
          //               ),
          //             ),
          //             const Spacer(),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 15.0,
          //       ),
          //     ],
          //   ),
          // );
        }
    );
  }
}

//
// Widget buildonbordingScreen(ProductDetailsData model  ) =>
//     Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Expanded(
//           child: Image.asset(
//            ' ${model.images}',
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//         ),
//         const SizedBox(
//           height: 100.0,
//         ),
//         Text(
//          ' ${model.name}',
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 30.0,
//           ),
//         ),
//         const SizedBox(
//           height: 15.0,
//         ),
//         Text(
//           model.price,
//           style: const TextStyle(
//             color: Colors.grey,
//             fontSize: 15.0,
//           ),
//         ),
//         const SizedBox(
//           height: 15.0,
//         ),
//       ],
//     );
