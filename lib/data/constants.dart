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
const List<Color> bloomColor = [lightMildWaters, seagull];

const Color lightMildWaters = Color(0xFFE0EAFD);
const Color lightBlue = Color(0xFF50A7D9);
const Color lightPurple = Color(0xFF8383BE);
// const Color greenCalculation = Color(0xFF29C7AC);
// const Color greenCalculation = Color(0xFF4E9F3D);
const Color greenCalculation = Color(0xFF03DAC5);
const Color greenDeepCalculation = Color(0xFF018786);
// const Color redCalculation = Color(0xFF84142D);
// const Color redCalculation = Color(0xFFE94560);
const Color redCalculation = Color(0xFFFF7597);
const Color redDeepCalculation = Color(0xFFB42B51);
const Color blackDefault = Color(0xFF141010);
const Color orangeSaweria = Color(0xFFfaae2b);
const Color bluePaypal = Color(0xFF3b7bbf);
const Color lightWhite = Color(0xFFEFF5F5);
const Color charcoal = Color(0xFF404258);
const Color meteorite = Color(0xFF474E68);

// dark
const Color blueDeep = Color(0xFF3F3B6C);
const Color zimidar = Color(0xFF624F82);
const Color seagull = Color(0xFFA3C7D6);
const Color blackN = Color(0xFF474E68);

// image name
const noDataImage = 'assets/images/nodata.png';
const locAssetLanguage = 'assets/languages';
const successImage = 'assets/images/success.png';
const failedImage = 'assets/images/failed.png';
const warningImage = 'assets/images/warning.png';

// url
const urlSaweria = 'https://saweria.co/indratdev';

// --------------------------------- decoration ----------------------------------
Decoration arrowDecor = const BoxDecoration(
  // color: Colors.white.withOpacity(0.9),
  color: lightWhite,
  borderRadius: BorderRadius.all(Radius.circular(13)),
  boxShadow: [
    BoxShadow(
      color: lightPurple,
      blurRadius: 0.8,
      spreadRadius: 1,
      offset: Offset(1, 3), // changes position of shadow
    ),
  ],
);

Decoration arrowDecorDark = const BoxDecoration(
  // color: lightPurple,
  color: blackN,
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

Decoration calculationDecor = const BoxDecoration(
  // color: Colors.white.withOpacity(0.9),
  color: lightWhite,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(27),
    bottomLeft: Radius.circular(27),
    bottomRight: Radius.circular(10),
  ),
  boxShadow: [
    // BoxShadow(
    //   color: Colors.black12,
    //   offset: Offset(0, -5),
    //   blurRadius: 8.0,
    // )
    BoxShadow(
      color: lightPurple,
      blurRadius: 0.8,
      spreadRadius: 1,
      offset: Offset(1, 4), // changes position of shadow
    ),
  ],
);

Decoration calculationDecorDark = const BoxDecoration(
  // color: lightPurple,
  color: blackN,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(27),
    bottomLeft: Radius.circular(27),
    bottomRight: Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0, -5),
      blurRadius: 8.0,
    )
  ],
);

Decoration listDataDecor = const BoxDecoration(
  borderRadius: BorderRadius.only(
      topRight: Radius.circular(48),
      bottomRight: Radius.circular(5.0),
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0)),
  color: lightWhite,
  boxShadow: [
    BoxShadow(
      color: lightPurple,
      spreadRadius: 0.8,
      blurRadius: 0.8,
      offset: Offset(5, 0),
    ),
  ],
);

Decoration listDataDecorDark = BoxDecoration(
  borderRadius: const BorderRadius.only(
      topRight: Radius.circular(35),
      bottomRight: Radius.circular(5.0),
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0)),
  // color: lightPurple,
  color: blackN,
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
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.5),
      //     spreadRadius: 5,
      //     blurRadius: 7,
      //     offset: const Offset(0, 3), // changes position of shadow
      //   ),
      // ],
    );

// Decoration customCircularBoxDark({Color? color}) => BoxDecoration(
//       color: color ?? Colors.white60,
//       borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//           bottomLeft: Radius.circular(10),
//           bottomRight: Radius.circular(10)),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 5,
//           blurRadius: 7,
//           offset: const Offset(0, 3), // changes position of shadow
//         ),
//       ],
//     );

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
Divider defaultDivider(BuildContext context) =>
    Divider(color: Theme.of(context).dividerColor, height: 0.5);



// <a href="https://www.flaticon.com/free-icons/donation" title="donation icons">Donation icons created by DinosoftLabs - Flaticon</a>