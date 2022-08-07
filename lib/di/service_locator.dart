
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:networking_in_flutter_dio/data/network/api/user/user_api.dart';
import 'package:networking_in_flutter_dio/data/network/dio_client.dart';
import 'package:networking_in_flutter_dio/data/repository/user_repository.dart';
import 'package:networking_in_flutter_dio/ui/home/controller.dart';

// Get instance of get_it
final getIt = GetIt.instance;

Future<void> setup() async {
  // Singleton registers an instance once, as opposed to registerFactory, which
  // creates a new one every time
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(UserApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(UserRepository(getIt.get<UserApi>()));

  getIt.registerSingleton(HomeController());
}
