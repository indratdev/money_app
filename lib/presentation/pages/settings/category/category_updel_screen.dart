import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        context.read<CategoryBloc>().add(ReadCategory());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Ubah Kategori"), actions: [
          TextButton(
              onPressed: () {},
              child: Text("Hapus", style: TextStyle(color: Colors.white)))
        ]),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is LoadingReadCategoryById) {
              return const Center(child: Text("Memuat"));
            }
            if (state is FailureReadCategoryById) {
              return Center(child: Text(state.messageError));
            }
            if (state is SuccessReadCategoryById) {
              valueCategory = state.result;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Nama Kategori"),
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
                          // context.read<CategoryBloc>().add(ReadIconCategoryDefault());
                          // Navigator.pushNamed(
                          //     context, AppRoutes.settCategorySelectIcon);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              foregroundColor: Colors.red,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/icons/${valueCategory?.iconName}.png",
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
                                iconName: selectedImage,
                                createdTime: DateTime.now().toString(),
                                modifieldTime: "",
                                isDefault: 0);
                            // context
                            //     .read<CategoryBloc>()
                            //     .add(CreateCategoryEvent(valueCategory: value));
                            // context.read<CategoryBloc>().add(ReadCategory());
                            // Navigator.pop(context);
                          },
                          child: const Text("Ubah"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
