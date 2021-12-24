import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/get_homedata.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  final id;

  ProductDetails(this.id);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool islast = false;
  var Pagecontrolar = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<ShopAppcubit>(context)
          ..getProductData(widget.id.toString()),
        child: BlocConsumer<ShopAppcubit, ShopStatus>(
            builder: (context, state) => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    title: const Text(
                      'ProductDetails',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  body: state is ShopLodingGetHomProductDataStatus
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: LinearProgressIndicator(
                              color: Colors.deepOrange,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        )
                      : ShopAppcubit.get(context).productDetailsModel == null ?
                      const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: LinearProgressIndicator(
                        color: Colors.deepOrange,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                      :bodyBuild(
                          context,
                          ShopAppcubit.get(context).productDetailsModel,
                        ),
                ),
            listener: (context, state) {}));
  }

  Widget bodyBuild(context, ProductDetailsModel? model,) {
    List<Widget> images = [];
    model!.data.images.forEach((element) {
      images.add(Image.network(element, fit: BoxFit.contain));
    });
    return ShopAppcubit.get(context).productDetailsModel == null
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  model.data.name,
                  style: const TextStyle(fontSize: 25),
                ),
                CarouselSlider(
                    items: images,
                    options: CarouselOptions(
                        height: 300,
                        onPageChanged: (x, reason) {
                          ShopAppcubit.get(context).changeVal(x);
                        })),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: AnimatedSmoothIndicator(
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.deepOrange,
                          spacing: 5.0,


                        ),
                        activeIndex: ShopAppcubit.get(context).value,
                        count: images.length),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "${model.data.price.toString()} EGP",
                      style: const TextStyle(
                          fontSize: 20, color: Colors.deepOrange),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: ShopAppcubit.get(context).InCart[model.data.id] == true ?
                      Colors.deepOrange: Colors.grey,
                      child: IconButton(
                        icon: const Icon(Icons.add_shopping_cart ,color: Colors.white,),
                        onPressed: () {
                          ShopAppcubit.get(context).changeCart(model.data.id);
                        },
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Divider(
                    height: 2,
                    color: Colors.deepOrange,
                    endIndent: 10,
                    indent: 10,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(model.data.description)
              ],
            ),
          );
  }
}
