
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/models/shop_category_model.dart';
import 'package:shopapp/modules/produc_category_data_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';


void PushToNextScreen(context , wight) => Navigator.push( context,
  MaterialPageRoute(builder: (context) => wight) ,
);


void showToast(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );}


void NavegatandFinish(context , Widget widget) => Navigator.pushAndRemoveUntil(context ,
  MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false ,
);


Widget bottom({
  required double width ,
  required Color color ,
  required VoidCallback? onpressed ,
  required String text,
}) => Container(
  width: width,
  decoration:  BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(30.0),
  ),
  child: MaterialButton(onPressed:onpressed ,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white ,
      ),
    ),
  ),
) ;

Widget defulteditTextx({

  required TextEditingController Controlar ,
  required TextInputType keyboardType ,
  Function?  onfiled ,
  // Function? onchanged ,
  FormFieldValidator<String>? validator ,
  required String Lable ,
  required IconData prefix ,
  IconData? sufix ,
  suffixPressed,
  bool? obscureText = false ,
  Function(String)? onSubmit,

}) => TextFormField(
  onFieldSubmitted: onSubmit,
  obscureText: obscureText!,
  controller: Controlar,
  keyboardType: keyboardType ,
  // onChanged:(s)
  // {
  //   onchanged!(s);
  // } ,
  validator: validator ,
  decoration:InputDecoration(
    labelStyle: const TextStyle(color: Colors.deepOrange),
    labelText: Lable ,
    border:  const OutlineInputBorder() ,
    prefixIcon: Icon(
      prefix ,color:Colors.deepOrange,
    ) ,
    suffixIcon: sufix != null ? IconButton(onPressed: suffixPressed, icon: Icon(sufix)) : null,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.white)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Colors.deepOrange)),
    filled: true,
    fillColor: Colors.grey[200],
  ),

);

Widget buildCategoriesItem (Data model, context) {return InkWell(
    onTap: (){
      ShopAppcubit.get(context).getCategoriesDetailData(model.id);
      PushToNextScreen(context, CategoryProductsScreen(model.name));
    },
  child:   Container(

        padding: const EdgeInsets.all(15),

        child: Row(

          children:

          [

            Image(image: NetworkImage('${model.image}'),width: 100,height: 100,),

            const SizedBox(height: 20.0,),

            Text('${model.name}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

            const Spacer(),

            const Icon(Icons.arrow_forward_ios_rounded),

          ],

        ),

      ),
);
}

Widget separator (double wide,double high){
  return SizedBox(width: wide,height: high,);
}


Widget BulidProfileItem(IconData iconData, String title,
    {GestureTapCallback? ontab}) {
  return Column(
    children: [
      ListTile(
        onTap: ontab,
        leading: Icon(
          iconData,
          size: 32,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black87, fontSize: 17.0 ,fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
        ),
      ),
      const Divider(
        height: 1,
        color: Colors.grey,
      ),
    ],
  );
}


Widget defaultFormField({
  required context,
  TextEditingController? controller,
  dynamic label,
  IconData ? prefix,
  String ? initialValue,
  TextInputType ?keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData ?suffix,
  suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      style:Theme.of(context).textTheme.bodyText1,
      initialValue:initialValue ,
      //textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        hintText: label,
        border:UnderlineInputBorder(),
        prefixIcon: Icon(prefix,),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix)) : null,

      ),
    );