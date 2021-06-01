class TodoItemDTO {
  String value;
  bool isChecked;
  bool requestFocus;

  TodoItemDTO({
    this.value = '',
    this.isChecked = false,
    this.requestFocus = false,
  });

  String toString() {
    return '''{
      value: \'$value\',
      isChecked: $isChecked,
      requestFocus: $requestFocus,
    }''';
  }
}
