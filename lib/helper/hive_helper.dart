import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../screens/users/model/user_response.dart';
import '../utils/utils.dart';

class HiveHelper {
  static late Box<UserResponse> userBox;
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    /// UserResponse model's adapter registration
    Hive
      ..registerAdapter(UserResponseAdapter())//0
      ..registerAdapter(HairAdapter())//1
      ..registerAdapter(AddressAdapter())//2
      ..registerAdapter(CoordinatesAdapter())//3
      ..registerAdapter(BankAdapter())//4
      ..registerAdapter(CompanyAdapter())//5
      ..registerAdapter(CryptoAdapter());//6
    userBox = await Hive.openBox<UserResponse>(HiveLocalStorageBox.userBox);
  }

  static Future<void> clearUserData() async {
    if (userBox.isOpen) {
      await userBox.clear();
    }
  }
}
