import 'package:flutter/material.dart';
import 'package:millima/features/groups/ui/screens/add_group_screen.dart';
import 'package:millima/features/rooms/ui/screens/rooms_screen.dart';
import 'package:millima/features/subject/ui/screens/subjects_screen.dart';
import 'package:millima/features/user/ui/screens/admin_screen.dart';
import 'package:millima/features/users/ui/screens/profile_screen.dart';
import 'package:millima/features/users/ui/screens/show_users_screen.dart';

class CustomDrawerForAdmin extends StatelessWidget {
  const CustomDrawerForAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
            ),
            child: const Text(
              "MENU",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(
            context: context,
            title: "Home Page",
            icon: Icons.home,
            destination: const AdminScreen(),
          ),
          _buildDrawerItem(
            context: context,
            title: "Profile",
            icon: Icons.person,
            destination: const ProfileScreen(),
          ),
          _buildDrawerItem(
            context: context,
            title: "Students",
            icon: Icons.school,
            destination: const ShowUsersScreen(roleId: 1),
          ),
          _buildDrawerItem(
            context: context,
            title: "Teachers",
            icon: Icons.person_pin,
            destination: const ShowUsersScreen(roleId: 2),
          ),
          _buildDrawerItem(
            context: context,
            title: "Admins",
            icon: Icons.admin_panel_settings,
            destination: const ShowUsersScreen(roleId: 3),
          ),
          _buildDrawerItem(
            context: context,
            title: "Add Group",
            icon: Icons.group_add,
            destination: const AddGroupScreen(),
          ),
          _buildDrawerItem(
            context: context,
            title: "Rooms",
            icon: Icons.room,
            destination: const RoomScreen(),
          ),
          _buildDrawerItem(
            context: context,
            title: "Subjects",
            icon: Icons.subject,
            destination: const SubjectsScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget destination,
  }) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => destination),
        );
      },
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.blue.shade700,
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
    );
  }
}
