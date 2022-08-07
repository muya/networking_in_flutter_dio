import 'package:flutter/material.dart';
import 'package:networking_in_flutter_dio/di/service_locator.dart';
import 'package:networking_in_flutter_dio/ui/home/add_user_form.dart';
import 'package:networking_in_flutter_dio/ui/home/controller.dart';
import 'package:networking_in_flutter_dio/ui/home/new_user_page.dart';

class AddUserBtn extends StatelessWidget {
  AddUserBtn({Key? key}) : super(key: key);

  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    onPressed() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return UserForm(
            homeController: homeController,
            onSubmit: () async {
              await homeController.addNewUser();
              Navigator.pop(context);
              homeController.nameController.clear();
              homeController.jobController.clear();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NewUserPage(),
                ),
              );
            },
          );
        },
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
