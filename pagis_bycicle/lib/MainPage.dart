import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}


class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      body: Center(child: mainlayout(),),

    );
  }



  Widget testlist(){

    return ListView(
          children: [
            Image.asset('assets/car.jpg',  
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
            Image.asset('assets/car.jpg',  
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
            Image.asset('assets/car.jpg',  
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
            Image.asset('assets/car.jpg',  
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,)
          ],
          
        );

  }


  Widget mainlayout(){

    Orientation orientacion = MediaQuery.of(context).orientation;

    if (orientacion == Orientation.portrait) {

      return new Column(
        children: <Widget>[
          testlist(),
        ],

      );
    }
    else{
      return new Column();

    }

  }

}