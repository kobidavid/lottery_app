import 'package:lottery_app/domain/entities/ticket.dart';

class UserEntity{

  final String id;
  final String name;
  final String phone;
  final String email;
  final List<Ticket> userTickets;

  UserEntity({this.id,this.name,this.phone,this.email,this.userTickets});

  String get getName =>name;
  String get getEmail =>email;
  String get getPhone =>phone;
  String get getId =>id;
  List<Ticket> get getUserTickets =>userTickets;

}