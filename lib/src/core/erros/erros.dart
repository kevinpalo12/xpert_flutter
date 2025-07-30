import 'package:flutter/material.dart' show BuildContext;

class ErrorEntity {
  final String code;
  final String message;
  ErrorEntity({
    required this.code,
    this.message = 'Ha ocurrido un error inesperado',
  });
}

class ErrorModel extends ErrorEntity {
  ErrorModel({
    required super.code,
    super.message,
  });

  factory ErrorModel.fromJson(
    BuildContext context,
    Map<String, dynamic> json,
  ) {
    return ErrorModel(
      code: json['code'],
      message: json['message'],
    );
  }
}
