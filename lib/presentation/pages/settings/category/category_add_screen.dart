import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

class CategoryAddScreen extends StatelessWidget {
  CategoryAddScreen({super.key});

  String selectedImage = "collect-interest";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Penambahan Kategori"),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Nama Kategori"),
          TextField(decoration: InputDecoration()),
          SizedBox(height: 15),
          Text("Ikon Kategori"),
          InkWell(
            onTap: () {
              context.read<CategoryBloc>().add(ReadIconCategoryDefault());
              Navigator.pushNamed(context, AppRoutes.settCategorySelectIcon);
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundColor: Colors.red,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/icons/$selectedImage.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          Divider(height: 1)
        ],
      )),
    );
  }
}
