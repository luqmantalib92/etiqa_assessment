import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'include/colour.dart';

import 'page-list.dart';

class PageMain extends StatefulWidget {
  @override
  StatePageMain createState() {
    return StatePageMain();
  }
}

class StatePageMain extends State<PageMain> {
  // LOAD TO-DO LIST PAGE
  void loadPageList() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: PageList(),
        duration: Duration(milliseconds: 250),
      ),
    );
  }

  // BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------- //
      // -- APP BAR -- //
      // ------------- //
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(),
      ),
      // ---------- //
      // -- BODY -- //
      // ---------- //
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => ScaleAnimation(
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                GestureDetector(
                  onTap: () => loadPageList(),
                  child: Image.asset('assets/icon/foreground.png'),
                ),
                Container(
                  height: 60,
                ),
              ],
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
                child: FlatButton(
                  onPressed: () => loadPageList(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Proceed",
                        style: TextStyle(
                          color: Colour().primary,
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
