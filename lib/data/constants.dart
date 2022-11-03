import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String appName = 'money app';

const SizedBox SB_Width10 = SizedBox(width: 10);
const SizedBox SB_Height10 = SizedBox(height: 10);
const SizedBox SB_Height20 = SizedBox(height: 20);
const SizedBox SB_Height30 = SizedBox(height: 30);

String todayTime = DateTime.now().toString();
DateFormat defaultDateTimeF =
    DateFormat('dd-MM-yyyy'); // DateFormat('yyyy-MM-dd hh:mm');

const String failureInitCategoryMessage = "Gagal Inisialisasi";
const String failureReadCategoryMessage = "Gagal Membaca Kategory";

NumberFormat formatterThousand =
    NumberFormat("#,##0.00", "en_US"); //NumberFormat('#,##,000');

// color
const List<Color> bloomColor = [
  Color(0xFF8383BE),
  Color(0xFF50A7D9),
];

const Color lightMildWaters = Color(0xFFE0EAFD);
const Color lightBlue = Color(0xFF50A7D9);
const Color lightPurple = Color(0xFF8383BE);

// decoration
const Decoration arrowDecor = BoxDecoration(
  color: Colors.white54,
  borderRadius: BorderRadius.all(
    Radius.circular(13),
  ),
);

Decoration customCircularBox({Color? color}) => BoxDecoration(
      color: color ?? Colors.white60,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
