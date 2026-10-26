
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_page.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalAmount;

  const PaymentPage({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'GCash';
  bool _isProcessing = false;

  Future<void> _processPayment() async {
    if (_isProcessing || widget.cartItems.isEmpty) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      // Ihanda ang mga produkto para sa Firestore.
      final items = widget.cartItems.map((item) {
        return <String, dynamic>{
          'name': item['name']?.toString() ?? 'Product',
          'price': (item['price'] as num?)?.toDouble() ?? 0.0,
          'quantity': (item['quantity'] as num?)?.toInt() ?? 1,
          'subtotal': ((item['price'] as num?)?.toDouble() ?? 0.0) *
              ((item['quantity'] as num?)?.toInt() ?? 1),
        };
      }).toList();

      // I-save ang order sa Firebase Firestore.
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': user?.uid ?? 'guest',
        'email': user?.email ?? 'guest@store.com',
        'items': items,
        'totalAmount': widget.totalAmount,
        'paymentMethod': _selectedPaymentMethod,
        'paymentStatus': 'Pending',
        'orderStatus': 'Pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      // Ipakita ang confirmation dialog.
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 55,
            ),
            title: const Text(
              'Order Placed Successfully!',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Your order has been saved successfully.\n\n'
              'Payment Method: $_selectedPaymentMethod\n'
              'Total: ₱${widget.totalAmount.toStringAsFixed(2)}\n\n'
              'Payment status: Pending',
              textAlign: TextAlign.center,
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();

                    // Bumalik sa HomePage.
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                        builder: (_) => const HomePage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8EE),
      appBar: AppBar(
        title: const Text('Checkout & Payment'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: widget.cartItems.isEmpty
                    ? const Center(
                        child: Text('Your cart is empty.'),
                      )
                    : ListView.separated(
                        itemCount: widget.cartItems.length,
                        separatorBuilder: (context, index) =>
                            const Divider(),
                        itemBuilder: (context, index) {
                          final item = widget.cartItems[index];

                          final name =
                              item['name']?.toString() ?? 'Product';

                          final price =
                              (item['price'] as num?)?.toDouble() ?? 0.0;

                          final quantity =
                              (item['quantity'] as num?)?.toInt() ?? 1;

                          final subtotal = price * quantity;

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFFFE0B2),
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.brown,
                              ),
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '₱${price.toStringAsFixed(2)} × $quantity',
                            ),
                            trailing: Text(
                              '₱${subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₱${widget.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              RadioGroup<String>(
                 groupValue: _selectedPaymentMethod,
                 onChanged: (String? value) {
                    if (!_isProcessing && value != null) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                }
              },
                child: const Column(
                  children: [
                    RadioListTile<String>(
                      value: 'GCash',
                      title: Text('GCash'),
                      subtitle: Text('Online payment'),
                      secondary: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.blue,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      value: 'Cash on Delivery',
                      title: Text('Cash on Delivery (COD)'),
                      subtitle: Text('Pay when your order arrives'),
                      secondary: Icon(
                        Icons.local_shipping,
                        color: Colors.brown,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _isProcessing ||
                          widget.cartItems.isEmpty
                      ? null
                      : _processPayment,
                  icon: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check_circle_outline),
                  label: Text(
                    _isProcessing
                        ? 'Processing Order...'
                        : 'Confirm Order',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
