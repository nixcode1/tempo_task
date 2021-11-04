import 'package:flutter/material.dart';
import 'package:tempo_task/models/employee_model.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({ Key? key, required this.employee }) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          leading: CircleAvatar(radius: 35, backgroundImage: NetworkImage(employee.imageUrl),),
          title: Text("${employee.firstName} ${employee.lastName}"),
          subtitle: Text("${employee.firstName}")
        ),
        Divider()
      ],
    );
  }
}