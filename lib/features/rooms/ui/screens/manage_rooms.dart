import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/room/room_model.dart';
import 'package:millima/features/rooms/bloc/room_bloc.dart';
import 'package:millima/features/rooms/bloc/room_event.dart';
import 'package:millima/features/rooms/bloc/room_state.dart';
import 'package:millima/features/rooms/ui/screens/rooms_screen.dart';

class ManageRoom extends StatefulWidget {
  final RoomModel? roomModel;
  const ManageRoom({super.key, required this.roomModel});

  @override
  State<ManageRoom> createState() => _ManageRoomState();
}

class _ManageRoomState extends State<ManageRoom> {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();
  final TextEditingController capacityEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.roomModel != null) {
      nameEditingController.text = widget.roomModel!.name;
      descriptionEditingController.text = widget.roomModel!.description;
      capacityEditingController.text = widget.roomModel!.capacity.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.roomModel == null ? "Add Room" : "Edit Room",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            _buildTextField(
              controller: nameEditingController,
              labelText: "Name",
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: descriptionEditingController,
              labelText: "Description",
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: capacityEditingController,
              labelText: "Capacity",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            BlocBuilder<RoomBloc, RoomState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (state is RoomLoadingState) return;

                    if (nameEditingController.text.isNotEmpty &&
                        descriptionEditingController.text.isNotEmpty &&
                        capacityEditingController.text.isNotEmpty) {
                      context.read<RoomBloc>().add(
                            AddRoomEvent(
                              name: nameEditingController.text,
                              description: descriptionEditingController.text,
                              capacity: int.parse(capacityEditingController.text),
                            ),
                          );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RoomScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: state is RoomLoadingState
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.roomModel == null ? "Add Room" : "Edit Room",
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
