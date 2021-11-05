import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempo_task/models/employee_model.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({Key? key, required this.employee}) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 35,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: size.height * 0.50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
