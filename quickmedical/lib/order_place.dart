import 'package:flutter/material.dart';
import 'package:quickmedical/home_page.dart';

class OrderSuccessPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final num totalAmount;

  const OrderSuccessPage({
    Key? key,
    required this.cartItems,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff4157FF),
        title: Text(
          'Order Summary',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Color(0xff4157FF),
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Your order was placed successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff4157FF),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Order Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff090F47),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartItems[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item['title'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Bottle of ${item['pellets']} pellets\nQuantity: ${item['count']}',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      'Rs.${item['price'] * item['count']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff090F47),
                ),
              ),
              trailing: Text(
                'Rs.$totalAmount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff090F47),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                cartItems: cartItems,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4157FF),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
