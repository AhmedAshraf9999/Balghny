// ignore_for_file: prefer_const_constructors

import 'package:balghny/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("home");
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title:  Text(AppLocalizations.of(context)!.emergency,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: DataTable(
            columns:  <DataColumn>[
              DataColumn(
                  label: Text("")),
              DataColumn(
                  label: Text("")),
            ],
            rows:  <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.emergencyy,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
                  DataCell(Text(AppLocalizations.of(context)!.phone_number,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
                ],
              ),

              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.police)),
                  DataCell(Text('122')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.traffic_police)),
                  DataCell(Text('0226847266')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.fire_department)),
                  DataCell(Text('180')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.ambulance)),
                  DataCell(Text('123')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.highway_emergency)),
                  DataCell(Text('01221110000')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.erc)),
                  DataCell(Text('15322')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.public_services,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
                  DataCell(Text(AppLocalizations.of(context)!.phone_number,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.electricity)),
                  DataCell(Text('121')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.eeaa)),
                  DataCell(Text('19808')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.naturalgas)),
                  DataCell(Text('129')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.meteorological)),
                  DataCell(Text('0226849857')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
