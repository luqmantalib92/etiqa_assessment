import 'dart:convert';

import 'storage.dart';

class Database {
  static List<dynamic> todoList = List<dynamic>();

  // Initialize data if data already exist before
  static void initData(String jsonData) {
    // Map the json data to object
    todoList = json.decode(jsonData);
  }

  // Set the new data to the json object
  static void setData(
      String title, DateTime startDate, DateTime endDate, bool status) {
    // Initialize temp data for maping
    Map<dynamic, dynamic> tempData = Map<dynamic, dynamic>();
    // Map data to individual key value pair
    tempData["title"] = title;
    tempData["start_date"] = startDate.toIso8601String();
    tempData["end_date"] = endDate.toIso8601String();
    tempData["status"] = status.toString();
    // Map data to list array
    todoList.add(tempData);

    // Initialize the json file and store
    String fileName = "database.json";
    Storage storage = Storage(fileName: fileName);

    // Save the latest data
    storage.writeFile(json.encode(todoList));
  }

  // Get the json object
  static List getData() {
    return todoList;
  }

  // Update the status
  static void updateStatus(int id, bool status)
  {
    todoList[id]["status"] = status.toString();
    // Initialize the json file and store
    String fileName = "database.json";
    Storage storage = Storage(fileName: fileName);
    // Save the latest data
    storage.writeFile(json.encode(todoList));
  }

  // Update the status
  static void updateData(int id, String title, DateTime startDate, DateTime endDate)
  {
    todoList[id]["title"] = title;
    todoList[id]["start_date"] = startDate.toIso8601String();
    todoList[id]["end_date"] = endDate.toIso8601String();
    // Initialize the json file and store
    String fileName = "database.json";
    Storage storage = Storage(fileName: fileName);
    // Save the latest data
    storage.writeFile(json.encode(todoList));
  }

  // Update the status
  static void deleteData(int id)
  {
    todoList.removeAt(id);
    // Initialize the json file and store
    String fileName = "database.json";
    Storage storage = Storage(fileName: fileName);
    // Save the latest data
    storage.writeFile(json.encode(todoList));
  }
}
