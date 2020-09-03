import 'package:etiqa_assessment/page-main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'include/colour.dart';
import 'include/database.dart';
import 'include/deco.dart';
import 'include/dateconverter.dart';

class PageAdd extends StatefulWidget {
  @override
  StatePageAdd createState() {
    return StatePageAdd();
  }

  final int type; // [0: Add todo, 1: Edit todo]
  final int id; // [0-infinity: id json]

  PageAdd(this.type, this.id);
}

class StatePageAdd extends State<PageAdd> {
  // Initialize key and controller
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  // Initailize the start date and end date
  DateTime _sDate = DateTime.now();
  DateTime _eDate = DateTime.now();

  // Initialize global type and id
  int _type;
  int _id;

  // Initialize the list todo
  List<dynamic> _todoList = List<dynamic>();

  // INIT STATE
  @override
  void initState() {
    super.initState();
    // Initialize data variable
    _id = widget.id;
    _type = widget.type;
    if (_type == 1) {
      // Get the latest data from database
      _todoList = Database.getData();
      // Initialize local value
      String title = _todoList[_id]["title"];
      String sDate = _todoList[_id]["start_date"];
      String eDate = _todoList[_id]["end_date"];

      // Store datetime data
      _sDate = DateTime.parse(sDate);
      _eDate = DateTime.parse(eDate);
      // Pass to display
      _titleController.text = title;
      _startDateController.text = DateConverter().dateToStrDate(_sDate);
      _endDateController.text = DateConverter().dateToStrDate(_eDate);
    }
  }

  // SUBMIT REQUEST FUNCTION
  void submitRequest() {
    // Validate the form if valid or not
    if (_formKey.currentState.validate()) {
      String title = _titleController.text;
      DateTime startDate = _sDate;
      DateTime endDate = _eDate;
      bool status = false;

      // Save the data to database
      if (_type == 0) {
        Database.setData(title, startDate, endDate, status);
      } else {
        Database.updateData(_id, title, startDate, endDate);
      }

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: PageMain(),
          duration: Duration(milliseconds: 250),
        ),
      );
    }
  }

  // BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------- //
      // -- APP BAR -- //
      // ------------- //
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: false,
          bottomOpacity: 0,
          title: RichText(
            text: TextSpan(
              text: "Add new To-Do List",
              style: TextStyle(
                color: Colour().textPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          backgroundColor: Colour().primary,
        ),
      ),
      // ---------- //
      // -- BODY -- //
      // ---------- //
      body: Stack(
        children: [
          // ---------------- //
          // -- Input area -- //
          // ---------------- //
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ---------------------------------- //
                    // -- Input area for "Title To-Do" -- //
                    // ---------------------------------- //
                    // Title To-Do
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 25,
                        bottom: 10,
                      ),
                      child: Text("To-Do Title"),
                    ),
                    // Input text box decoration
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 12),
                        maxLines: 8,
                        decoration: Deco().textInput(
                          'Please key in your To-Do title here',
                          TextStyle(color: Colour().textSecondary),
                          Colour().bgSecondary,
                          0,
                        ),
                        // Validate input text is empty or filled
                        validator: (input) {
                          if (input.isEmpty)
                            return 'Please key in your To-Do title!';
                          else
                            return null;
                        },
                      ),
                    ),
                    // ---------------------------------- //
                    // -- Input date for "Start To-Do" -- //
                    // ---------------------------------- //
                    // Title start date
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 25,
                        bottom: 10,
                      ),
                      child: Text("Start Date"),
                    ),
                    // Input date box decoration
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _startDateController,
                        keyboardType: TextInputType.datetime,
                        style: new TextStyle(fontSize: 12),
                        decoration: Deco().dateInput(
                          'Select a date',
                          TextStyle(color: Colour().textSecondary),
                          Colour().bgSecondary,
                          0,
                        ),
                        // Function to called date picker
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: _sDate,
                            firstDate: DateTime(2020, 1),
                            lastDate: DateTime(2101),
                            builder: (BuildContext context, Widget child) {
                              return Deco().calendarPrimary(child);
                            },
                          );
                          if (picked != null && picked != _sDate) {
                            setState(() {
                              _sDate = picked;
                              String d = DateConverter().dateToStrDate(_sDate);
                              _startDateController.text = d;
                            });
                          }
                        },
                        // Validate input date is empty or filled
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please select a date!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    // -------------------------------- //
                    // -- Input date for "End To-Do" -- //
                    // -------------------------------- //
                    // Title end date
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 25,
                        bottom: 10,
                      ),
                      child: Text("Estimate End Date"),
                    ),
                    // Input date box decoration
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _endDateController,
                        keyboardType: TextInputType.datetime,
                        style: TextStyle(fontSize: 12),
                        decoration: Deco().dateInput(
                          'Select a date',
                          TextStyle(color: Colour().textSecondary),
                          Colour().bgSecondary,
                          0,
                        ),
                        // Function to called date picker
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: _eDate,
                            firstDate: DateTime(2020, 1),
                            lastDate: DateTime(2101),
                            builder: (BuildContext context, Widget child) {
                              return Deco().calendarPrimary(child);
                            },
                          );
                          if (picked != null && picked != _eDate) {
                            setState(() {
                              _eDate = picked;
                              String d = DateConverter().dateToStrDate(_eDate);
                              _endDateController.text = d;
                            });
                          }
                        },
                        // Validate input date is empty or filled
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Please select a date!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
          // ------------------- //
          // -- Bottom button -- //
          // ------------------- //
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 60,
                width: double.infinity,
                color: Colour().bgTertiary,
                child: FlatButton(
                  onPressed: () => submitRequest(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _type == 0 ? "Create Now" : "Update Now",
                        style: TextStyle(
                          color: Colour().white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
