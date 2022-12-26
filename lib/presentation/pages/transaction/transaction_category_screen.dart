import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';
import 'package:money_app/presentation/widgets/no_data_widget.dart';

import '../../../data/constants.dart';

class TransactionCategoryScreen extends StatefulWidget {
  TransactionCategoryScreen({super.key});

  @override
  State<TransactionCategoryScreen> createState() =>
      _TransactionCategoryScreenState();
}

class _TransactionCategoryScreenState extends State<TransactionCategoryScreen> {
  List<Category>? listCategoryIcon;

  @override
  void initState() {
    super.initState();

    context.read<CategoryBloc>().add(ReadIconCategoryDefault(isDefault: 0));
  }

  Category? selectedCatecory = Category(
    name: "",
    iconName: "choose-file",
    createdTime: DateTime.now().toString(),
    modifieldTime: "",
    isDefault: 0,
  );

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: Text('choose-category'.tr()),
        actions: [
          IconButton(
            onPressed: () {
              // validasi
              if (selectedCatecory?.name == "") {
                CustomWidgets.showMessageAlertBasic(
                    context, 'change-category-no-selectedData'.tr(), false);
              } else {
                // add transaction
                context
                    .read<CategoryBloc>()
                    .add(CallbackIconCategoryEvent(value: selectedCatecory!));

                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.check),
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

          if (state is SuccessChangeIconCategory) {
            selectedCatecory = state.categoryValue;
          }
          return (listCategoryIcon?.length == 0)
              ? const NoDataWidget()
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: listCategoryIcon?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.read<CategoryBloc>().add(ReadCategoryByIdEvent(
                            idCategory: listCategoryIcon?[index].id ?? 1));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: selectedCatecory?.iconName ==
                                  listCategoryIcon?[index].iconName
                              ? (stateTheme == Brightness.light)
                                  ? lightMildWaters
                                  : lightBlue
                              : Colors.transparent,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: CircleAvatar(
                            radius: 30,
                            foregroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/${listCategoryIcon?[index].iconName}.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: Text(
                              listCategoryIcon?[index].name.toString() ?? ""),
                        ),
                      ),
                    );
                  },
                );
          // : const NoDataWidget();
        },
      ),
    );
  }
}
