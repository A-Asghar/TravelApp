import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/Users.dart';

class UserProvider extends GetxController {
  Users? _user;
  set user(value) {
    _user = value;
    update();
  }

  Users? get user => _user;
}
