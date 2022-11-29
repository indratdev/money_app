import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PinChangeScreen extends StatelessWidget {
  const PinChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('set-pin'.tr())),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          InkWell(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Text("1")),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("2"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("3"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("4"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("5"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("6"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("7"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("8"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("9"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child:
                  ElevatedButton(onPressed: () {}, child: const Text("More"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(onPressed: () {}, child: const Text("0"))),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[100],
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Cancel"))),
        ],
      ),
    );
  }
}
