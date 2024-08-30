import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';
import 'package:millima/ui_kit/shimmer_list.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetGroupsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F9FD),
      drawer: const CustomDrawerForAdmin(),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthenticationBloc>().add(LogoutEvent());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        title: const Text(
          "Admin Panel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search groups...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {}); // Update UI on search
                },
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoadingState) {
            return const ShimmerList(
              count: 4,
              type: ShimmerListType.card,
            );
          } else if (state is GroupErrorState) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (state is GroupLoadedState) {
            final groups = _searchController.text.isEmpty
                ? state.groups
                : state.groups
                    .where((group) => group.name
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                    .toList();

            if (groups.isEmpty) {
              return const Center(
                child: Text('No groups found.'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return _buildGroupCard(context, groups[index]);
              },
            );
          }
          return const Center(
            child: Text("No groups available!"),
          );
        },
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, GroupModel group) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onLongPress: () {
        _showGroupOptions(context, group);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupInformationScreen(groupModel: group),
          ),
        );
      },
      child: Container(
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
            _buildActionButtons(context, group),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupDetail({
    required IconData icon,
    required String label,
    double fontSize = 20,
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
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showGroupOptions(BuildContext context, GroupModel group) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(8),
          title: Text(group.name),
          actions: [
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateGroup(group: group),
                      ),
                    );
                  },
                  label: const Text("Edit Group"),
                  icon: const Icon(Icons.edit_document),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStudentToGroupScreen(
                          groupModel: group,
                        ),
                      ),
                    );
                  },
                  label: const Text("Add Students"),
                  icon: const Icon(Icons.person_add),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context, GroupModel group) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GetGroupTimetablesScreen(
                  groupId: group.id,
                ),
              ),
            );
          },
          icon: const Icon(Icons.schedule),
          label: const Text('View Timetables'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTimetableScreen(groupId: group.id),
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Timetable'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
