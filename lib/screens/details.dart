import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tempo_task/models/employee_model.dart';
import 'package:tempo_task/widgets/details_tile.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({Key? key, required this.employee}) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 35,
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  height: size.height * 0.55,
                  width: size.width,
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.35,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: 0.15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: Image.asset(
                                  "dots.jpg",
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: size.height * 0.1,
                                      backgroundImage:
                                          NetworkImage(employee.imageUrl),
                                    ),
                                    Positioned(
                                      bottom: size.height * 0.015,
                                      right: 0,
                                      child: Container(
                                        height: size.height * 0.04,
                                        width: size.height * 0.04,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.yellow,
                                            border: Border.all(
                                                color: Colors.white, width: 4)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                Text(
                                  "${employee.firstName} ${employee.lastName}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Designer at Facebook Head Office",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            Container(
                              height: size.height * 0.09,
                              width: size.height * 0.09,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.shade100,
                                      Colors.red.shade50
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.centerLeft),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Icon(Icons.phone, size: 30),
                            ),
                            const Spacer(),
                            const VerticalDivider(
                              thickness: 1,
                            ),
                            Spacer(),
                            Container(
                            height: size.height * 0.09,
                              width: size.height * 0.09,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.shade200,
                                      Colors.blue.shade50
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Icon(Icons.phone_android, size: 30),
                            ),
                            Spacer(),
                            const VerticalDivider(
                              thickness: 1,
                              width: 10,
                            ),
                            Spacer(),
                            Container(
                              height: size.height * 0.09,
                              width: size.height * 0.09,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.orange.shade50,
                                      Colors.blue.shade50
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Icon(Icons.mail, size: 30),
                            ),
                            Spacer(
                              flex: 2,
                            )
                          ],
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                const Text(
                  "Basic Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                DetailTile(
                    title: "Age",
                    data: DateFormat.MMMMEEEEd().format(employee.dob)),
                DetailTile(title: "Contact", data: employee.contactNumber),
                DetailTile(title: "Salary", data: "${employee.salary}"),
                DetailTile(title: "Email", data: employee.email),
                DetailTile(title: "Address", data: employee.address)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
