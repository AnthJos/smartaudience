import 'package:flutter/material.dart';
import 'package:smartaudience/src/pages/conferencia_page.dart';
import 'package:smartaudience/src/pages/taller_page.dart';
import 'package:smartaudience/src/provider/conference_provider.dart';
import 'package:smartaudience/src/widgets/menu_widget.dart';

class MenuPage extends StatefulWidget {

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  int currentIndex = 0;
  final conferenceProvider = ConferenceProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 146, 30, 1),
        actions: <Widget>[
          FutureBuilder(
            future: conferenceProvider.verificarConferencia(),
            builder: (BuildContext c, AsyncSnapshot<int> snapshot){
              final data = snapshot.data;
              if ( data != null && data > 0 ){
                return IconButton(
                  icon: Icon( Icons.router ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'beaconPage');
                  },
                );
              }else{
                return IconButton(
                  icon: Icon( Icons.router ),
                  onPressed: null,
                );
              }
              
            },
          )
        ],
      ),
      drawer: MenuWidget(),
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottomNavigatorBar(),
    );
  }

  Widget _bottomNavigatorBar(){

    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Color.fromRGBO(247, 146, 30, 1),
      selectedItemColor: Colors.white,
      onTap: (index){
        setState(() {
         currentIndex = index; 
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          title: Text('Conferencias'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_library),
          title: Text('Talleres'),
        ),
      ],
    );

  }

  Widget _callPage(int paginaActual) {

    switch( paginaActual ) {
      case 0: return ConferenciaPage();
      case 1: return TallerPage();
      
      default: 
        return ConferenciaPage(); 
    }


  }
}