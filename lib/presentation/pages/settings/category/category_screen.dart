import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/routes/app_routes.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/category_updel_screen.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';
import 'package:money_app/presentation/widgets/no_data_widget.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('category'.tr()),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.settCategoryAdd);
          },
          child: const Icon(Icons.add)),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is FailureDeleteCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, 'error-delete-category'.tr(), false);
          }
          if (state is SuccessDeleteCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, 'success-delete-category'.tr(), true);
          }

          if (state is FailureUpdateCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, 'success-delete-category'.tr(), true);
          }

          if (state is SuccessUpdateCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, 'success-update-category'.tr(), true);
          }

          if (state is FailureCreateCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, 'error-add-category'.tr(), true);
          }
          if (state is SuccessCreateCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, 'success-add-category'.tr(), true);
          }
        },
        builder: (context, state) {
          if (state is LoadingReadOpsCategory) {
            CustomWidgets.showLoadingWidget();
          }

          if (state is FailureReadOpsCategory) {
            CustomWidgets.showMessageAlertBasic(
                context, ' error-read-category'.tr(), true);
          }

          if (state is SuccessReadOpsCategory) {
            final result = state.result;
            return (result.length > 0)
                ? ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoryUpDelScreen(
                              selectedImage: result[index].iconName,
                              oldValueCategory: result[index],
                            ),
                          ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            foregroundColor: Colors.transparent,
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
                  )
                : const NoDataWidget();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
