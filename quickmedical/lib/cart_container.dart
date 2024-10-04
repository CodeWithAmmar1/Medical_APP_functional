import 'dart:ui';
import 'package:flutter/material.dart';

class CartContainer extends StatefulWidget {
  final AssetImage display;
  final String head;
  final String subHead;
  final String price;
  final int count;
  final ValueChanged<int> onCountChanged;
  final VoidCallback onRemove;

  const CartContainer({
    super.key,
    required this.display,
    required this.head,
    required this.subHead,
    required this.price,
    required this.count,
    required this.onCountChanged,
    required this.onRemove,
  });

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  late int count;
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.only(right: 5),
            width: 70,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(image: widget.display, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.head,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.subHead,
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(height: 20),
                Text(
                  widget.price,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40, right: 5),
                child: InkWell(
                  onHover: (value) {
                    Text("delete item");
                  },
                  onTap: () {
                    setState(() {
                      {
                        widget.onRemove();
                      }
                    });
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    color: Color(0xff00000040).withOpacity(0.25),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF2F4FF),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (count > 1) {
                              setState(() {
                                count--;
                              });
                              widget.onCountChanged(count);
                            }
                          },
                          child: Icon(
                            Icons.remove_circle,
                            size: 25,
                            color: Color(0xffDFE3FF),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text("$count"),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              count++;
                            });
                            widget.onCountChanged(count);
                          },
                          child: Icon(
                            Icons.add_circle,
                            size: 25,
                            color: Color(0xffA0ABFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
