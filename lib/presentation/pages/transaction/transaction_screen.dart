import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../data/constants.dart';
import '../settings/category/bloc/category_bloc.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  // late FocusNode myFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController deskriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Transaction transaction =
        Transaction(idCategory: 0, title: "", createdTime: todayTime);

    // String selectedImage = "collect-interest";
    Category category = Category(
        name: "Bunga",
        iconName: "collect-interest",
        createdTime: "",
        modifieldTime: "",
        isDefault: 1);

    // int? groupValue = 0;
    // DateTime? dateTime;
    // String selectedImage = "collect-interest";

    // final halfMediaWidth = MediaQuery.of(context).size.width - 10;
    // final mediaHeight = MediaQuery.of(context).size.height / 3;
    // var today = DateTime.now().toString;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaksi"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      transaction.title = nameController.text;
                    },
                    onFieldSubmitted: (value) {
                      print("<<< onFieldSubmitted");
                      // transaction.title = value;
                      nameController.text = value;
                    },
                    autofocus: false,

                    // onSaved: (newValue) {
                    //   if (newValue!.isNotEmpty || newValue != "") {
                    //     transaction.title = newValue;
                    //   }
                    // },
                    // validator: (value) {
                    //   if (value!.isEmpty || value == "") {
                    //     return "Nama Tidak Boleh Kosong";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "contoh: Susilo Bambang",
                      labelText: "Nama Lengkap",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "contoh: Susilo Bambang",
                      labelText: "Nama Lengkap",
                      icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     obscureText: true,
                //     decoration: InputDecoration(
                //       labelText: "Password",
                //       icon: Icon(Icons.security),
                //       border: OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(5.0)),
                //     ),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Password tidak boleh kosong';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // CheckboxListTile(
                //   title: Text('Belajar Dasar Flutter'),
                //   subtitle: Text('Dart, widget, http'),
                //   // value: nilaiCheckBox,
                //   activeColor: Colors.deepPurpleAccent,
                // onChanged: (value) {
                //   setState(() {
                //     nilaiCheckBox = value!;
                //   });
                // },
                // ),
                // SwitchListTile(
                //   title: Text('Backend Programming'),
                //   subtitle: Text('Dart, Nodejs, PHP, Java, dll'),
                //   value: nilaiSwitch,
                //   activeTrackColor: Colors.pink[100],
                //   activeColor: Colors.red,
                //   onChanged: (value) {
                //     setState(() {
                //       nilaiSwitch = value;
                //     });
                //   },
                // ),
                // Slider(
                //   value: nilaiSlider,
                //   min: 0,
                //   max: 100,
                //   onChanged: (value) {
                //     setState(() {
                //       nilaiSlider = value;
                //     });
                //   },
                // ),
                ElevatedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  // color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
        // ),
        // );
        // return Form(
        //   key: _formKey,
        //   child: Padding(
        //     padding: const EdgeInsets.all(10),
        //     child: Column(
        //       children: <Widget>[
        //         // section form
        //         Flexible(
        //           flex: 9,
        //           child: Container(
        //             color: Colors.white,
        //             child: SingleChildScrollView(
        //               keyboardDismissBehavior:
        //                   ScrollViewKeyboardDismissBehavior.onDrag,
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.stretch,
        //                 children: <Widget>[
        //                   // segement control
        //                   CupertinoSlidingSegmentedControl<int>(
        //                     backgroundColor:
        //                         CupertinoColors.lightBackgroundGray,
        //                     thumbColor: Colors.blue,
        //                     padding: const EdgeInsets.all(8),
        //                     groupValue: transaction.isOutcome,
        //                     children: {
        //                       0: buildSegment("Penerimaan"),
        //                       1: buildSegment("Pengeluaran"),
        //                     },
        //                     onValueChanged: (value) {
        //                       context.read<TransactionBloc>().add(
        //                           SelectedIsOutcomeEvent(
        //                               value: value ?? 0));
        //                       transaction.isOutcome = value!;
        //                     },
        //                   ),
        //                   SB_Height20,

        //                   // tanggal
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const Text("Tanggal"),
        //                       InkWell(
        //                         onTap: () {
        //                           showDatePicker(
        //                                   context: context,
        //                                   initialDate: DateTime.now(),
        //                                   firstDate: DateTime(1900),
        //                                   lastDate: DateTime(9999))
        //                               .then((value) {
        //                             context.read<TransactionBloc>().add(
        //                                 SelectedDateEvent(
        //                                     value: value.toString()));
        //                           });
        //                         },
        //                         child: ListTile(
        //                           leading:
        //                               const Icon(Icons.calendar_month),
        //                           title: Text(DateFormat('dd / MM / yyyy')
        //                               .format(DateTime.parse(
        //                                   transaction.createdTime))),
        //                           trailing: const Icon(
        //                               Icons.arrow_drop_down_sharp),
        //                         ),
        //                       ),
        //                     ],
        //                   ),

        //                   SB_Height30,
        //                   // kategori
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const Text("Kategori"),
        //                       SB_Height10,
        //                       InkWell(
        //                         onTap: () {
        //                           context
        //                               .read<CategoryBloc>()
        //                               .add(ReadIconCategoryDefault());
        //                           // Navigator.pushNamed(
        //                           //     context, AppRoutes.transactionIcon);
        //                           // Navigator.of(context)
        //                           //     .pushNamed(AppRoutes.transactionIcon);
        //                           Navigator.of(context,
        //                                   rootNavigator: true)
        //                               .pushNamed(
        //                                   AppRoutes.transactionIcon);
        //                         },
        //                         child: ListTile(
        //                           leading: CircleAvatar(
        //                             radius: 25,
        //                             foregroundColor: Colors.red,
        //                             child: ClipOval(
        //                               child: Image.asset(
        //                                 "assets/icons/${category.iconName}.png",
        //                                 fit: BoxFit.fill,
        //                               ),
        //                             ),
        //                           ),
        //                           title: Text(category.name),
        //                           trailing: const Icon(
        //                               Icons.arrow_drop_down_sharp),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SB_Height30,
        //                   // nama
        //                   // ListView(
        //                   //   scrollDirection: Axis.vertical,
        //                   //   shrinkWrap: true,
        //                   //   children: <Widget>[
        //                   //     Text("Nama"),
        //                   //     TextFormField(
        //                   //       // controller: nameController,
        //                   //       // onSaved: (newValue) {
        //                   //       //   if (newValue!.isNotEmpty ||
        //                   //       //       newValue != "") {
        //                   //       //     transaction.title = newValue;
        //                   //       //   }
        //                   //       // },
        //                   //       // validator: (value) {
        //                   //       //   if (value!.isEmpty || value == "") {
        //                   //       //     return "Nama Tidak Boleh Kosong";
        //                   //       //   }
        //                   //       //   return null;
        //                   //       // },

        //                   //       // keyboardType: TextInputType.text,

        //                   //       decoration: const InputDecoration(
        //                   //         hintText: "Ketikan Nama Transaksi",
        //                   //       ),
        //                   //     ),
        //                   //   ],
        //                   // )
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const Text("Nama"),
        //                       SB_Height10,
        //                       TextFormField(
        //                         controller: nameController,
        //                         onChanged: (value) {
        //                           nameController.text = value;
        //                         },
        //                         onSaved: (newValue) {
        //                           if (newValue!.isNotEmpty ||
        //                               newValue != "") {
        //                             transaction.title = newValue;
        //                           }
        //                         },
        //                         validator: (value) {
        //                           if (value!.isEmpty || value == "") {
        //                             return "Nama Tidak Boleh Kosong";
        //                           }
        //                           return null;
        //                         },

        //                         // keyboardType: TextInputType.text,

        //                         decoration: const InputDecoration(
        //                           hintText: "Ketikan Nama Transaksi",
        //                         ),
        //                       ),
        //                     ],
        //                   ),

        //                   // SB_Height30,
        //                   // // Deskripsi
        //                   // Column(
        //                   //   crossAxisAlignment: CrossAxisAlignment.start,
        //                   //   children: [
        //                   //     const Text("Deskripsi"),
        //                   //     SB_Height10,
        //                   //     TextFormField(
        //                   //       keyboardType: TextInputType.text,
        //                   //       controller: deskriptionController,
        //                   //       decoration: const InputDecoration(
        //                   //         hintText:
        //                   //             "Ketikan Deskripsi Transaksi (optional)",
        //                   //       ),
        //                   //     ),
        //                   //   ],
        //                   // ),

        //                   // SB_Height30,
        //                   // // nominal
        //                   // Column(
        //                   //   crossAxisAlignment: CrossAxisAlignment.start,
        //                   //   children: [
        //                   //     const Text("Nominal"),
        //                   //     SB_Height10,
        //                   //     TextFormField(
        //                   //       keyboardType: TextInputType.number,
        //                   //       controller: amountController,
        //                   //       style: const TextStyle(
        //                   //         fontWeight: FontWeight.w500,
        //                   //         fontSize: 30,
        //                   //       ),
        //                   //       decoration: const InputDecoration(
        //                   //         contentPadding: EdgeInsets.symmetric(
        //                   //           horizontal: 20,
        //                   //           vertical: 20,
        //                   //         ),
        //                   //         hintText: "0",
        //                   //       ),
        //                   //     ),
        //                   //   ],
        //                   // ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),

        //         // section button
        //         // Flexible(
        //         //   flex: 1,
        //         //   child: SizedBox(
        //         //     width: MediaQuery.of(context).size.width / 3,
        //         //     child: ElevatedButton(
        //         //       onPressed: () {
        //         //         if (_formKey.currentState!.validate()) {
        //         //           _formKey.currentState!.save();
        //         //           print(transaction);
        //         //         }
        //         //       },
        //         //       child: const Text("Simpan"),
        //         //     ),
        //         //   ),
        //         // ),
        //       ],
        //     ),
        //   ),
        // );
        // },
        // );
        // },
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

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     title: "Belajar Form Flutter",
//     home: TransactionScreen(),
//   ));
// }

