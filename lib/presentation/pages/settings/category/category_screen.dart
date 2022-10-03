import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

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
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is SuccessReadCategory) {
            final result = state.result;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: result.length,
              itemBuilder: (context, index) {
                return ListTile(
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
