import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:smartaudience/src/model/beacon_model.dart';
import 'package:smartaudience/src/preferences/preferences_usuario.dart';
import 'package:smartaudience/src/provider/registro_provider.dart';
import 'package:smartaudience/src/utils/utils.dart' as util;

class BeaconPage extends StatefulWidget {
  const BeaconPage({Key key, this.state}) : super(key: key);
  final BluetoothState state;
  @override
  _BeaconPageState createState() => _BeaconPageState();
}

class _BeaconPageState extends State<BeaconPage> {

  ScanResult dataBeacons;
  final registroConference = new RegistroConferenceBeacon();
  BeaconModel beaconRegistro = BeaconModel();
  final _prefs = new PreferenciasUsuario();
  int cantidadBuscando;

  @override
  void initState() {
    super.initState();
    print(_prefs.idCareer);
    Stream<BluetoothState> streamBeacon = FlutterBlue.instance.state;
    streamBeacon.listen((data){
      final on = data.toString().substring(15);

      if(on == "on"){
        FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
      }
    });
    cantidadBuscando = 0;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return beaconOn();
          }else{
            return beaconOff(state);
          }
        }
      ),
    );
  }

  Widget beaconOff( BluetoothState state ){

    return Container(
      color: Colors.grey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'El adaptador bluetooth esta: ${state.toString().substring(15)}',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );

  } 

  Widget beaconOn(){

    return StreamBuilder<bool>(
      stream: FlutterBlue.instance.isScanning,
      initialData: false,
      builder: (c, snapshot){
        if (snapshot.data) {
            return buscandoBeacons();
        } else {
          return rebuscar();
        }
      }
    );

  }

  Widget buscandoBeacons(){
    //id beacons ==> E7:E7:C3:80:CD:75 , C5:E3:84:CE:4A:4E
    return StreamBuilder<List<ScanResult>>(
      stream: FlutterBlue.instance.scanResults,
      initialData: [],
      builder: (c, snapshot){
        snapshot.data.map((beacon){
          if(beacon.device.id.toString() == "C5:E3:84:CE:4A:4E"){
            dataBeacons = beacon;
          }
          if(beacon.device.id.toString() == "E7:E7:C3:80:CD:75"){
            dataBeacons = beacon;
          }
        }).toList();
        
        return Container(
          color: Colors.grey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.bluetooth_searching,
                  size: 200.0,
                  color: Colors.white54,
                ),
                Text(
                  'Buscando beacons...',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                SizedBox(height: 5.0,),
                CircularProgressIndicator()
              ],
            ),
          ),
        );
      },
    );
    
  }

 

  Widget rebuscar(){    
    cantidadBuscando++;
    print(cantidadBuscando);
    if(dataBeacons != null){
      return Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.settings_bluetooth,
                size: 200.0,
                color: Colors.white54,
              ),
              SizedBox(height: 5.0,),
              Text("Beacon estimote encontrado!!", style: TextStyle(color: Colors.white, fontSize: 16.0)),
              SizedBox(height: 5.0,),
              RaisedButton(
                onPressed: () async {
                  dataBeacons.device.connect();
                  util.mostrarConectado(context);
                  beaconRegistro.id = _prefs.idUser;
                  beaconRegistro.fechaini = DateTime.now().toString();
                  await registroConference.registrarConferencia(beaconRegistro);
                  Future.delayed(Duration(milliseconds: 5000), (){
                    dataBeacons.device.disconnect();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'registroBeacon');
                  });
                },
                child: Text("Conectarse y Registrarse"),
                color: Color.fromRGBO(247, 146, 30, 1),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      );
    }else if(dataBeacons == null && cantidadBuscando == 5){
      return Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.bluetooth,
                size: 200.0,
                color: Colors.white54,
              ),
              SizedBox(height: 5.0,),
              RaisedButton(
                onPressed: () {
                  dataBeacons = null;
                  cantidadBuscando = 0;
                  util.mostrarSalida(context);
                },
                child: Text("Registrar salida"),
                color: Color.fromRGBO(247, 146, 30, 1),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      );
    }else{
      return Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.bluetooth,
                size: 200.0,
                color: Colors.white54,
              ),
              SizedBox(height: 5.0,),
              RaisedButton(
                onPressed: (){
                  dataBeacons = null;
                  FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
                },
                child: Text("Volver a buscar beacons"),
                color: Color.fromRGBO(247, 146, 30, 1),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      );
    }
    

  } 
}