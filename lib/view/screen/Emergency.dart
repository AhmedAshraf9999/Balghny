import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){ Navigator.of(context).pushNamed("home");},icon: Icon(Icons.arrow_back),),
          title: Text('Emergency'),
          centerTitle: true,
        ),
    body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.only(right: 15),
            child: Container(
              child: DataTable(
              columns:  <DataColumn>[
               DataColumn(label: Text('Emergency', style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.w800,
                         color: Colors.red
                       ))),
               DataColumn(label: Text('Phone Number', style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.w800,
                         color: Colors.red
                       ))),

              ],
              rows:  <DataRow>[
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Police')),
                   DataCell(Text('122')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Traffic Police')),
                   DataCell(Text('0226847266')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Fire Department')),
                   DataCell(Text('180')),

                 ],
               ),
              DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Ambulance')),
                   DataCell(Text('123')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('HighwayEmergency')),
                   DataCell(Text('01221110000')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Egyption Red Crescent')),
                   DataCell(Text('15322')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Public Services', style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.w800,
                         color: Colors.red
                       ))),
                   DataCell(Text('PhoneNumber', style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.w800,
                         color: Colors.red
                       ))),
                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Electricity')),
                   DataCell(Text('121')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('Egyption Enviromental Affairs Agency')),
                   DataCell(Text('19808')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('NaturalGas')),
                   DataCell(Text('129')),

                 ],
               ),
               DataRow(
                 cells: <DataCell>[
                   DataCell(Text('MeteorologicalAuthority')),
                   DataCell(Text('0226849857')),

                 ],
               ),

              ],
              ),
            ),
          ),
          
        ),
      );
  }
}
