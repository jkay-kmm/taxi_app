import 'package:flutter/material.dart';

class RidePicker extends StatefulWidget {
  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: <Widget>[
          _buildRideOption(
            icon: Icons.location_pin,
            controller: fromController,
            hintText: "Nhập điểm xuất phát",
            onTap: () {
              // Hành động khi chọn "Hiện tại"
              print("Địa chỉ hiện tại: ${fromController.text}");
            },
          ),
          const Divider(height: 1, color: Colors.grey),
          _buildRideOption(
            icon: Icons.near_me,
            controller: toController,
            hintText: "Nhập điểm đến",
            onTap: () {
              // Hành động khi chọn "Đến"
              print("Địa chỉ đến: ${toController.text}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRideOption({
    required IconData icon,
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFFF5F7FA), Color(0xFFEFF2F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.blueAccent),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                style: TextStyle(fontSize: 16, color: Color(0xFF323643)),
              ),
            ),
            Icon(Icons.close, size: 20, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
