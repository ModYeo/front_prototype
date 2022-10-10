import 'package:flutter/material.dart';
class StackData<T>{
  final List<T> _stack;
  StackData() : _stack = <T>[];

  void push(T element){_stack.add(element);}
  T pop() => _stack.removeLast();
  T peek() => _stack.last;

  bool get isEmpty => _stack.isEmpty;
}