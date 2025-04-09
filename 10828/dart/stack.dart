class Stack<T> {
  List<T> _elements = [];

  void push(T element) {
    _elements.add(element);
  }

  T pop() {
    if (_elements.isEmpty) {
      throw Exception('Stack is empty');
    }
    return _elements.removeLast();
  }

  T peek() {
    if (_elements.isEmpty) {
      throw Exception('Stack is empty');
    }
    return _elements.last;
  }

  bool get isEmpty => _elements.isEmpty;

  int get size => _elements.length;

  @override
  String toString() {
    return _elements.toString();
  }
}
