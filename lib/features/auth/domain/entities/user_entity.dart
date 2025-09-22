import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;

  const UserEntity({required this.uid, required this.email});

  static const empty = UserEntity(uid: '', email: '');

  bool get isEmpty => this == UserEntity.empty;

  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [uid, email];
}
