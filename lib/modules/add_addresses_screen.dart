import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';

class UpdateAddressScreen extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;

  UpdateAddressScreen({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateAddreesesStatus) {
          if (state.updateAddressModel.status) {
            Navigator.pop(context);
          }
        } else if (state is ShopSuccessPostAddreesesStatus &&
            state.addAddressModel.status) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (isEdit) {
          nameControl.text = name!;
          cityControl.text = city!;
          regionControl.text = region!;
          detailsControl.text = details!;
          notesControl.text = notes!;
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            titleSpacing: 10,
            title: Row(
              children: const [
                Image(
                  image: AssetImage('assets/images/image4.png'),
                  width: 40,
                  height: 40,
                ),
                Text(
                  'Salla',
                  style: TextStyle(color: Colors.black),
                ),
              ],
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: addressFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is ShopLodingPostAddreesesStatus ||
                          state is ShopLodingUpdateAddreesesStatus)
                        Column(
                          children: const [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      const Text(
                        'LOCATION INFORMATION',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Name',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: nameControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter your Location name',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'City',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: cityControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter your City name',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Region',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: regionControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter your region',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Details',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: detailsControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please enter some details',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Notes',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: notesControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Please add some notes to help find you',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 60,
                      ),
                    ]),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              height: 50,
              onPressed: () {
                if (addressFormKey.currentState!.validate()) {
                  if (isEdit) {
                    ShopAppcubit.get(context).updateAddress(
                        addressId: addressId,
                        name: nameControl.text,
                        city: cityControl.text,
                        region: regionControl.text,
                        details: detailsControl.text,
                        notes: notesControl.text);
                  } else {
                    ShopAppcubit.get(context).PostAddressesData(
                        name: nameControl.text,
                        city: cityControl.text,
                        region: regionControl.text,
                        details: detailsControl.text,
                        notes: notesControl.text);
                  }
                }
              },
              child: const Text(
                'SAVE ADDRESS',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
