import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Hoạt động")),
      ),
      body: Center(
        child: _buildReadReview(),
      ),
    );
  }

  Widget _buildReadReview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Bạn chưa có hoạt động nào',
            textAlign: TextAlign.center, // Căn giữa text
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Khám phá ngay các dịch vụ trên Taxi App và tận hưởng nhiều ưu đãi ngập tràn',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
