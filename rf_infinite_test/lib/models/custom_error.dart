import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomError extends Equatable {
  final String errMsg;

  const CustomError({
    this.errMsg = '',
  });

  @override
  List<Object> get props => [errMsg];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'errMsg': errMsg,
    };
  }

  factory CustomError.fromJson(Map<String, dynamic> json) {
    return CustomError(
      errMsg: json['errMsg'],
    );
  }
}
