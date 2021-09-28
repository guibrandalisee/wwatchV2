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
  String toString() {
    return '''
primaryColor: ${primaryColor},
colorIndex: ${colorIndex},
fabPosition: ${fabPosition}
    ''';
  }
}
