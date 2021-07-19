import 'dart:convert';

class TodoItemDTO {
  String value;
  bool isChecked;
  bool requestFocus;

  TodoItemDTO({
    this.value = '',
    this.isChecked = false,
    this.requestFocus = false,
  });

  factory TodoItemDTO.fromJson(Map<String, dynamic> json) {
    return TodoItemDTO(
      value: json["value"],
      isChecked: json["isChecked"],
      requestFocus: json["requestFocus"],
    );
  }

  String toString() {
    return '''{
      value: \'$value\',
      isChecked: $isChecked,
      requestFocus: $requestFocus,
    }''';
  }

  Map<String, dynamic> toJson() {
    return {
      'value': this.value,
      'isChecked': this.isChecked,
      'requestFocus': this.requestFocus,
    };
  }
}
