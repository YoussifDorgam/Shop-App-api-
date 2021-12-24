import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/get_addresses_model.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';

import 'add_addresses_screen.dart';
import 'order_screen.dart';

class AdressesScreen extends StatelessWidget {
  const AdressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (BuildContext context, state) {
        if (state is ShopSuccessAddOrderStatus) {
          if (state.addOrderModel.status) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.SCALE,
              title: 'Your Order in progress',
              desc:
                  "Your order was placed successfully.\n For more details check Delivery Status in settings.",
              btnOkText: "Order",
              btnOkOnPress: () {
                Navigator.pop(context);
                ShopAppcubit.get(context).OnChangeTabs(3);
                PushToNextScreen(context, MyOrdersScreen());
              },
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnCancelText: "Home",
              btnCancelColor: Colors.red,
              btnOkIcon: Icons.list_alt_outlined,
              btnCancelIcon: Icons.home,
              width: 400,
            ).show();
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: const Icon(
              Icons.location_on_outlined,
              color: Colors.deepOrange,
              size: 30,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
            title: const Text(
              'Location',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          bottomNavigationBar: VAvigatonbar(
            context,
            cubit.addressModel!.data!.data!.isEmpty
                ? null
                : cubit.addressModel!.data!.data!.first,
          ),
          body: cubit.addressModel!.data!.data!.isEmpty
              ? const Center(
                  child: Text(
                  'Please add New Address 🙁',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ))
              : cubit.addressModel!.data!.data!.isEmpty
                  ? const Center(
                      child: Text(
                      'Please add New Address 🙁',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ))
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          buildLocationItem(
                              cubit.addressModel!.data!.data![index], context),
                      itemCount: cubit.addressModel!.data!.data!.length,
                    ),
        );
      },
    );
  }
}

Widget buildLocationItem(AddressData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name :   ${model.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          PushToNextScreen(
                              context,
                              UpdateAddressScreen(
                                isEdit: true,
                                addressId: model.id,
                                name: model.name,
                                city: model.city,
                                region: model.region,
                                details: model.details,
                                notes: model.notes,
                              ));
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'city      :   ${model.city}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'region :   ${model.region}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'details :   ${model.details}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'notes   :   ${model.notes}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          ShopAppcubit.get(context)
                              .deleteAddress(addressId: model.id);
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: 20,
                            ),
                            Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget VAvigatonbar(context, AddressData? model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: model == null
          ? MaterialButton(
              height: 50,
              onPressed: () {
                PushToNextScreen(
                    context,
                    UpdateAddressScreen(
                      isEdit: false,
                    ));
              },
              child: const Text(
                'Add New Addresses',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            )
          : MaterialButton(
              height: 50,
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.QUESTION,
                  animType: AnimType.SCALE,
                  title: 'Are you Sure for Confirm this Order ?',
                  btnOkOnPress: () {
                    ShopAppcubit.get(context).AddOrder(AddressId: model.id);
                  },
                  btnCancelText: "Cancel",
                  btnCancelOnPress: () {},
                ).show();
              },
              child: const Text(
                'Order Now',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
    );
