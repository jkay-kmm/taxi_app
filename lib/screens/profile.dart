import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hồ sơ của bạn"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Cài đặt tài khoản",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // List of options
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildListItem(
                  icon: Icons.person_outline,
                  title: "Trang cá nhân",
                  subtitle: "Thay đổi thông tin tài khoản của bạn",
                ),
                _buildListItem(
                  icon: Icons.history,
                  title: "Lịch sử đi xe",
                  subtitle: "Xem lịch sử chuyến đi của bạn",
                ),
                _buildListItem(
                  icon: Icons.location_on_outlined,
                  title: "Địa chỉ",
                  subtitle: "Thêm địa chỉ của bạn",
                ),
                _buildListItem(
                  icon: Icons.share_outlined,
                  title: "Tham khảo bạn bè",
                  subtitle: "Chia sẻ ứng dụng này với bạn bè của bạn",
                ),
                _buildListItem(
                  icon: Icons.notifications_outlined,
                  title: "Thông báo",
                  subtitle: "Quản lý thông báo",
                ),
                _buildListItem(
                  icon: Icons.logout,
                  title: "Đăng xuất",
                  subtitle: "Đăng xuất khỏi tài khoản của bạn",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Colors.grey),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        // Thêm hành động khi nhấn vào mục
      },
    );
  }
}
