import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  
  Widget imageLogo(String path) {
    return new Padding(
      padding: EdgeInsets.only(left: 8,right: 8,top:50,bottom: 16),
      child: Container(
       
        child: Image.asset(path,width: 250,height: 100,fit:BoxFit.cover),
      ),
    );
  }

  Widget usertext(){
    return new Padding(
      padding: EdgeInsets.all(40),
      child: Container(

      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(32.0))
      ),
       child: TextField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: "User",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              
            ),
            borderRadius: BorderRadius.circular(32.0),
          ),
          fillColor: Colors.white,
        ),
      ),
      ),
    );
  }

  Widget passtext(){
    return new Padding(
      padding: EdgeInsets.all(40),
      child: Container(

        decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(32.0))
      ),
        
        child: TextField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: "password",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(32.0),
          ),
          
          
        ),
      ),

            
      ),
    );
  }

  Widget log_in(){
    return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          //color: Color(0xff01A0C7),
          color: Color.fromARGB(100, 34,157,32),
          child: MaterialButton(
            
           
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            
            onPressed: (){
              Navigator.pushNamed(context, '/inicio');
            }    
            ,
        
            child: Text("Login",
                textAlign: TextAlign.center,
                ),
          ),
       
       
        );
  }

  Widget loginlayout(){
    Orientation orientacion = MediaQuery.of(context).orientation;

    if(orientacion==Orientation.portrait){

        return new Container(
          child: new Column(
            children: <Widget>[

              imageLogo('assets/pips.png'),
              usertext(),
              passtext(),
              log_in(),
            ],
          ),

        );
    }
    else{
      return new Container(
        child: Text("sdfsd"),
      );

    }

    
  }
  
  
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Scaffold(
      backgroundColor: const Color(0xFF4F5D72),


      
      body: Center(
      
        child: loginlayout(),
      
      ),

    );
  }

}