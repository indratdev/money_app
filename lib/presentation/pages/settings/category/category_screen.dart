import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("Leading"),
                title: Text("title"),
              );
            },
          );
        },
      ),
      // body: Column(
      //   children: <Widget>[
      //     // container pilihan
      //     Container(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               primary: Colors.red,
      //               onPrimary: Colors.white,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(18.0),
      //               ),
      //             ),
      //             onPressed: () {},
      //             child: Text("Pendapatan"),
      //           ),
      //           SB_Width10,
      //           ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               primary: Colors.red,
      //               onPrimary: Colors.white,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(18.0),
      //               ),
      //             ),
      //             onPressed: () {},
      //             child: Text("Pengeluaran"),
      //           ),
      //         ],
      //       ),
      //     ),
      //     SB_Height20,
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: 50,
      //         itemBuilder: (context, index) {
      //           return Text("data");
      //         },
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
