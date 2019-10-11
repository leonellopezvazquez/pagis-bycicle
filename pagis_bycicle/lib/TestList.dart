import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class TestList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestListState();
  }
}


class TestListState extends State<TestList> {




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
              title: Text('Países')
          ),

      body: new ListView(
              children: [
                Text('Primer elemento!'),
                Text('Segundo elemento!'),
                Text('Tercer elemento!'),
                Text('Cuarto elemento!'),
              ]
          )   
      

    );
  }


}