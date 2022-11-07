import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../domain/entities/category.dart';
import 'bloc/category_bloc.dart';

class CategoryUpDelScreen extends StatelessWidget {
  CategoryUpDelScreen({super.key});

  String selectedImage = "collect-interest";
  TextEditingController categoryNameController = TextEditingController();
  Category? valueCategory;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('change-category'.tr()), actions: [
          TextButton(
              onPressed: () {
                CustomWidgets.showConfirmationDelete(
                    context, "Apakah anda yakin ingin hapus data ini ? ", () {
                  context.read<CategoryBloc>().add(
                      DeleteCategoryEvent(idCategory: valueCategory?.id ?? 0));
                  context.read<CategoryBloc>().add(ReadCategory(isDefault: 1));
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                });
              },
              child: Text("Hapus", style: TextStyle(color: Colors.white)))
        ]),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is SuccessCallbackIconName) {
              selectedImage = state.resultSelectedIconName;
            }
            if (state is LoadingReadCategoryById) {
              return const Center(child: Text("Memuat..."));
            }
            if (state is FailureReadCategoryById) {
              return Center(child: Text(state.messageError));
            }
            if (state is SuccessReadCategoryById) {
              print("mulai :: $state.result");
              valueCategory = state.result;
              selectedImage = state.result.iconName;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Nama Kategori"),
                    TextField(
                      controller: categoryNameController
                        ..text = valueCategory?.name.toString() ?? "",
                      obscureText: false,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Ketik Nama Kategori",
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text("Ikon Kategori"),
                    InkWell(
                      onTap: () {
                        context
                            .read<CategoryBloc>()
                            .add(ReadIconCategoryDefault(isDefault: 1));
                        Navigator.pushNamed(
                            context, AppRoutes.settCategorySelectIcon);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            foregroundColor: Colors.red,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/icons/$selectedImage.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    const SizedBox(height: 35),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: ElevatedButton(
                          onPressed: () {
                            Category value = Category(
                                name: categoryNameController.text,
                                iconName: selectedImage,
                                createdTime: valueCategory?.createdTime ?? "",
                                modifieldTime: DateTime.now().toString(),
                                isDefault: 0);

                            context.read<CategoryBloc>().add(
                                UpdateCategoryEvent(
                                    idCategory: valueCategory?.id ?? 0,
                                    valueCategory: value));

                            context
                                .read<CategoryBloc>()
                                .add(ReadCategory(isDefault: 1));
                            Navigator.pop(context);
                          },
                          child: const Text("Simpan"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
