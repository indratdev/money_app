import 'package:collection/collection.dart';
import 'package:encrypt/encrypt.dart';

enum PinString {
  tempPasscodeValue,
  valuePasscodeValue,
  passcodeAlreadyFulfilled,
}

class PinManager {
  List<String> _tempPasscode = ['', '', '', '', '', ''];
  List<int> _valuePasscode = [];
  final int _maxLengthPasscode = 6;
  bool _passcodeAlreadyFulfilled = false;

  int get getMaxLengthPasscode {
    return _maxLengthPasscode;
  }

  List<String> get getTempPasscode {
    return _tempPasscode;
  }

  bool get getPasscodeAlreadFulfilled {
    return _passcodeAlreadyFulfilled;
  }

  List<int> get getValuePasscode {
    return _valuePasscode;
  }

  Map<String, dynamic> removeDigitPasscode() {
    Map<String, dynamic> tempValue = {};
    if (_valuePasscode.isNotEmpty) {
      _valuePasscode.removeLast();
      _tempPasscode[_valuePasscode.length] = '';
    }

    tempValue[PinString.tempPasscodeValue.toString()] = _tempPasscode;
    tempValue[PinString.valuePasscodeValue.toString()] = _valuePasscode;
    tempValue[PinString.passcodeAlreadyFulfilled.toString()] =
        _passcodeAlreadyFulfilled;

    return tempValue;

    // return {
    //   PinString.valuePasscodeValue.toString(): _valuePasscode,
    //   PinString.tempPasscodeValue.toString(): _tempPasscode,
    // };
  }

  Map<String, dynamic> changePasscode(int value) {
    Map<String, dynamic> tempValue = {};
    if (_valuePasscode.length < _maxLengthPasscode) {
      _valuePasscode.add(value);
      _tempPasscode[_valuePasscode.length - 1] =
          value.toString(); //update tempp

    }

    if (_valuePasscode.length == _maxLengthPasscode) {
      _passcodeAlreadyFulfilled = true;
    }

    tempValue[PinString.tempPasscodeValue.toString()] = _tempPasscode;
    tempValue[PinString.valuePasscodeValue.toString()] = _valuePasscode;
    tempValue[PinString.passcodeAlreadyFulfilled.toString()] =
        _passcodeAlreadyFulfilled;
    return tempValue;

    // return {
    //   PinString.valuePasscodeValue.toString(): _valuePasscode,
    //   PinString.tempPasscodeValue.toString(): _tempPasscode,
    // };
  }

  bool isValidPasscode(List<int> before, List<int> now) {
    Function eq = const ListEquality().equals;
    bool result = false;
    // print(eq([1, 'two', 3], [1, 'two', 3])); // => true
    // print(eq(before, now)); // => true
    var values = eq(before, now);
    if (values) {
      encryptDecryptPasscode(true, now.toString());
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  // encrypt
  encryptDecryptPasscode(bool isEncryt, String value) {
    final plainText = value;
    final key = Key.fromUtf8('keyformyapp123moneyappfromisdev9');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted
        .base64); // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
    // decrypt

    return (isEncryt) ? encrypted : decrypted;
  }
}
