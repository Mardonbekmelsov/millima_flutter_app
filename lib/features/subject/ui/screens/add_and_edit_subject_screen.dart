import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';
class AddAndEditSubjectScreen extends StatefulWidget {
  const AddAndEditSubjectScreen({super.key, required this.subject});

  final SubjectModel? subject;

  @override
  State<AddAndEditSubjectScreen> createState() => _AddAndEditSubjectScreenState();
}

class _AddAndEditSubjectScreenState extends State<AddAndEditSubjectScreen> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.subject != null) {
      setState(() {
        textController.text = widget.subject!.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.subject == null ? "Add Subject" : "Edit Subject",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                labelText: "Subject Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<SubjectBloc, SubjectState>(
              listener: (context, state) {
                if (state is SubjectsLoadedState) {
                  Navigator.pop(context);
                }
                if (state is SubjectErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      context.read<SubjectBloc>().add(
                        widget.subject == null
                            ? AddSubjectEvent(subjectName: textController.text)
                            : EditSubjectEvent(
                                subjectId: widget.subject!.id,
                                newName: textController.text,
                              ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: state is SubjectLoadingState
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.subject == null ? "Add Subject" : "Edit Subject",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

