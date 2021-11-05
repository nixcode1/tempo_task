import 'package:flutter/material.dart';
import 'package:tempo_task/models/employee_model.dart';
import 'package:tempo_task/screens/details.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({Key? key, required this.employee}) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    String susTag = employee.getSuspensionTag();
    return Column(
      children: [
        Offstage(
          offstage: employee.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        ListTile(
            onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EmployeeDetails(employee: employee,)),
                ),
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            leading: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(employee.imageUrl),
              backgroundColor: Colors.white24,
            ),
            title: Text("${employee.firstName} ${employee.lastName}"),
            subtitle: Text(employee.address)),
        const Divider()
      ],
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 40,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        textScaleFactor: 1.2,
      ),
    );
  }
}
