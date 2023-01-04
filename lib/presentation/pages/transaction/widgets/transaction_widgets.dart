import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../data/constants.dart';
import '../../../../data/date_util.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/transaction.dart';
import '../../settings/category/bloc/category_bloc.dart';
import '../bloc/transaction_bloc.dart';

class SectionFormWidget extends StatelessWidget {
  const SectionFormWidget({
    Key? key,
    required this.stateTheme,
    required this.transaction,
    required this.category,
    required this.nameController,
    required this.deskriptionController,
    required this.amountController,
  }) : super(key: key);

  final Brightness stateTheme;
  final Transaction transaction;
  final Category category;
  final TextEditingController nameController;
  final TextEditingController deskriptionController;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 9,
      child: Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // segement control
              SegmentControlWidget(
                  stateTheme: stateTheme, transaction: transaction),

              // tanggal
              ContainerDate(stateTheme: stateTheme, transaction: transaction),

              // kategori
              ContainerCategory(
                  stateTheme: stateTheme,
                  transaction: transaction,
                  category: category),

              // name
              ContainerName(
                  stateTheme: stateTheme,
                  nameController: nameController,
                  transaction: transaction),

              // Deskripsi
              ContainerDescription(
                  stateTheme: stateTheme,
                  deskriptionController: deskriptionController,
                  transaction: transaction),

              // nominal
              ContainerAmount(
                  stateTheme: stateTheme,
                  amountController: amountController,
                  transaction: transaction),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionButtonSave extends StatelessWidget {
  const SectionButtonSave({
    Key? key,
    required this.formKeyTrx,
    required this.transaction,
  }) : super(key: key);

  final GlobalKey<FormState> formKeyTrx;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: bluePaypal),
          onPressed: () {
            if (formKeyTrx.currentState!.validate()) {
              formKeyTrx.currentState!.save();
              // action save
              context.read<TransactionBloc>()
                ..add(SaveTransactionNew(value: transaction))
                ..add(ReadTransactionEvent(
                    transactionDateTime: DateUtil().getCurrentDate()));

              // Navigator.pop(context);
            }
          },
          child: Text('save'.tr()),
        ),
      ),
    );
  }
}

class ContainerAmount extends StatelessWidget {
  const ContainerAmount({
    Key? key,
    required this.stateTheme,
    required this.amountController,
    required this.transaction,
  }) : super(key: key);

  final Brightness stateTheme;
  final TextEditingController amountController;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(8),
      decoration: customCircularBox(
          color: (stateTheme == Brightness.light) ? lightWhite : blackN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('amount'.tr()),
          SB_Height10,
          TextFormField(
            keyboardType: TextInputType.number,
            controller: amountController,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              hintText: "0",
            ),
            onSaved: (newValue) {
              if (newValue!.isNotEmpty || newValue != "") {
                transaction.amount = double.parse(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}

class ContainerDescription extends StatelessWidget {
  const ContainerDescription({
    Key? key,
    required this.stateTheme,
    required this.deskriptionController,
    required this.transaction,
  }) : super(key: key);

  final Brightness stateTheme;
  final TextEditingController deskriptionController;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(8),
      decoration: customCircularBox(
          color: (stateTheme == Brightness.light) ? lightWhite : blackN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('description'.tr()),
          SB_Height10,
          TextFormField(
            keyboardType: TextInputType.text,
            controller: deskriptionController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'type-description'.tr(),
              contentPadding: const EdgeInsets.only(left: 10),
            ),
            onSaved: (newValue) {
              transaction.description = newValue ?? "";
            },
          ),
        ],
      ),
    );
  }
}

class ContainerName extends StatelessWidget {
  const ContainerName({
    Key? key,
    required this.stateTheme,
    required this.nameController,
    required this.transaction,
  }) : super(key: key);

  final Brightness stateTheme;
  final TextEditingController nameController;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(8),
      decoration: customCircularBox(
          color: (stateTheme == Brightness.light) ? lightWhite : blackN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('name'.tr()),
          SB_Height10,
          TextFormField(
            controller: nameController,
            onSaved: (newValue) {
              if (newValue!.isNotEmpty || newValue != "") {
                transaction.title = newValue;
              }
            },
            validator: (value) {
              if (value!.isEmpty || value == "") {
                return 'name-not-null'.tr();
              }
              return null;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'type-name'.tr(),
                contentPadding: const EdgeInsets.only(left: 10)),
          ),
        ],
      ),
    );
  }
}

class ContainerCategory extends StatelessWidget {
  const ContainerCategory({
    Key? key,
    required this.stateTheme,
    required this.transaction,
    required this.category,
  }) : super(key: key);

  final Brightness stateTheme;
  final Transaction transaction;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(8),
      decoration: customCircularBox(
          color: (stateTheme == Brightness.light) ? lightWhite : blackN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(fit: BoxFit.fitWidth, child: Text('category'.tr())),
          SB_Height10,
          InkWell(
            onTap: () {
              if (transaction.idCategory > 0) {
                context
                    .read<CategoryBloc>()
                    .add(ChangeIconCategory(categoryValue: category));
              }

              Navigator.of(context, rootNavigator: true)
                  .pushNamed(AppRoutes.transactionCategory);
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                foregroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    "assets/icons/${category.iconName}.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text(category.name),
              trailing: const Icon(Icons.arrow_drop_down_sharp),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerDate extends StatelessWidget {
  const ContainerDate({
    Key? key,
    required this.stateTheme,
    required this.transaction,
  }) : super(key: key);

  final Brightness stateTheme;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(8),
      decoration: customCircularBox(
          color: (stateTheme == Brightness.light) ? lightWhite : blackN),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(fit: BoxFit.fitWidth, child: Text('date'.tr())),
          InkWell(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(transaction.createdTime),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(9999))
                  .then((value) {
                (value == null)
                    ? context
                        .read<TransactionBloc>()
                        .add(SelectedDateEvent(value: transaction.createdTime))
                    : context
                        .read<TransactionBloc>()
                        .add(SelectedDateEvent(value: value.toString()));
              });
            },
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(DateFormat('dd / MM / yyyy')
                  .format(DateTime.parse(transaction.createdTime))),
              trailing: const Icon(Icons.arrow_drop_down_sharp),
            ),
          ),
        ],
      ),
    );
  }
}

class SegmentControlWidget extends StatelessWidget {
  const SegmentControlWidget({
    Key? key,
    required this.stateTheme,
    required this.transaction,
  }) : super(key: key);

  final Brightness stateTheme;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: (stateTheme == Brightness.light) ? lightWhite : blackN,
        thumbColor:
            (transaction.isOutcome == 0) ? greenCalculation : redCalculation,
        padding: const EdgeInsets.all(8),
        groupValue: transaction.isOutcome,
        children: {
          0: buildSegment('income'.tr()),
          1: buildSegment('expense'.tr()),
        },
        onValueChanged: (value) {
          context
              .read<TransactionBloc>()
              .add(SelectedIsOutcomeEvent(value: value ?? 0));
          transaction.isOutcome = value!;
        },
      ),
    );
  }
}

Widget buildSegment(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 22),
  );
}
