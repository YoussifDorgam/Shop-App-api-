import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 20, top: 20),
            child: Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 20 ,bottom: 5),
            child: Text(
              'Name  : Youssif El Sayed Mohammed',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 20 ,bottom: 5),
            child: Text(
              'Email   : ya863733@gmail.com',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 20, bottom: 20),
            child: Text(
              'Age      : 18 Years Old',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children:
                [
                 Expanded(
                  child: InkWell(
                    onTap: ()
                    {
                      messenger();
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage('https://www.hubbardinteractive.com/wp-content/uploads/2020/04/facebook-logo.png',) ,
                    ),
                  ),
                ),
                  Expanded(
                  child: InkWell(
                    onTap: ()
                    {
                      instgram();
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.hSNlZWz5XYMWjVCNAzR-jwHaFP?pid=ImgDet&rs=1',) ,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: ()
                    {
                      whatsapp();
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.rYwLvduBi2m_Kk6jSko6ZAHaEu?pid=ImgDet&rs=1'),
                    ),
                  ),
                ),


              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: 20,
          ),



        ],
      ),
    );
  }
  void whatsapp() async {
    const url = "https://l.facebook.com/l.php?u=https%3A%2F%2Fapi.whatsapp.com%2Fsend%2F%3Fphone%3D201027790713%26text%26app_absent%3D0%26fbclid%3DIwAR0B66FNvgVt3Y9kNDUkbVWLhy50BUo3rWQetC86WmH-HuS6YgTMofzJOaA&h=AT24d8sM0oSOxShMV9xha4CJ74JGOnpuNeGhG5wU-P6JTP_0u3FkKMa2fA1-I1inJUaVau90EAm2d11Sunvh-_wZjfgVHEjHFNuFtKUWdXV21aIHdEEMNFC_Ju_N2jDdfIR68A";
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void messenger() async {
    const url = "https://l.facebook.com/l.php?u=https%3A%2F%2Fm.me%2Fyoussf.dorgam%3Ffbclid%3DIwAR0DJ4inJM15HhKCBLEaglIZrSGMY5w-6RP-334CoXREbmyYSQ71g7jWx48&h=AT24d8sM0oSOxShMV9xha4CJ74JGOnpuNeGhG5wU-P6JTP_0u3FkKMa2fA1-I1inJUaVau90EAm2d11Sunvh-_wZjfgVHEjHFNuFtKUWdXV21aIHdEEMNFC_Ju_N2jDdfIR68A";
    if (!await launch(url)) throw 'Could not launch $url';
  }
  void instgram() async {
    const url = "https://www.instagram.com/you33e7/";
    if (!await launch(url)) throw 'Could not launch $url';
  }


}


