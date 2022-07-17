import 'package:flutter/material.dart';

GestureDetector drawerDropDown({name, onCalled}) {
  return GestureDetector(
      child: ListTile(title: Text(name)), onTap: () => onCalled());
}
