import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

class CategorySelectIconScreen extends StatelessWidget {
  CategorySelectIconScreen({super.key});

  List<Category>? listCategoryIcon;
  String selectedIconName = "";
  int selectedIconID = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Ikon"),
        actions: [
          TextButton(
              onPressed: () {},
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Selesai",
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is SuccessSelectedIcon) {
            selectedIconID = state.resultSelectedIconID;
          }
        },
        builder: (context, state) {
          if (state is SuccessReadIconCategoryDefault) {
            listCategoryIcon = state.result;
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: listCategoryIcon?.length ?? 0,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: () {
                    context.read<CategoryBloc>().add(SelectedIconEvent(
                        iconID: listCategoryIcon?[index].id ?? 1));
                    // print(result[index].iconName);
                    // print(result[index].id);
                  },

                  /// masih disini
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Colors.amber,
                      // check if the index is equal to the selected Card integer
                      color: selectedIconID == listCategoryIcon?[index].id
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    // child: Text(myProducts[index]["name"]),
                    child: CircleAvatar(
                      radius: 30,
                      foregroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icons/${listCategoryIcon?[index].iconName}.png',
                          fit: BoxFit.fill,
                          // color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
