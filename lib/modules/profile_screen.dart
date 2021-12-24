import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/constance/cons.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopAppcubit cubit = ShopAppcubit.get(context);
        var model = cubit.UserModej;
        nameController.text = model!.data!.name!;
        phoneController.text = model.data!.phone!;
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            titleSpacing: 0,
            title: Row(
              children: const [
                // Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
                Text(
                  'Salla',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          body: ShopAppcubit.get(context).UserModej == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    color: Colors.grey[300],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is ShopLodingUpdateUserStatus)
                          Column(
                            children: const [
                              LinearProgressIndicator(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ahlan ${cubit.UserModej!.data!.name!.split(' ').elementAt(0)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${cubit.UserModej!.data!.email}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: 280,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'PERSONAL INFORMATION',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          editPressed(
                                              context: context,
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              email:
                                                  cubit.UserModej!.data!.email);
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '$editText',
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'Name',
                                  style: TextStyle(fontSize: 15),
                                ),
                                defaultFormField(
                                    controller: nameController,
                                    context: context,
                                    prefix: Icons.person,
                                    enabled: isEdit ? true : false,
                                    validate: (value) {}),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'Phone',
                                  style: TextStyle(fontSize: 15),
                                ),
                                defaultFormField(
                                    context: context,
                                    controller: phoneController,
                                    prefix: Icons.phone,
                                    enabled: isEdit ? true : false,
                                    validate: (value) {}),
                              ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SECURITY INFORMATION',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    // navigateTo(context,ChangePasswordScreen());
                                  },
                                  child: const Text('Change Password')),
                            ],
                          ),
                        ),
                        const SizedBox(height: 200)
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
