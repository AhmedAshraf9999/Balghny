// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:balghny/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Hospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("home");
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(AppLocalizations.of(context)!.emergency),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 40),
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                  label: Text(AppLocalizations.of(context)!.hospitals,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
              DataColumn(
                  label: Text(AppLocalizations.of(context)!.phone_number,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.red))),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.ain_shams)),
                  DataCell(Text('16096')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.akf)),
                  DataCell(Text('0222918700')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.slam)),
                  DataCell(Text('0233030502')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.hussein)),
                  DataCell(Text('0225105354')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.badran)),
                  DataCell(Text('0233378823')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.dar_fouad)),
                  DataCell(Text('0238247247')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.dar_shefaa)),
                  DataCell(Text('0224820298')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.heluopls)),
                  DataCell(Text('0226322320')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.elagouza)),
                  DataCell(Text('0233462004')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.eldemerdash)),
                  DataCell(Text('0226821098')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(AppLocalizations.of(context)!.erc)),
                  DataCell(Text('0225750168')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
