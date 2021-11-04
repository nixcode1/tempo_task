import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempo_task/models/employee_model.dart';
import 'package:tempo_task/widgets/employee_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Employee> listOfEmployees = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readAndParseJson();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xffffffff),
            statusBarIconBrightness: Brightness.dark),
        title: const Text(
          "Employee Directory",
        ),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.black, size: 35),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            children: [
              // Container(
              //   height: size.height * 0.05,
              //   width: size.width,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       border: Border.all(width: 0.2),
              //       borderRadius: BorderRadius.circular(30)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text("Search Employee"),
              //       const Icon(Icons.search)
              //     ],
              //   ),
              // )
              SizedBox(
                height: size.height * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.04, color: Colors.black54),
                          borderRadius: BorderRadius.circular(30)),
                      hintText: "Search Employee",
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: listOfEmployees.length,
                          itemBuilder: (context, index) => EmployeeTile(
                            employee: listOfEmployees[index],
                          ),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  void readAndParseJson() async {
    String data = await getJsonData();
    List<dynamic> decodedData = jsonDecode(data);
    listOfEmployees = decodedData.map((e) => Employee.fromMap(e)).toList();
    setState(() {
      isLoading = false;
    });
    // debugPrint("$listOfEmployees");
  }

  Future<String> getJsonData() async {
    return await rootBundle.loadString('assets/employees.json');
  }
}
