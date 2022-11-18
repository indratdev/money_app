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
const Color greenCalculation = Color(0xFF29C7AC);
const Color redCalculation = Color(0xFF84142D);
const Color blackDefault = Color(0xFF141010);
const Color orangeSaweria = Color(0xFFfaae2b);
const Color bluePaypal = Color(0xFF3b7bbf);

// image name
const noDataImage = 'assets/images/nodata.png';
const locAssetLanguage = 'assets/languages';

// url
const urlSaweria = 'https://saweria.co/indratdev';

// --------------------------------- decoration ----------------------------------
Decoration arrowDecor = BoxDecoration(
  color: Colors.white.withOpacity(0.9),
  borderRadius: const BorderRadius.all(Radius.circular(13)),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      blurRadius: 1.0,
      spreadRadius: 1,
      offset: Offset(0, 3), // changes position of shadow
    )
  ],
);

Decoration arrowDecorDark = const BoxDecoration(
  color: lightPurple,
  borderRadius: BorderRadius.all(Radius.circular(13)),
  boxShadow: [
    BoxShadow(
      color: Colors.white60,
      blurRadius: 0.5,
      spreadRadius: 0.2,
      offset: Offset(0, 1), // changes position of shadow
    )
  ],
);

Decoration calculationDecor = BoxDecoration(
  color: Colors.white.withOpacity(0.9),
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(27),
    bottomLeft: Radius.circular(27),
    bottomRight: Radius.circular(10),
  ),
  boxShadow: const [
    BoxShadow(color: Colors.black12, offset: Offset(0, -5), blurRadius: 8.0)
  ],
);

Decoration calculationDecorDark = const BoxDecoration(
  color: lightPurple,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(27),
    bottomLeft: Radius.circular(27),
    bottomRight: Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(color: Colors.black12, offset: Offset(0, -5), blurRadius: 8.0)
  ],
);

Decoration listDataDecor = BoxDecoration(
  borderRadius: const BorderRadius.only(
      topRight: Radius.circular(35),
      bottomRight: Radius.circular(5.0),
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0)),
  color: lightMildWaters,
  boxShadow: [
    BoxShadow(
      color: Colors.white.withOpacity(0.9),
      spreadRadius: 2,
      blurRadius: 1.0,
      offset: const Offset(0, 3), // changes position
    ),
  ],
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
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );

Decoration backgroundThemeLight = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
    colors: bloomColor,
  ),
);

Decoration backgroundThemeDark = const BoxDecoration(
  color: Color(
    0xFF0a0f0d,
  ),
);

// --------------------------------- off decoration ----------------------------------

// divider
Divider defaultDivider = const Divider(color: Colors.black54, height: 1);



// <a href="https://www.flaticon.com/free-icons/donation" title="donation icons">Donation icons created by DinosoftLabs - Flaticon</a>