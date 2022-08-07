import 'package:flutter/material.dart';
import 'package:networking_in_flutter_dio/ui/home/new_user_page.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  const BaseAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Users'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewUserPage(),
              ),
            );
          },
          child: const Text(
            'NewUsers',
            // style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
