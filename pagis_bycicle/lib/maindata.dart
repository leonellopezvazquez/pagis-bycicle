import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'dart:typed_data';
import 'dart:convert';
import './rowlist.dart';

const String url = "http://192.168.31.157:5060/";

class MainData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainDataState();
  }
}




class MainDataState extends State<MainData> {
  static TextStyle styles = TextStyle(fontFamily: 'Montserrat', fontSize: 24.0, color: Colors.white);
  static TextStyle styleslist = TextStyle(fontFamily: 'Montserrat', fontSize: 24.0, color: Colors.black);


  static TextEditingController controller = new TextEditingController();

  static int count = 0;
  static int temp = 0;
  static int volt = 0;
  static String plate = "TEST";

  List<String> litems=[];
  List<Image> overviewIMGlistimages=[];

  Image patchIMG = Image.network(
      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png");
  Image overviewIMG;
  Image overviewIMGlist;
  Image videoIMG;
  String vrm;

  List<String> toPrint = ["trying to connect"];
  SocketIOManager manager;
  Map<String, SocketIO> sockets = {};
  Map<String, bool> _isProbablyConnected = {};
  //creating image widgets

  int cont = 0;
 

  static Text dispTemp = new Text('$temp' + ' °C',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: styles);

 

  static Text dispVolt = new Text('$volt' + '  %',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: styles);

  static Text dispPlate = new Text('$plate',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: styles);

    
   @override
  void initState() {
    super.initState();
      manager = SocketIOManager();
    initSocket("default");
      print("init");
      patchIMG = Image.asset('assets/car.jpg',width: 500,height: 100,fit:BoxFit.cover);



      overviewIMG = Image.asset('assets/plate.jpg',width: 500,height: 100,fit:BoxFit.cover);
      overviewIMGlist = Image.asset('assets/plate.jpg',width: 100,height: 100,fit:BoxFit.cover);
      vrm ="EPLATE";
  }


  initSocket(String identifier) async {
    setState(() => _isProbablyConnected[identifier] = true);
    print("staring socketio");
    SocketIO socket =
        await manager.createInstance(SocketOptions(url, nameSpace: "/"));

    socket.onConnect((data) {
      print("connected...");
      print(data);
    });


    socket.on("mobile_response", (data) {
      changeResponse(data.replaceAll("\'", "\""));
    });

    bool isProbablyConnected(String identifier) {
    return _isProbablyConnected[identifier] ?? false;
    }



    socket.connect();

    sockets[identifier] = socket;
    socket.emit("join", [
      {"room": "backendImages"}
    ]);
    socket.emit("join", [
      {"room": "PAGISImages"}
    ]);
    socket.emit("join", [
      {"room": "HITS"}
    ]);
    socket.emit("join", [
      {"room": "Queries"}
    ]);
    socket.emit("join", [
      {"room": "Reads"}
    ]);
  }


  disconnect(String identifier) async {
    await manager.clearInstance(sockets[identifier]);
    setState(() => _isProbablyConnected[identifier] = false);
  }


  sendMessage(identifier) {
    if (sockets[identifier] != null) {
      sockets[identifier].emit("specificChannel", [
        {"room": "Queries", "data": "Hello world it's a Mario", "type": 4},
      ]);
    }
  }


  joinChannel(identifier, room) {
    if (sockets[identifier] != null) {
      sockets[identifier].emit("joinChannel", [
        {"room": room},
      ]);
    }
  }

  pprint(data) {
    setState(() {
      if (data is Map) {
        data = json.encode(data);
      }
      print(data);
      toPrint.add(data);
    });
  }


  changeResponse(data) {
    try {
      var parsedJson = json.decode(data);
      switch (parsedJson['type']) {
        case 1:
          print("Video " + parsedJson['data']);
          break;
        case 2:
          print("PAGISImages1");
          var v_rm = parsedJson['data']['vrm'];
          var p_atch = parsedJson['data']['patch'];
          var o_verview = parsedJson['data']['overview'];
          Uint8List bytes_p = base64Decode(p_atch);
          Uint8List bytes_o = base64Decode(o_verview);
          setState(() {
            patchIMG = Image(
              image: MemoryImage(bytes_p),
              fit: BoxFit.cover,
            );

            
            overviewIMG = Image(
              image: MemoryImage(bytes_o),
              fit: BoxFit.cover,
            );
            
            overviewIMGlist = Image(
              image: MemoryImage(bytes_o),width: 150,height: 100,
              fit: BoxFit.cover,
            );
            

            vrm = v_rm;
            cont=cont+1;
            //litems.add(vrm);
            overviewIMGlistimages.add(overviewIMGlist);

          });


          print("hey you");
          break;
        case 3:
          print("HITS " + parsedJson['data']);
          break;
        case 4:
          print("Queries " + parsedJson['data']);
          break;
        case 5:
          print("Reads " + parsedJson['data']);
          break;
        default:
          print("Error");
          break;
      }
    } on FormatException catch (e) {
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    

    Widget listsession(){

      return new Container(

        child: Padding(
          padding:EdgeInsets.all(2),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              //framesforlist(),

              new Stack(
                children: <Widget>[

                   
                  new Container(
                    padding: EdgeInsets.all(100),
                    color:const Color(0xff373737),
                    //child:  Image.asset('assets/car.jpg', width: 100, height: 100),

                  ),
                  
                  new Padding(
                    padding: EdgeInsets.all(60),
                    child: Center(

                    child: CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/car.jpg'),
                      maxRadius: 35,
                    ),
                    //child: new Image.asset('assets/car.jpg', width: 100, height: 100),
                  ),

                  

                  ),
                  
                  
                  new Padding(
                    padding: EdgeInsets.only(top:130),

                      child:Center(
                        child: new Text("llopezneology.mx",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: Colors.white),
                      ),
                    
                      
                      ),
                      
                   
                  ),
                  
                 
                ],
              ),

              
              new Container(

                
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                  new InkWell(
                    child: new Text("Submint images",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.black)),
                  ),
                  new Divider(),
                  new InkWell(
                    child: new Text("Logout",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.black)),
                  ),
                    
                    
                  ],
                ),
                
              ),
                        
