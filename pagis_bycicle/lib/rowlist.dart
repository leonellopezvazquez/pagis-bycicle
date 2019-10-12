import 'package:flutter/material.dart';

class RowList extends StatelessWidget {




  
  final List<Image> imagenes;

  RowList(this.imagenes,this.plate);
  Image imagen;
  String plate;

  
  

  Widget imagefromlist(Image imagen) {
  return Container(
    //padding: new EdgeInsets.fromLTRB(0, 100, 0,100),
    child:imagen,
    //child: Image.asset('assets/car.jpg', width: 100, height: 100, fit: BoxFit.cover,)
    );
  }
    
  Widget textfromlist(String plate) {
  return Container(
    padding: EdgeInsets.all(20),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: <Widget>[
        Text(plate,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 24)),
        Text("1234567"),
        ],
      ),
    );
  }


  Widget rowfromlist(BuildContext context, int index) {
  Orientation orientacion = MediaQuery.of(context).orientation;

  if(orientacion==Orientation.landscape){

    return Padding(
    padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
    child: new Container(


      height: MediaQuery.of(context).size.height-250,
      
      color: Colors.white,
      
      child:new Padding(
        padding: EdgeInsets.all(0),
        child:  new Row(
    
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(0),

          child:Container(
            color: Colors.white,
            child:imagefromlist(imagenes[index]),
          ),

          
        ),
        new Padding(
          padding: EdgeInsets.all(0),

          child:Container(
            color: Colors.white,
            child:textfromlist(plate),
          ),
          

        ),

        
        
        
      ],
    ) ,

      )

      
    ),

  );

  }
  else
  {

    return Padding(
    padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
    child: new Container(


      height: MediaQuery.of(context).size.height-480,
      
      color: Colors.white,
      
      child:new Padding(
        padding: EdgeInsets.all(0),
        child:  new Row(
    
      children: <Widget>[

        Padding(
          padding:EdgeInsets.only(left:1,right: 0),
          child:Container(
            color:Colors.white,
            child:imagefromlist(imagenes[index]),
          ),
          
        ),

        Padding(
          padding: EdgeInsets.all(0),
          child:Container(
            color: Colors.white,
            child:textfromlist(plate),
          ),
          
        ),
        
        
      ],
    ) ,

      )

      
    ),

  );

  }   
  
}




  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: rowfromlist,
      itemCount: imagenes.length,
    );
  }


}