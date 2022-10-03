import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is SuccessReadCategory) {
            final result = state.result;
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                return Image.asset('assets/icons/collect-interest.png');
                // return ListTile(
                //   leading: Text(result[index].iconName),
                //   // leading: ClipRRect(
                //   //   borderRadius: BorderRadius.circular(8.0),
                //   //   child: Image.asset('assets/icons/collect-interest.png'),
                //   // ),
                //   title: Text(result[index].name),
                // );
              },
            );
          } else {
            return SizedBox();
          }
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
