import 'package:flutter/material.dart';
import 'package:networking_in_flutter_dio/data/models/user_model.dart';
import 'package:networking_in_flutter_dio/di/service_locator.dart';
import 'package:networking_in_flutter_dio/ui/home/add_user_btn.dart';
import 'package:networking_in_flutter_dio/ui/home/app_bar.dart';
import 'package:networking_in_flutter_dio/ui/home/controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      floatingActionButton: AddUserBtn(),
      body: FutureBuilder<List<UserModel>>(
        future: homeController.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  leading: user.avatar != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            user.avatar!,
                            width: 50,
                            height: 50,
                          ),
                        )
                      : null,
                  title: Text(user.email ?? ''),
                  subtitle: Text(user.firstName ?? ''),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
