import 'package:flutter/material.dart';
class Hospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){ Navigator.of(context).pushNamed("home");},icon: Icon(Icons.arrow_back),),
          title: Text('Emergency'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                  label: Text('Hospitals',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
              DataColumn(
                  label: Text('Phone Number',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Ain Shams Specialized')),
                  DataCell(Text('16096')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Abdel Kader Fahmy')),
                  DataCell(Text('0222918700')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Al Salam')),
                  DataCell(Text('0233030502')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Al Hussein University')),
                  DataCell(Text('0225105354')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Badran')),
                  DataCell(Text('0233378823')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Dar Al Fouad')),
                  DataCell(Text('0238247247')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Dar Ai Shefaa')),
                  DataCell(Text('0224820298')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Heliopolis')),
                  DataCell(Text('0226322320')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('El Agouza')),
                  DataCell(Text('0233462004')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Eldemerdash')),
                  DataCell(Text('0226821098')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('The Red Crescent')),
                  DataCell(Text('0225750168')),
                ],
              ),
            ],
          ),
        ),
      );

  }
}
