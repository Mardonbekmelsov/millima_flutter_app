import 'package:flutter/material.dart';
import 'package:millima/data/models/group/group_model.dart';

class GroupWidget extends StatelessWidget {
  final GroupModel group;

  const GroupWidget({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.shade700,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGroupDetail(
            icon: Icons.group,
            label: "Group Name: ${group.name}",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const Divider(color: Colors.white38, thickness: 1, height: 20),
          _buildGroupDetail(
            icon: Icons.person,
            label: "Main Teacher: ${group.mainTeacher.name}",
          ),
          const SizedBox(height: 10),
          _buildGroupDetail(
            icon: Icons.person_outline,
            label: "Assistant Teacher: ${group.assistantTeacher.name}",
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            title: const Text(
              "View Timetables",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            shape: const RoundedRectangleBorder(),
            children: [
              group.classes.isEmpty
                  ? const Text(
                      "There are no available timetables yet",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  : Column(
                      children: [
                        for (var classs in group.classes)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  classs.roomName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      classs.dayName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "${classs.startTime}-${classs.endTime}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupDetail({
    required IconData icon,
    required String label,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
