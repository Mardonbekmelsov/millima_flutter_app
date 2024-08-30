import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/features.dart';

// ignore: must_be_immutable
class SubjectDropForGroup extends StatefulWidget {
   SubjectDropForGroup({super.key, this.selectedId});

  int? selectedId;
  int get id => selectedId!;

  @override
  State<SubjectDropForGroup> createState() => _SubjectDropForGroupState();
}

class _SubjectDropForGroupState extends State<SubjectDropForGroup> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectBloc>().add(GetSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, SubjectState>(
      buildWhen: (previous, current) => current is SubjectsLoadedState,
      builder: (context, state) {
        if (state is SubjectsLoadedState) {
          final subjects = state.subjects;

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: DropdownButtonFormField<int>(
              value: widget.selectedId,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: "Choose Subject",
              ),
              items: [
                for (var subject in subjects)
                  DropdownMenuItem(
                    value: subject.id,
                    child: Text(subject.name),
                  ),
              ],
              validator: (value) {
                if (value == null) {
                  return "Please select a subject";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  widget.selectedId = value;
                });
              },
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
