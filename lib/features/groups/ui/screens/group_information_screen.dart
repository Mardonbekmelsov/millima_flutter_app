import 'package:flutter/material.dart';
import 'package:millima/data/models/models.dart';

class GroupInformationScreen extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInformationScreen({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          groupModel.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Teachers",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            _buildTeacherTile(groupModel.mainTeacher, "Main Teacher"),
            const SizedBox(height: 10),
            _buildTeacherTile(groupModel.assistantTeacher, "Assistant Teacher"),
            const SizedBox(height: 20),
            const Text(
              "Students",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            groupModel.students.isEmpty
                ? const Text("No students available", style: TextStyle(fontSize: 18, color: Colors.black54))
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: groupModel.students.length,
                      itemBuilder: (context, index) {
                        final student = groupModel.students[index];
                        return _buildStudentTile(student);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherTile(User teacher, String role) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          teacher.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(teacher.phone),
        leading: CircleAvatar(
          radius: 30,
          child: teacher.photo == null
              ? const Icon(Icons.person, size: 40)
              : ClipOval(
                  child: Image.network(
                    teacher.photo!,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildStudentTile(User student) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          student.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(student.phone),
        leading: CircleAvatar(
          radius: 30,
          child: student.photo == null
              ? const Icon(Icons.person, size: 40)
              : ClipOval(
                  child: Image.network(
                    student.photo!,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                ),
        ),
      ),
    );
  }
}
