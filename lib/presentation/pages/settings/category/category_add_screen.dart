import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/category_select_icon_screen.dart';

import '../../../../data/constants.dart';

class CategoryAddScreen extends StatelessWidget {
  CategoryAddScreen({super.key});

  GlobalKey<FormState> formKeyCtgr = GlobalKey<FormState>();

  Category? selectedCategory = Category(
      name: "Bunga",
      iconName: "collect-interest",
      createdTime: DateTime.now().toString(),
      modifieldTime: "",
      isDefault: 0);

  TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('category-addnew'.tr()),
        ),
        body: BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SuccessCallbackIconCategory) {
              selectedCategory = state.value;
            }
            return SingleChildScrollView(
              child: Form(
                key: formKeyCtgr,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: customCircularBox(
                            color: Colors.white.withOpacity(0.9)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('category-name'.tr()),
                            SB_Height10,
                            TextFormField(
                              controller: categoryNameController,
                              onSaved: (newValue) {
                                if (newValue!.isNotEmpty || newValue != "") {
                                  selectedCategory?.name = newValue;
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return 'name-not-null'.tr();
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'category-typing'.tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: customCircularBox(
                            color: Colors.white.withOpacity(0.9)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text('category'.tr())),
                            SB_Height10,
                            InkWell(
                              onTap: () {
                                context
                                    .read<CategoryBloc>()
                                    .add(ReadIconCategoryDefault(isDefault: 1));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategorySelectIconScreen(
                                              selectedIconName:
                                                  selectedCategory?.iconName,
                                            )));
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  foregroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/icons/${selectedCategory!.iconName}.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                title: Text(selectedCategory?.name ?? ""),
                                trailing:
                                    const Icon(Icons.arrow_drop_down_sharp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKeyCtgr.currentState!.validate()) {
                              formKeyCtgr.currentState!.save();

                              Category value = Category(
                                  name: categoryNameController.text,
                                  iconName: selectedCategory!.iconName,
                                  createdTime: DateTime.now().toString(),
                                  modifieldTime: "",
                                  isDefault: 0);
                              context.read<CategoryBloc>().add(
                                  CreateCategoryEvent(valueCategory: value));
                              context
                                  .read<CategoryBloc>()
                                  .add(ReadCategory(isDefault: 0));
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: lightBlue,
                          ),
                          child: Text('save'.tr()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
