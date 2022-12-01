enum PinString {
  tempPasscodeValue,
  valuePasscodeValue,
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
    if (_valuePasscode.isNotEmpty) {
      _valuePasscode.removeLast();
      _tempPasscode[_valuePasscode.length] = '';
    }

    return {
      PinString.valuePasscodeValue.toString(): _valuePasscode,
      PinString.tempPasscodeValue.toString(): _tempPasscode,
    };
  }

  changePasscode(int value) {
    if (_valuePasscode.length < _maxLengthPasscode) {
      _valuePasscode.add(value);
      _tempPasscode[_valuePasscode.length - 1] =
          value.toString(); //update tempp

    }

    if (_valuePasscode.length == _maxLengthPasscode) {
      _passcodeAlreadyFulfilled = true;
    }

    return {
      PinString.valuePasscodeValue.toString(): _valuePasscode,
      PinString.tempPasscodeValue.toString(): _tempPasscode,
    };
  }
}
