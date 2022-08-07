import 'package:flutter/material.dart';
import 'package:networking_in_flutter_dio/data/models/user_model.dart';
import 'package:networking_in_flutter_dio/di/service_locator.dart';
import 'package:networking_in_flutter_dio/ui/home/add_user_form.dart';
import 'package:networking_in_flutter_dio/ui/home/controller.dart';
import 'package:intl/intl.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final homeController = getIt.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newly Added User'),
      ),
      body: ListView.builder(
        itemCount: homeController.newUsers.length,
        itemBuilder: (context, index) {
          final NewUser user = homeController.newUsers[index];

          return ListTile(
            onLongPress: () async {
              await homeController.deleteUser(index).then((value) {
                setState(() {});
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
                    setState(() {});
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
              );
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
