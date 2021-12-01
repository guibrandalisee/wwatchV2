// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StyleStore on _StyleStoreBase, Store {
  final _$primaryColorAtom = Atom(name: '_StyleStoreBase.primaryColor');

  @override
  Color? get primaryColor {
    _$primaryColorAtom.reportRead();
    return super.primaryColor;
  }

  @override
  set primaryColor(Color? value) {
    _$primaryColorAtom.reportWrite(value, super.primaryColor, () {
      super.primaryColor = value;
    });
  }

  final _$dropdownColorAtom = Atom(name: '_StyleStoreBase.dropdownColor');

  @override
  Color? get dropdownColor {
    _$dropdownColorAtom.reportRead();
    return super.dropdownColor;
  }

  @override
  set dropdownColor(Color? value) {
    _$dropdownColorAtom.reportWrite(value, super.dropdownColor, () {
      super.dropdownColor = value;
    });
  }

  final _$backgroundColorAtom = Atom(name: '_StyleStoreBase.backgroundColor');

  @override
  Color? get backgroundColor {
    _$backgroundColorAtom.reportRead();
    return super.backgroundColor;
  }

  @override
  set backgroundColor(Color? value) {
    _$backgroundColorAtom.reportWrite(value, super.backgroundColor, () {
      super.backgroundColor = value;
    });
  }

  final _$textColorAtom = Atom(name: '_StyleStoreBase.textColor');

  @override
  Color? get textColor {
    _$textColorAtom.reportRead();
    return super.textColor;
  }

  @override
  set textColor(Color? value) {
    _$textColorAtom.reportWrite(value, super.textColor, () {
      super.textColor = value;
    });
  }

  final _$textOnPrimaryColorAtom =
      Atom(name: '_StyleStoreBase.textOnPrimaryColor');

  @override
  Color? get textOnPrimaryColor {
    _$textOnPrimaryColorAtom.reportRead();
    return super.textOnPrimaryColor;
  }

  @override
  set textOnPrimaryColor(Color? value) {
    _$textOnPrimaryColorAtom.reportWrite(value, super.textOnPrimaryColor, () {
      super.textOnPrimaryColor = value;
    });
  }

  final _$shapeColorAtom = Atom(name: '_StyleStoreBase.shapeColor');

  @override
  Color? get shapeColor {
    _$shapeColorAtom.reportRead();
    return super.shapeColor;
  }

  @override
  set shapeColor(Color? value) {
    _$shapeColorAtom.reportWrite(value, super.shapeColor, () {
      super.shapeColor = value;
    });
  }

  final _$colorIndexAtom = Atom(name: '_StyleStoreBase.colorIndex');

  @override
  int? get colorIndex {
    _$colorIndexAtom.reportRead();
    return super.colorIndex;
  }

  @override
  set colorIndex(int? value) {
    _$colorIndexAtom.reportWrite(value, super.colorIndex, () {
      super.colorIndex = value;
    });
  }

  final _$fabPositionAtom = Atom(name: '_StyleStoreBase.fabPosition');

  @override
  int? get fabPosition {
    _$fabPositionAtom.reportRead();
    return super.fabPosition;
  }

  @override
  set fabPosition(int? value) {
    _$fabPositionAtom.reportWrite(value, super.fabPosition, () {
      super.fabPosition = value;
    });
  }

  final _$errorImageAtom = Atom(name: '_StyleStoreBase.errorImage');

  @override
  String? get errorImage {
    _$errorImageAtom.reportRead();
    return super.errorImage;
  }

  @override
  set errorImage(String? value) {
    _$errorImageAtom.reportWrite(value, super.errorImage, () {
      super.errorImage = value;
    });
  }

  final _$nothingFoundImageAtom =
      Atom(name: '_StyleStoreBase.nothingFoundImage');

  @override
  String? get nothingFoundImage {
    _$nothingFoundImageAtom.reportRead();
    return super.nothingFoundImage;
  }

  @override
  set nothingFoundImage(String? value) {
    _$nothingFoundImageAtom.reportWrite(value, super.nothingFoundImage, () {
      super.nothingFoundImage = value;
    });
  }

  final _$_StyleStoreBaseActionController =
      ActionController(name: '_StyleStoreBase');

  @override
  void setPrimaryColor(Color value, int index) {
    final _$actionInfo = _$_StyleStoreBaseActionController.startAction(
        name: '_StyleStoreBase.setPrimaryColor');
    try {
      return super.setPrimaryColor(value, index);
    } finally {
      _$_StyleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFabPosition(int value) {
    final _$actionInfo = _$_StyleStoreBaseActionController.startAction(
        name: '_StyleStoreBase.setFabPosition');
    try {
      return super.setFabPosition(value);
    } finally {
      _$_StyleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeBrihtness() {
    final _$actionInfo = _$_StyleStoreBaseActionController.startAction(
        name: '_StyleStoreBase.changeBrihtness');
    try {
      return super.changeBrihtness();
    } finally {
      _$_StyleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
primaryColor: ${primaryColor},
dropdownColor: ${dropdownColor},
backgroundColor: ${backgroundColor},
textColor: ${textColor},
textOnPrimaryColor: ${textOnPrimaryColor},
shapeColor: ${shapeColor},
colorIndex: ${colorIndex},
fabPosition: ${fabPosition},
errorImage: ${errorImage},
nothingFoundImage: ${nothingFoundImage}
    ''';
  }
}
