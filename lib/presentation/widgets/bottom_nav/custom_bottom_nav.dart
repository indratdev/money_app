import 'package:flutter/material.dart';

class Custom_Bottom_Nav extends StatefulWidget {
  Custom_Bottom_Nav({super.key, required this.currentIndex});

  int currentIndex;

  @override
  State<Custom_Bottom_Nav> createState() => _Custom_Bottom_NavState();
}

class _Custom_Bottom_NavState extends State<Custom_Bottom_Nav> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(displayWidth * .05),
      height: displayWidth * .155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              widget.currentIndex = index;
              // HapticFeedback.lightImpact();
            });
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == widget.currentIndex
                    ? displayWidth * .32
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: index == widget.currentIndex ? displayWidth * .12 : 0,
                  width: index == widget.currentIndex ? displayWidth * .32 : 0,
                  decoration: BoxDecoration(
                    color: index == widget.currentIndex
                        ? Colors.blueAccent.withOpacity(.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == widget.currentIndex
                    ? displayWidth * .31
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == widget.currentIndex
                              ? displayWidth * .13
                              : 0,
                        ),
                        AnimatedOpacity(
                          opacity: index == widget.currentIndex ? 1 : 0,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: Text(
                            index == widget.currentIndex
                                ? '${listOfStrings[index]}'
                                : '',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == widget.currentIndex
                              ? displayWidth * .03
                              : 20,
                        ),
                        Icon(
                          listOfIcons[index],
                          size: displayWidth * .076,
                          color: index == widget.currentIndex
                              ? Colors.blueAccent
                              : Colors.black26,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Favorite',
    'Settings',
    'Account',
  ];
}
