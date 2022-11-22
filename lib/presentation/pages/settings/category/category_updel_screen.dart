import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/category_select_icon_screen.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../../data/constants.dart';
import '../../../../domain/entities/category.dart';
import 'bloc/category_bloc.dart';

class CategoryUpDelScreen extends StatelessWidget {
  CategoryUpDelScreen({
    super.key,
    this.selectedImage = "",
    this.oldValueCategory,
  });

  GlobalKey<FormState> formKeyCtgrM = GlobalKey<FormState>();

  String selectedImage;
  TextEditingController categoryNameController = TextEditingController();
  Category? valueCategory;
  Category? oldValueCategory;

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;
    return WillPopScope(
      onWillPop: () async {
        context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('change-category'.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                CustomWidgets.showConfirmationDelete(
                    context, 'confirm-delete-data'.tr(), () {
                  context.read<CategoryBloc>().add(DeleteCategoryEvent(
                      idCategory: oldValueCategory?.id ?? 0));
                  context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                });
              },
            )
          ],
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is SuccessCallbackIconName) {
              selectedImage = state.resultSelectedIconName;
            }
            if (state is LoadingReadCategoryById) {
              return Center(child: Text('loading'.tr()));
            }
            if (state is FailureReadCategoryById) {
              return Center(child: Text(state.messageError));
            }

            if (state is SuccessCallbackIconCategory) {
              valueCategory = state.value;
              selectedImage = state.value.iconName;
            }

            if (state is SuccessReadCategoryById) {
              valueCategory = state.result;
              selectedImage = state.result.iconName;
            }
            return Container(
              decoration: (stateTheme == Brightness.light)
                  ? backgroundThemeLight
                  : backgroundThemeDark,
              child: Form(
                key: formKeyCtgrM,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: customCircularBox(
                            color: (stateTheme == Brightness.light)
                                ? lightWhite
                                : blackN),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('category-name'.tr()),
                            SB_Height10,
                            TextFormField(
                              controller: categoryNameController
                                // ..text = valueCategory?.name.toString() ?? "",
                                ..text = oldValueCategory?.name ?? "",
                              onSaved: (newValue) {
                                if (newValue!.isNotEmpty || newValue != "") {
                                  // valueCategory?.name = newValue;
                                  valueCategory?.name = newValue;
                                }
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty || value != "") {
                                  oldValueCategory?.name = value;
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return 'name-not-null'.tr();
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
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
                            // color: Colors.white.withOpacity(0.9)),
                            color: (stateTheme == Brightness.light)
                                ? lightWhite
                                : blackN),
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
                                              selectedIconName: selectedImage),
                                    ));
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  foregroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/icons/$selectedImage.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                title: Text(selectedImage),
                                trailing:
                                    const Icon(Icons.arrow_drop_down_sharp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKeyCtgrM.currentState!.validate()) {
                                formKeyCtgrM.currentState!.save();

                                Category value = Category(
                                  name: oldValueCategory?.name ?? "",
                                  iconName: selectedImage,
                                  createdTime:
                                      oldValueCategory?.createdTime ?? "",
                                  modifieldTime: DateTime.now().toString(),
                                  isDefault: 0,
                                );

                                context
                                    .read<CategoryBloc>()
                                    .add(UpdateCategoryEvent(
                                      idCategory: oldValueCategory?.id ?? 0,
                                      valueCategory: value,
                                    ));

                                context
                                    .read<CategoryBloc>()
                                    .add(ReadCategory(isDefault: 0));
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: bluePaypal,
                            ),
                            child: Text('save'.tr()),
                          ),
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
