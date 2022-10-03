import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

class CategorySelectIconScreen extends StatelessWidget {
  CategorySelectIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Ikon"),
        actions: [
          TextButton(
              onPressed: () {},
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Selesai",
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is SuccessReadIconCategoryDefault) {
            final result = state.result;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: result.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {},

                    /// masih disini
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: Colors.amber,
                        // check if the index is equal to the selected Card integer
                        // color: selectedCard == index ? Colors.blue : Colors.amber,
                      ),
                      // child: Text(myProducts[index]["name"]),
                      child: CircleAvatar(
                        radius: 30,
                        foregroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icons/${result[index].iconName}.png',
                            fit: BoxFit.fill,
                            // color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
