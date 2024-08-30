import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/features.dart';

// ignore: must_be_immutable
class TeacherDropDown extends StatefulWidget {
  final String label;

  TeacherDropDown({super.key, required this.label, required this.selectedId});

  int? selectedId;
  int get id => selectedId!;

  @override
  State<TeacherDropDown> createState() => _TeacherDropDownState();
}

class _TeacherDropDownState extends State<TeacherDropDown> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (previous, current) => current is UsersLoadedState,
      builder: (context, state) {
        if (state is UsersLoadedState) {
          final teachers =
              state.users.where((user) => user.role.name == 'teacher').toList();

          return DropdownButtonFormField<int>(
            value: widget.selectedId,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.label,
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            items: [
              for (var teacher in teachers)
                DropdownMenuItem(
                  value: teacher.id,
                  child: Text(
                    teacher.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
            onChanged: (value) {
              setState(() {
                widget.selectedId = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return "Please select a teacher";
              }
              return null;
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
