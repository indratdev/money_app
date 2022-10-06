import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../settings/category/bloc/category_bloc.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int? groupValue = 0;
    DateTime? dateTime;
    String selectedImage = "collect-interest";

    final halfMediaWidth = MediaQuery.of(context).size.width - 10;
    final mediaHeight = MediaQuery.of(context).size.height / 3;

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  // height: mediaHeight,
                  child: CupertinoSlidingSegmentedControl<int>(
                    backgroundColor: CupertinoColors.lightBackgroundGray,
                    thumbColor: CupertinoColors.activeGreen,
                    padding: EdgeInsets.all(8),
                    groupValue: groupValue,
                    children: {
                      0: buildSegment("Penerimaan"),
                      1: buildSegment("Pengeluaran"),
                    },
                    onValueChanged: (value) {},
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Text("Tanggal : $dateTime"),
                    TextButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(9999))
                              .then((value) {
                            print(value);
                            dateTime = value;
                          });
                        },
                        child: Text("Pilih Tanggal"))
                  ],
                ),
              ),
              Container(
                child: Column(children: <Widget>[
                  const Text("Ikon Kategori"),
                  InkWell(
                    onTap: () {
                      context
                          .read<CategoryBloc>()
                          .add(ReadIconCategoryDefault());
                      Navigator.pushNamed(
                          context, AppRoutes.settCategorySelectIcon);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          foregroundColor: Colors.red,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/icons/$selectedImage.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ]),
              ),
              Container(
                child: Column(
                  children: [
                    Text("Judul"),
                    TextFormField(
                      decoration: InputDecoration(helperText: "Ketikan Judul"),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text("Keterangan"),
                    TextFormField(
                      decoration: InputDecoration(helperText: "Ketikan Judul"),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text("Nominal"),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(helperText: "Ketikan Judul"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSegment(String text) {
  return Container(
    child: Text(
      text,
      style: TextStyle(fontSize: 22, color: Colors.black),
    ),
  );
}
