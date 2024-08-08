import 'package:equatable/equatable.dart';

class AccountDataEntity extends Equatable {
  final String name;
  final String phoneNumber;
  final String email;
  final int id;

  const AccountDataEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email, phoneNumber];
}