              new Container(
                padding: EdgeInsets.only(top:300),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: new Image.asset('assets/pips.png',width: 100,),
                ),
              )
              

            ],



          ),
        ),

      );
    }


    Widget  textmeasurements(String temp){
      return new Padding(
      
      padding: EdgeInsets.only(top: 15,right: 15),
      
      child: new Text(
        temp,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,color: Colors.white),
      ),
    
    );
    }

   
    return new Scaffold(
        backgroundColor: const Color(0xFF4F5D72),
        
        appBar: new AppBar(
          
          backgroundColor: const Color(0xFF373737),
          
          actions: <Widget>[
            textmeasurements("27°C"),
            textmeasurements("63 %"),
            
            

            new Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.battery_charging_full),
            ),
            new Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.play_arrow),
            ),
            
            
            
          ],
        ),

        drawer: new Drawer(
          child: listsession(),
        ),

        body: SafeArea(
          child: mainlayaout(),
        )
        );
  }

  Widget textplate(String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
    );
  }


  Widget textreads(String counts) {

    return new Padding(
      
      padding: EdgeInsets.only(right: 20),
      child: new Align(
      alignment: Alignment.topRight,
      child: new Text(
        counts,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22,color: Colors.white),
      ),
    )
    );
    
  }

  Widget imagefromcar(Image imagen) {
    return new Expanded(
      child: Container(
        
        child: imagen,
        //child: Image.asset(path,width: 500,height: 100,fit:BoxFit.cover),
      ),
    );
  }

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
          Text(plate,style: TextStyle(fontStyle: FontStyle.normal,fontSize: 30)),
          Text("1234567"),
        ],
      ),
    );
  }

  Widget rowfromlist(Image imagen,String plate) {
    Orientation orientacion = MediaQuery.of(context).orientation;

    if(orientacion==Orientation.landscape){

      return Padding(
      padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
      child: new Container(


        height: MediaQuery.of(context).size.height-250,
        
        color: Colors.white,
        
        child:new Padding(
          padding: EdgeInsets.all(4),
          child:  new Row(
      
        children: <Widget>[
          imagefromlist(imagen),
          textfromlist(plate),
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
          padding: EdgeInsets.all(4),
          child:  new Row(
      
        children: <Widget>[
          imagefromlist(imagen),
          textfromlist(plate),
        ],
      ) ,

        )

        
      ),

    );

    }   
    
  }

  Widget lista() {
    return ListView(
      children: [

        rowfromlist(overviewIMGlist,vrm),
        //rowfromlist(),
      
        
      ],
    );
  }

  

  Widget constlista(){

    return ListView.builder(

      itemCount: litems.length,      
      itemBuilder: (context, index){

        return  new RowList(overviewIMGlistimages, vrm);
      },

    );
  }

  

  Widget fr1() {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;
    return new Container(
        child: Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color(0xff373737),
                  width: _width - 32,
                  height: _height - 100,
                ),
                Center(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          color: Colors.white,
                          width: _width - 48,
                          height: _height - 116,
                          child: new Column(
                            children: <Widget>[
                              textplate(vrm),
                              imagefromcar(patchIMG),
                              imagefromcar(overviewIMG),
                            ],
                          ),
                        ))),
              ],
            )
            )
            ,
        
        
      ],
    )
    );
  }


  Widget fr2(){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;



    return new Center(
      child: new Padding(
        padding: EdgeInsets.only(top: 16,left: 16,right: 16),
        child: new Container(
          
          color: Color(0xff373737),
          width: _width-32,
          height: _height-185,

          child:new Padding(
            padding: EdgeInsets.only(top: 8),
            //child: lista(),
            child: new RowList(overviewIMGlistimages, vrm),
          ),
          
        ),
      ),
    );

  }


  Widget fr3(){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;

     return new Container(
        child: Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 16,left: 16,top:16),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.grey,
                  width: _width - 20,
                  height: _height - 200,
                ),
                Center(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          color: Colors.grey,
                          width: _width - 40,
                          height: _height - 215,
                          child: lista(),
                        )
                        )
                        ),
              ],
            )),
        
        
      ],
    )
    );
  }

  
  Widget fr1landscape(){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;

    return new Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: new Stack(
        
          children: <Widget>[
            new Container(
              width: _width - 300,
              height: _height - 300,
              color: Color(0xff373737),
              
            ),

            new Center(
              
              child:new Padding(
                padding: EdgeInsets.all(8),
              child: new Container(
                
                color: Colors.white,
                width: _width-316,
                child: new Column(
                  children: <Widget>[
                    textplate(vrm),
                    imagefromcar(patchIMG),
                    imagefromcar(overviewIMG),
                  ],
                ),
              ),
              ),
            ),


          ],

        ),
        
        
      ),
    );

  }

  Widget fr2lanscape(){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;
    
    return new Container(

      child: new Padding(
        padding: EdgeInsets.only(top: 20,bottom: 8,),
        child: new Container(
          color: Color(0xFF373737),
          width: _width-320,
          //height: _height-328,
          child:new Padding(
            padding: EdgeInsets.only(top:8),
            child: lista(),
          ),
          
        ),
      ),

    );

  }

  Widget fr3landscape(){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(0),
      child: new Container(
        
        width: _width-320,
        child: new Column(
          children: <Widget>[
            

            textreads("Lecturas: 0"),
            new Container(
              color: Color(0xFF373737),
              height: _height-348,
              child: new Padding(
                padding: EdgeInsets.only(top:8,bottom: 8),
                child: lista(),
              ),
            ),           


          ],
        ),
      ),
    );

  }


  Widget mainlayaout() {
    Orientation orientacion = MediaQuery.of(context).orientation;

    if (orientacion == Orientation.portrait) {
      return new Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          fr1(),
          textreads("Lecturas: 0"),
          fr2(),
        
        ],
      );
    } 

    else{
      return new Row(

        children: <Widget>[
          fr1landscape(),
        
          fr3landscape(),

          
        ],

      );
    }
    
  }

  
}
