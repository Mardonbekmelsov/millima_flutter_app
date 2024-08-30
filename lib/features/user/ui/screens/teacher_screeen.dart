import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the GetGroupsEvent when the screen initializes
    context.read<GroupBloc>().add(GetTeacherGroups());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomDrawerForAdmin(),
              ),
            );
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          "Teacher Panel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GroupErrorState) {
            return Center(
              child: Text(
                'Failed to load groups: ${state.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is GroupLoadedState) {
            return ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (context, index) {
                return _buildGroupTile(context, state.groups[index]);
              },
            );
          } else {
            return const Center(child: Text('No groups found.'));
          }
        },
      ),
    );
  }

  Widget _buildGroupTile(BuildContext context, GroupModel group) {
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.mainTeacher.name),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupInformationScreen(groupModel: group),
            ),
          );
        },
      ),
    );
  }
}
