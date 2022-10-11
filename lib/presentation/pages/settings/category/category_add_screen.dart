import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

class CategoryAddScreen extends StatelessWidget {
  CategoryAddScreen({super.key});

  // String selectedImage = "collect-interest";
  Category? selectedCatecory = Category(
      name: "Bunga",
      iconName: "collect-interest",
      createdTime: DateTime.now().toString(),
      modifieldTime: "",
      isDefault: 0);

  TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Penambahan Kategori"),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          // if (state is SuccessCallbackIconName) {
          //   selectedImage = state.resultSelectedIconName;
          //   print("hasil ::: $selectedImage");
          // }
          if (state is SuccessCallbackIconCategory) {
            selectedCatecory = state.value;
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nama Kategori"),
                  TextField(
                    controller: categoryNameController,
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
                              "assets/icons/${selectedCatecory!.iconName}.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Category value = Category(
                            name: categoryNameController.text,
                            iconName: selectedCatecory!.iconName,
                            createdTime: DateTime.now().toString(),
                            modifieldTime: "",
                            isDefault: 0);
                        context
                            .read<CategoryBloc>()
                            .add(CreateCategoryEvent(valueCategory: value));
                        context
                            .read<CategoryBloc>()
                            .add(ReadCategory(isDefault: 0));
                        Navigator.pop(context);
                      },
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
