import 'package:flutter/material.dart';
import 'package:networking_in_flutter_dio/data/models/user_model.dart';
import 'package:networking_in_flutter_dio/data/repository/user_repository.dart';
import 'package:networking_in_flutter_dio/di/service_locator.dart';

class HomeController {
  // Repository.
  final userRepository = getIt.get<UserRepository>();

  // TextField Controller.
  final nameController = TextEditingController();
  final jobController = TextEditingController();

  // Local variables.
  final List<NewUser> newUsers = [];

  // Methods.
  Future<List<UserModel>> getUsers() async {
    final users = await userRepository.getUsersRequested();
    return users;
  }

  Future<NewUser> addNewUser() async {
    final newlyAddedUser = await userRepository.addNewUserRequested(
      nameController.text,
      jobController.text,
    );

    newUsers.add(newlyAddedUser);
    return newlyAddedUser;
  }

  Future<NewUser> updateUser(int id, String name, String job) async {
    final updatedUser = await userRepository.updateUserRequested(
      id,
      name,
      job,
    );
    newUsers[id] = updatedUser;

    return updatedUser;
  }

  Future<void> deleteUser(int id) async {
    await userRepository.deleteUserRequested(id);
    newUsers.removeAt(id);
  }
}
