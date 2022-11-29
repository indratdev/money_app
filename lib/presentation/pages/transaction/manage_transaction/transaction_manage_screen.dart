import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/moneyapp_screen.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../data/constants.dart';
import '../../../../data/date_util.dart';
import '../../../../domain/entities/category.dart';
import '../../settings/category/bloc/category_bloc.dart';
import '../bloc/transaction_bloc.dart';
import 'widgets/widget_manage_transaction.dart';

class TransactionManageScreen extends StatelessWidget {
  TransactionManageScreen({
    super.key,
    this.data,
  });

  Transaction? data = Transaction(createdTime: '', idCategory: 0, title: '');

  Category category = Category(
      name: "Bunga",
      iconName: "collect-interest",
      createdTime: "",
      modifieldTime: "",
      isDefault: 1);
  // Transaction? tempData =
  //     Transaction(createdTime: '', idCategory: 0, title: '');
  // static final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController deskriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final focusedCtx = FocusManager.instance.primaryFocus!.context;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('change-transaction'.tr()),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.first);
              context.read<TransactionBloc>().add(ReadTransactionEvent(
                  transactionDateTime: DateUtil().getCurrentDate()));
            },
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  CustomWidgets.showConfirmationDelete(
                      context, 'confirm-transaction-delete'.tr(), () {
                    // delete
                    context
                        .read<TransactionBloc>()
                        .add(DeleteTransactionEvent(idTransaction: data!.id!));
                    // read
                    context.read<TransactionBloc>().add(ReadTransactionEvent(
                        transactionDateTime: DateUtil().getCurrentDate()));

                    // Navigator.of(context, rootNavigator: true).pop();
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                    // Navigator.pushReplacementNamed(context, AppRoutes.first);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoneyappScreen(),
                        ));
                  });
                },
                icon: const Icon(Icons.delete_forever))
          ],
        ),
        body: BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SuccessCallbackIconCategory) {
              data?.idCategory = state.value.id ?? 1;
              data?.categoryIconName = state.value.iconName;
              data?.categoryName = state.value.name;
            }
            if (state is SuccessReadCategoryById) {
              category = state.result;
            }
            return BlocConsumer<TransactionBloc, TransactionState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SuccessSelectedIsOutcome) {
                  data!.isOutcome = state.result;
                }
                if (state is SuccessSelectedDate) {
                  data!.createdTime = state.result;
                  data!.modifieldTrxTime = DateUtil().getCurrentDate();
                  data!.isModifield = 1;
                }
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: bloomColor,
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            flex: 9,
                            child: Container(
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    ContainerTypeTransaction(
                                        data: data), // type transactions

                                    ContainerDateTransaction(
                                        data: data), // tanggal

                                    // kategori
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.all(8),
                                      decoration: customCircularBox(
                                          color: Colors.white.withOpacity(0.9)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text('category'.tr())),
                                          SB_Height10,
                                          InkWell(
                                            onTap: () {
                                              if (data!.idCategory > 0) {
                                                context
                                                    .read<CategoryBloc>()
                                                    .add(ChangeIconCategory(
                                                        categoryValue:
                                                            category));
                                              }

                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushNamed(AppRoutes
                                                      .transactionCategory);
                                            },
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25,
                                                foregroundColor:
                                                    Colors.transparent,
                                                child: ClipOval(
                                                  child: Image.asset(
                                                    "assets/icons/${data!.categoryIconName}.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              title: Text(data!.categoryName
                                                  .toString()),
                                              trailing: const Icon(
                                                  Icons.arrow_drop_down_sharp),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // name
                                    ContainerNameTransaction(
                                        nameController: nameController,
                                        data: data),

                                    // Deskripsi
                                    ContainerDescriptionTransaction(
                                        deskriptionController:
                                            deskriptionController,
                                        data: data),

                                    // nominal
                                    ContainerAmountTransaction(
                                        amountController: amountController,
                                        data: data),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // section button

                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    // action save
                                    context.read<TransactionBloc>().add(
                                        UpdateTransactionEvent(
                                            idTransaction: data!.id!,
                                            valueTransaction: data!));
                                  }
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.first);
                                },
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
            );
          },
        ),
      ),
    );
  }
}

Widget buildSegmentComponent(String text) {
  return Container(
    child: Text(
      text,
      style: TextStyle(fontSize: 22, color: Colors.black),
    ),
  );
}
