import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

import '../../../../data/constants.dart';

class CategorySelectIconScreen extends StatefulWidget {
  CategorySelectIconScreen({
    super.key,
    this.selectedIconName,
  });

  String? selectedIconName;

  @override
  State<CategorySelectIconScreen> createState() =>
      _CategorySelectIconScreenState();
}

class _CategorySelectIconScreenState extends State<CategorySelectIconScreen> {
  List<Category>? listCategoryIcon;

  // int selectedId = 1;
  String? selectedCategoryIconName;
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategoryIconName = widget.selectedIconName;
    print("selectedCategoryIconName ::: $selectedCategoryIconName");
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments as Map);
    // oldCategory = arguments['selectedCategory'];

    return Scaffold(
      appBar: AppBar(
        title: Text('icon-selected'.tr()),
        actions: [
          IconButton(
            iconSize: MediaQuery.of(context).size.width / 11,
            padding: const EdgeInsets.only(right: 15),
            onPressed: () {
              context
                  .read<CategoryBloc>()
                  .add(CallbackIconCategoryEvent(value: selectedCategory!));

              print("selectedCategory ::: $selectedCategory");

              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is SuccessReadIconCategoryDefault) {
            listCategoryIcon = state.result;
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: listCategoryIcon?.length ?? 0,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  // context.read<CategoryBloc>().add(ReadCategoryByIdEvent(
                  //     idCategory: listCategoryIcon?[index].id ?? 1));
                  // print(listCategoryIcon?[index].id);
                  selectedCategoryIconName = listCategoryIcon?[index].iconName;
                  selectedCategory = listCategoryIcon?[index];
                  setState(() {});
                },

                /// masih disini
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: selectedCategoryIconName ==
                            listCategoryIcon?[index].iconName
                        ? lightPurple // Colors.amber.shade300
                        : Colors.transparent,
                    // Colors.amber,
                    // selectedCategory?.iconName ==
                    //         listCategoryIcon?[index].iconName
                    //     ? lightPurple // Colors.amber.shade300
                    //     : Colors.transparent,
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
