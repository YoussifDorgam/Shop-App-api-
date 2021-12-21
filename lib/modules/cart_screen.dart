import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/get_cart_data.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/cons.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopAppcubit>(context)..GetCartData(),
      child: BlocConsumer<ShopAppcubit, ShopStatus>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = ShopAppcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1.0,
              title: const Text(
                'Review Cart',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            bottomNavigationBar: ShopAppcubit.get(context).getCartModel == null ? const Center(child: CircularProgressIndicator())
                : buildButtomNavigationBAR(context) ,
            body: ShopAppcubit.get(context).getCartModel == null ? const Center(child: CircularProgressIndicator())
                : ShopAppcubit.get(context).getCartModel!.data.cartItems.isEmpty ?
            const Center(child: Text('Reciew Cart is Embty 🙁',
              style: TextStyle(
                  fontSize: 20 ,
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal
              ),
            ))  :
            ListView.separated(
              shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildCartItem(
                    cubit.getCartModel!.data.cartItems[index], context , index , ShopAppcubit.get(context).getCartModel! ),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.getCartModel!.data.cartItems.length),
          );
        },
      ),
    );
  }

  Widget buildCartItem(CartItems cartItems, context , index ,GetCartModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 140.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(
                      cartItems.product.image,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                   if (cartItems.product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItems.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black, height: 1.0),
                    ),
                    const Spacer(),
                    Container(
                      width: 120,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                ShopAppcubit.get(context).minusQuantity(model,index);
                                ShopAppcubit.get(context).updateCartData(id: model.data.cartItems[index].id.toString(),quantity: ShopAppcubit.get(context).quantity);
                                print(model.data.cartItems[index].quantity.toString());
                              }, icon: const Icon(Icons.remove)),
                          Text(cartItems.quantity.toString()),
                          IconButton(onPressed: () {
                            ShopAppcubit.get(context).plusQuantity(model,index);
                            ShopAppcubit.get(context).updateCartData(id: model.data.cartItems[index].id.toString(),quantity: ShopAppcubit.get(context).quantity);
                            print(model.data.cartItems[index].quantity.toString());
                          }, icon: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${cartItems.product.price} EG',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          cartItems.product.oldprice.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            height: 1.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopAppcubit.get(context).changeCart(cartItems.product.id);
                          },
                          icon: const Icon(Icons.delete_forever ,size: 30, color: Colors.red,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  Widget buildButtomNavigationBAR(context ) =>  ListTile(
    title: const Text('Total Price'),
    subtitle:  Text(
      '${ShopAppcubit.get(context).getCartModel!.data.total} EG',
      style: const TextStyle(color: Colors.green),
    ),
    trailing: SizedBox(
      width: 160.0,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {},
        child: const Text(
          'Order',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  );


}
