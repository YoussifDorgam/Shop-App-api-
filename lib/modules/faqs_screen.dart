import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/faqs_model.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/cons.dart';

class FAQsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopAppcubit cubit = ShopAppcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1.0,
              titleSpacing: 0,
              title: Row(
                children: const [
                  Image(
                    image: AssetImage('assets/images/image4.png'),
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    'Sala',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
            ),
            body: state is FAQsLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            color: Colors.grey[300],
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              'FAQs',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => faqsItemBuilder(
                                cubit.faqsModel.data!.data![index]),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: cubit.faqsModel.data!.data!.length),
                      ],
                    ),
                  ),
          );
        });
  }

  Widget faqsItemBuilder(FAQsData model) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.question}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${model.answer}',
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
