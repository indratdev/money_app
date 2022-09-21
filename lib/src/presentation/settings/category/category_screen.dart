import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryScreen extends StatelessWidget {
  int isPenerimaan = 1;
  List<CategoryModel> datas = [];

  CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/setting/kategori/add');
            // BlocProvider.of<CategoryBloc>(context).add(ReadAllCategoryMaster());
          },
          child: const Icon(Icons.add)),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is CategorySuccess) {
            print(">>>> ${state.isIncome}");
            datas = state.category;
            isPenerimaan = (state.isIncome == 1) ? 1 : 0;
          }

          if (state is CategoryLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is CategoryFailure) {
            return Center(child: Text(""));
          }

          return Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: (isPenerimaan == 1) ? Colors.red : Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CategoryBloc>(context)
                              .add(ViewCategoryEvent(IsIncome: 1));
                        },
                        child: Text("Penerimaan",
                            style: TextStyle(
                                color: (isPenerimaan == 1)
                                    ? Colors.white
                                    : Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0),
                          elevation: 0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: (isPenerimaan == 1) ? Colors.white : Colors.blue,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CategoryBloc>(context)
                              .add(ViewCategoryEvent(IsIncome: 0));
                        },
                        child: Text("Pengeluaran",
                            style: TextStyle(
                                color: (isPenerimaan == 1)
                                    ? Colors.black
                                    : Colors.white)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 8,
                child: ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    var iconss = (datas[index].iconName);

                    print(iconss);
                    return ListTile(
                      // IconDataBrands(0xf17b);
                      leading: Icon(CustomIcon.createDoc[iconss]),
                      title: Text(datas[index].name),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
