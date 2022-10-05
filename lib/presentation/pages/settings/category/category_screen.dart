import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.settCategoryAdd);
          },
          child: Icon(Icons.add)),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is SuccessDeleteCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, "Kategori Berhasil Dihapus");
          }
          if (state is SuccessUpdateCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, "Kategori Berhasil Diperbaharui");
          }
          if (state is SuccessCreateCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, "Kategori Baru Berhasil Ditambahkan");
          }
        },
        builder: (context, state) {
          if (state is LoadingReadCategory) {
            CustomWidgets.showLoadingWidget();
          }
          if (state is SuccessReadCategory) {
            final result = state.result;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: result.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.read<CategoryBloc>().add(
                        ReadCategoryByIdEvent(idCategory: result[index].id!));
                    Navigator.pushNamed(context, AppRoutes.settCategoryUpDel);
                    print("tap id category: ${result[index].id}");
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      foregroundColor: Colors.red,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icons/${result[index].iconName}.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Text(result[index].name),
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