// class TransactionScreen extends StatefulWidget {
//   @override
//   _TransactionScreenState createState() => _TransactionScreenState();
// }

// class _TransactionScreenState extends State<TransactionScreen> {
//   final _formKey = GlobalKey<FormState>();

//   double nilaiSlider = 1;
//   bool nilaiCheckBox = false;
//   bool nilaiSwitch = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("BelajarFlutter.com"),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     decoration: new InputDecoration(
//                       hintText: "contoh: Susilo Bambang",
//                       labelText: "Nama Lengkap",
//                       icon: Icon(Icons.people),
//                       border: OutlineInputBorder(
//                           borderRadius: new BorderRadius.circular(5.0)),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Nama tidak boleh kosong';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     obscureText: true,
//                     decoration: new InputDecoration(
//                       labelText: "Password",
//                       icon: Icon(Icons.security),
//                       border: OutlineInputBorder(
//                           borderRadius: new BorderRadius.circular(5.0)),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Password tidak boleh kosong';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 CheckboxListTile(
//                   title: Text('Belajar Dasar Flutter'),
//                   subtitle: Text('Dart, widget, http'),
//                   value: nilaiCheckBox,
//                   activeColor: Colors.deepPurpleAccent,
//                   onChanged: (value) {
//                     setState(() {
//                       nilaiCheckBox = value!;
//                     });
//                   },
//                 ),
//                 SwitchListTile(
//                   title: Text('Backend Programming'),
//                   subtitle: Text('Dart, Nodejs, PHP, Java, dll'),
//                   value: nilaiSwitch,
//                   activeTrackColor: Colors.pink[100],
//                   activeColor: Colors.red,
//                   onChanged: (value) {
//                     setState(() {
//                       nilaiSwitch = value;
//                     });
//                   },
//                 ),
//                 Slider(
//                   value: nilaiSlider,
//                   min: 0,
//                   max: 100,
//                   onChanged: (value) {
//                     setState(() {
//                       nilaiSlider = value;
//                     });
//                   },
//                 ),
//                 ElevatedButton(
//                   child: Text(
//                     "Submit",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   // color: Colors.blue,
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {}
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
