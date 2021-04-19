import 'package:lottery_app/domain/entities/ticket.dart';

class UserEntity{

   String id;
   String name;
   String phone;
   String email;
   //List<Ticket> userTickets;

  //UserEntity({this.id,this.name,this.phone,this.email,this.userTickets});
  UserEntity({this.id,this.name,this.phone,this.email});

  String get getName =>name;
  String get getEmail =>email;
  String get getPhone =>phone;
  String get getId =>id;

  //List<Ticket> get getUserTickets =>userTickets;

}