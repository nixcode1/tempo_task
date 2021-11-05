import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  List<Employee> searchList = [];
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
    bool isKeyboardVisible =
        MediaQuery.of(context).viewInsets.bottom > size.height * 0.3;
    debugPrint("$isKeyboardVisible");
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
                  onChanged: _search,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.04, color: Colors.black54),
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
                    : isKeyboardVisible
                        ? ListView.builder(
                            itemCount: searchList.length,
                            itemBuilder: (context, index) =>
                                EmployeeTile(employee: searchList[index]),
                          )
                        : AzListView(
                            data: listOfEmployees,
                            indexBarHeight: size.height,
                            indexBarItemHeight: 23,
                            indexBarAlignment: Alignment.topRight,
                            indexBarOptions: const IndexBarOptions(
                                needRebuild: true,
                                selectTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                downTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold)),
                            indexBarData:
                                SuspensionUtil.getTagIndexList(listOfEmployees),
                            itemCount: listOfEmployees.length,
                            itemBuilder: (context, index) =>
                                EmployeeTile(employee: listOfEmployees[index]),
                          ),
              )
              //  ListView.builder(
              //     itemCount: listOfEmployees.length,
              //     itemBuilder: (context, index) => EmployeeTile(
              //       employee: listOfEmployees[index],
              //     ),
              //   ))
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
    _handleList(listOfEmployees);
    // debugPrint("$listOfEmployees");
  }

  Future<String> getJsonData() async {
    return await rootBundle.loadString('assets/employees.json');
  }

  void _handleList(List<Employee> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = list[i].firstName.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(list);

    setState(() {
      isLoading = false;
    });
  }

  void _search(String searchValue) {
    searchList = listOfEmployees
        .where((element) =>
            element.firstName.toLowerCase().contains(searchValue) ||
            element.lastName.toLowerCase().contains(searchValue))
        .toList();
    setState(() {});
  }
}
