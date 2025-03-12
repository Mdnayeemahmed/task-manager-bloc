import 'package:equatable/equatable.dart';

class Success extends Equatable {
  const Success(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}