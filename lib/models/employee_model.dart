import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

class Employee {
  final int id;
  final String imageUrl;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final int age;
  final DateTime dob;
  final double salary;
  final String address;
  
  Employee({
    required this.id,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.age,
    required this.dob,
    required this.salary,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'age': age,
      'dob': dob.millisecondsSinceEpoch,
      'salary': salary,
      'address': address,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      imageUrl: map['imageUrl'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      contactNumber: map['contactNumber'],
      age: map['age'],
      dob: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(map['dob']))),
      salary: map['salary'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(id: $id, imageUrl: $imageUrl, firstName: $firstName, lastName: $lastName, email: $email, contactNumber: $contactNumber, age: $age, dob: $dob, salary: $salary, address: $address)';
  }
}
