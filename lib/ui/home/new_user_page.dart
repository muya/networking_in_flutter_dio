import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:networking_in_flutter_dio/data/models/user_model.dart';
import 'package:networking_in_flutter_dio/ui/home/add_user_form.dart';
import 'package:networking_in_flutter_dio/ui/home/controller.dart';
import 'package:provider/provider.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {

  @override
  Widget build(BuildContext context) {
    final homeController = context.read<HomeController>();

    var newUsers = context.watch<HomeController>().newUsers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Newly Added User'),
      ),
      body: ListView.builder(
        itemCount: newUsers.length,
        itemBuilder: (context, index) {
          final NewUser user = newUsers[index];

          return ListTile(
            onLongPress: () async {
              await homeController.deleteUser(index).then((value) {
                // setState(() {});
              }).then(
                (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User Deleted Successfully'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
            onTap: () {
              homeController.nameController.text = user.name!;
              homeController.jobController.text = user.job!;

              UserForm userForm = UserForm(
                homeController: homeController,
                isUpdate: true,
                onSubmit: () async {
                  await homeController
                      .updateUser(
                    index,
                    homeController.nameController.text,
                    homeController.jobController.text,
                  )
                      .then((value) {
                    Navigator.pop(context);
                    // Ensure that the details in the current view are updated.
                    // setState(() {});
                  }).then((value) {
                    homeController.nameController.clear();
                    homeController.jobController.clear();
                  });
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User Updated Successfully'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              );

              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return userForm;
                },
              ).whenComplete(() {
                developer.log('bottom sheet closed');
                homeController.nameController.clear();
                homeController.jobController.clear();
              });
            },
            title: Text(user.name!),
            subtitle: Text(user.job!),
            trailing: user.updatedAt != null
                ? Text(DateFormat().format(DateTime.parse(user.updatedAt!)))
                : Text(DateFormat().format(DateTime.parse(user.createdAt!))),
          );
        },
      ),
    );
  }
}
