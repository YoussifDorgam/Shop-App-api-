
import 'package:flutter/material.dart';
import 'package:shopapp/models/shop_category_model.dart';


void Navegato(context , wight) => Navigator.push( context,
  MaterialPageRoute(builder: (context) => wight) ,
);


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
    borderRadius: BorderRadius.circular(20.0),
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

Widget buildCategoriesItem (Data model) {return Container(
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
    );
}