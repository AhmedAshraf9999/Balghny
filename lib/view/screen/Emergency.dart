import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){ Navigator.of(context).pushNamed("home");},icon: const Icon(Icons.arrow_back),),
          title: const Text('Emergency'),
          centerTitle: true,
        ),
    body: SafeArea(
          child: DataTable(
          columns:  const <DataColumn>[
           DataColumn(label: Text('Emergency', style: TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.w800,
                     color: Colors.red
                   ))),
           DataColumn(label: Text('PhoneNumber', style: TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.w800,
                     color: Colors.red
                   ))),

          ],
          rows:  const <DataRow>[
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
               DataCell(Text('Egyptian Red Crescent')),
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
               DataCell(Text('Egyptian Environmental Affairs Agency')),
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
      );
  }
}
