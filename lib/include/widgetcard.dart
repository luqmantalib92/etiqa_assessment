import 'package:etiqa_assessment/include/widgetdialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'database.dart';
import 'dateconverter.dart';
import 'colour.dart';

import '../page-add.dart';
import '../page-main.dart';

// ignore: must_be_immutable
class WidgetCard extends StatefulWidget {
  @override
  StateWidgetCard createState() {
    return StateWidgetCard();
  }

  // Initialize the variable widget
  int id;
  String title;
  String startDate;
  String endDate;
  String status;
  // Constructor widget card
  WidgetCard(this.id, this.title, this.startDate, this.endDate, this.status);
}

class StateWidgetCard extends State<WidgetCard> {
  // Initialize the status string and bool
  String _statusStr = "Incomplete";
  bool _statusBool = false;
  bool _constrain = false;

  // BUILD
  @override
  Widget build(BuildContext context) {
    // Save card id
    int idCard = widget.id;
    // Convert string to datetime
    DateTime sdate = DateTime.parse(widget.startDate);
    DateTime edate = DateTime.parse(widget.endDate);
    // Convert datetime to specific format
    String sDate = DateConverter().dateToStrDate(sdate);
    String eDate = DateConverter().dateToStrDate(edate);
    // Get duration left
    DateTime now = DateTime.now();
    int minute = edate.difference(now).inMinutes;
    int hour = edate.difference(now).inHours;
    int day = edate.difference(now).inDays;

    // Map time left to string
    String timeLeft = "0 min";
    if (day > 0) {
      hour = hour % 24;
      timeLeft = day.toString() + " day " + hour.toString() + " hrs";
    } else if (hour > 0) {
      hour = hour % 24;
      minute = minute % 60;
      timeLeft = hour.toString() + " hrs " + minute.toString() + " min";
    } else if (minute > 0) {
      minute = minute % 60;
      timeLeft = minute.toString() + " min";
    }

    // Update status todo
    setState(() {
      String stat = "true";
      if (_constrain)
        stat = _statusBool.toString();
      else
        stat = widget.status;

      if (stat == "true") {
        _statusStr = "Complete";
        _statusBool = true;
      } else {
        _statusStr = "Incomplete";
        _statusBool = false;
      }
      _constrain = true;
    });

    // ---------- //
    // -- CARD -- //
    // ---------- //
    return GestureDetector(
      // Detect tap to edit the todo card detail
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: PageAdd(1, idCard),
            duration: Duration(milliseconds: 250),
          ),
        );
      },
      // Detect long press to delete the todo card
      onLongPress: () {
        print("long press");
        WidgetDialog().basic(context, "Delete To-Do item",
            "Are you sure you want to delete this to-do item?", () {
          Database.deleteData(idCard);
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: PageMain(),
              duration: Duration(milliseconds: 250),
            ),
          );
        });
      },
      child: Card(
        margin: EdgeInsets.all(5),
        child: Container(
          width: double.infinity,
          color: _statusStr == "Complete"
              ? Colour().textTertiary
              : timeLeft == "0 min" ? Colour().tertiary : Colour().bgSecondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------- //
              // -- Title -- //
              // ----------- //
              Container(
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    // ---------------- //
                    // -- Start Date -- //
                    // ---------------- //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Date",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          sDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // -------------- //
                    // -- End Date -- //
                    // -------------- //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End Date",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          eDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // --------------- //
                    // -- Time Left -- //
                    // --------------- //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time left",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          timeLeft,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ------------ //
              // -- Status -- //
              // ------------ //
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                color: _statusStr == "Complete"
                    ? Colour().bgQuaternary
                    : timeLeft == "0 min"
                        ? Colour().quaternary
                        : Colour().secondary,
                // color: timeLeft == "0 min"? Colour().quaternary : Colour().secondary,
                child: Row(
                  children: [
                    Text(
                      "Status " + _statusStr,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Tick if complete",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Checkbox(
                      value: _statusBool,
                      checkColor: Colour().secondary,
                      activeColor: _statusStr == "Complete"
                          ? Colour().textTertiary
                          : Colour().tertiary,
                      onChanged: (bool newStatus) {
                        setState(() {
                          _statusBool = newStatus;
                          // Update status to database
                          Database.updateStatus(idCard, _statusBool);
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
