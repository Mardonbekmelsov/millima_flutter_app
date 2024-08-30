import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';

class ShowUsersScreen extends StatefulWidget {
  final int roleId;
  const ShowUsersScreen({super.key, required this.roleId});

  @override
  State<ShowUsersScreen> createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.roleId == 1
              ? "Students"
              : widget.roleId == 2
                  ? "Teachers"
                  : "Admins",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is UsersLoadedState) {
            final roleFilteredUsers = state.users.where((user) => user.roleId == widget.roleId).toList();
            
            if (roleFilteredUsers.isEmpty) {
              return const Center(
                child: Text("No users found"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: roleFilteredUsers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      roleFilteredUsers[index].name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      roleFilteredUsers[index].phone,
                      style: const TextStyle(fontSize: 16),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: roleFilteredUsers[index].photo != null
                          ? NetworkImage(roleFilteredUsers[index].photo!)
                          : const AssetImage("assets/avatar_placeholder.png")
                              as ImageProvider,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text("No users found"),
          );
        },
      ),
    );
  }
}
