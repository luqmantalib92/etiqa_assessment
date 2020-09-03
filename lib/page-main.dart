import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'include/colour.dart';
import 'include/database.dart';
import 'include/storage.dart';
import 'include/widgetcard.dart';

import 'page-add.dart';

class PageMain extends StatefulWidget {
  @override
  StatePageMain createState() {
    return StatePageMain();
  }
}

class StatePageMain extends State<PageMain> {
  // Initialize the list widget
  List<Widget> _listWidget = List<Widget>();

  // INITALIZE STATE
  @override
  void initState() {
    super.initState();
    setWidget();
  }

  // SET WIDGET CARD
  Future setWidget() async {
    // Initialize the list widget and list todo
    List<Widget> listWidget = List<Widget>();
    List<dynamic> todoList = List<dynamic>();
    // Initialize the json file and store
    String fileName = "database.json";
    Storage storage = Storage(fileName: fileName);

    // Read json data
    String jsonData = await storage.readFile();

    // If json file is not empty, set the json data to object
    if (jsonData.isNotEmpty) Database.initData(jsonData);

    // Get the latest data from database
    todoList = Database.getData();

    // Get length for looping
    int todoLength = todoList.length;

    // Get duration left
    DateTime now = DateTime.now();

    // Map data to card widget
    for (int filter = 0; filter < 3; filter++) {
      for (int i = 0; i < todoLength; i++) {
        String title = todoList[i]["title"];
        String sDate = todoList[i]["start_date"];
        String eDate = todoList[i]["end_date"];
        String status = todoList[i]["status"];

        // Convert date string to datetime
        DateTime edate = DateTime.parse(eDate);
        int minute = edate.difference(now).inMinutes;

        if (minute > 0 && filter == 0 && status == "false") {
          WidgetCard tempCard = WidgetCard(i, title, sDate, eDate, status);
          listWidget.add(tempCard);
          listWidget.add(SizedBox(height: 10));
        } else if (minute < 1 && filter == 1 && status == "false") {
          WidgetCard tempCard = WidgetCard(i, title, sDate, eDate, status);
          listWidget.add(tempCard);
          listWidget.add(SizedBox(height: 10));
        } else if (filter == 2 && status == "true") {
          WidgetCard tempCard = WidgetCard(i, title, sDate, eDate, status);
          listWidget.add(tempCard);
          listWidget.add(SizedBox(height: 10));
        }
      }
    }

    // Add extra spacing to avoid overlap floating button
    listWidget.add(SizedBox(height: 60));

    setState(() {
      _listWidget = listWidget;
    });
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
              text: "To-Do List",
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
      // --------------------- //
      // -- FLOATING BUTTON -- //
      // --------------------- //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: PageAdd(0, 0),
              duration: Duration(milliseconds: 250),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colour().tertiary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // ---------- //
      // -- BODY -- //
      // ---------- //
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: _listWidget,
            ),
          ),
        ),
      ),
    );
  }
}
