import 'package:flutter/material.dart';
import 'package:quickmedical/cart_container.dart';
import 'package:quickmedical/home_page.dart';
import 'package:quickmedical/order_place.dart';

class Cart extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const Cart({
    super.key,
    required this.cartItems,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems;
  }

  void _updateItemCount(int index, int newCount) {
    setState(() {
      cartItems[index]['count'] = newCount;
    });
  }

  num _calculateTotal() {
    num total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['count'] - 44.6;
    }
    return num.parse(total.toStringAsFixed(2));
  }

  num _orderTotal() {
    num total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['count'];
    }
    return num.parse(total.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                cartItems: cartItems,
                              )),
                    );
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 5),
                Text(
                  "Your Cart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 25),
                Text(
                  "${cartItems.length} Items in your cart",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff090F4773).withOpacity(0.7)),
                ),
                Spacer(),
                Icon(Icons.add, color: Color(0xff4157FF)),
                SizedBox(width: 10),
                Text(
                  "Add more",
                  style: TextStyle(fontSize: 14, color: Color(0xff4157FF)),
                ),
              ],
            ),
            SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                var item = cartItems[index];
                return CartContainer(
                  display: AssetImage("home/MaskGroup.png"),
                  head: item['title'],
                  subHead: "Bottle of ${item['pellets']} pellets",
                  price: "Rs.${item['price']}",
                  count: item['count'],
                  onCountChanged: (newCount) {
                    _updateItemCount(index, newCount);
                  },
                  onRemove: () {
                    setState(() {
                      cartItems
                          .removeAt(index); // Remove item from cartItems list
                    });
                  },
                );
              },
            ),
            SizedBox(height: 130),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Text(
                        "Payment Summary",
                        style: TextStyle(
                            color: Color(0xff090F47),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 30, right: 20),
                    leading: Text(
                      "Order Total",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F4773).withOpacity(0.45),
                      ),
                    ),
                    trailing: Text(
                      "Rs.${_orderTotal()}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F47),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 30, right: 20),
                    leading: Text(
                      "Items Discount",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F4773).withOpacity(0.45),
                      ),
                    ),
                    trailing: Text(
                      "- 28.80",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F47),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 30, right: 20),
                    leading: Text(
                      "Coupon Discount",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F4773).withOpacity(0.45),
                      ),
                    ),
                    trailing: Text(
                      "-15.80",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F47),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 30, right: 20),
                    leading: Text(
                      "Shipping",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F4773).withOpacity(0.45),
                      ),
                    ),
                    trailing: Text(
                      "Free",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff090F47),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(
                            width: 1, color: Colors.grey.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 30, right: 20),
                    leading: Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff090F47),
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "Rs.${_calculateTotal()}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff090F47),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 330.6,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderSuccessPage(
                                  cartItems: cartItems,
                                  totalAmount: _calculateTotal())),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4157FF),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Place Order",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
