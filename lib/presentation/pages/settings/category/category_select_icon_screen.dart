import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

import '../../../../data/constants.dart';

class CategorySelectIconScreen extends StatelessWidget {
  CategorySelectIconScreen({super.key});

  List<Category>? listCategoryIcon;
  // String selectedIconName = "";
  Category? selectedCatecory = Category(
      name: "Bunga",
      iconName: "collect-interest",
      createdTime: DateTime.now().toString(),
      modifieldTime: "",
      isDefault: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Pilih Ikon"),
        actions: [
          TextButton(
            onPressed: () {
              // context.read<CategoryBloc>().add(
              //     CallbackIconNameEvent(iconName: selectedCatecory!.iconName));

              // add transaction
              context
                  .read<CategoryBloc>()
                  .add(CallbackIconCategoryEvent(value: selectedCatecory!));

              Navigator.pop(context);
            },
            child: const Text(
              "Selesai",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is SuccessReadCategoryById) {
            selectedCatecory = state.result;
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
                  context.read<CategoryBloc>().add(ReadCategoryByIdEvent(
                      idCategory: listCategoryIcon?[index].id ?? 1));
                  // print(listCategoryIcon?[index].id);
                },

                /// masih disini
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: selectedCatecory?.iconName ==
                            listCategoryIcon?[index].iconName
                        ? lightPurple // Colors.amber.shade300
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
            },
          );
        },
      ),
    );
  }
}
