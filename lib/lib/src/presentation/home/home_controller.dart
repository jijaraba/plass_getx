import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:plass_getx/lib/src/data/models/character_model.dart';
import 'package:plass_getx/lib/src/data/models/user_model.dart';
import 'package:plass_getx/lib/src/data/repositories/auth_repository.dart';
import 'package:plass_getx/lib/src/data/repositories/character_repository.dart';
import 'package:plass_getx/lib/src/data/services/auth_services.dart';
import 'package:plass_getx/lib/src/domain/entities/character_search_entity.dart';
import 'package:plass_getx/lib/src/domain/repositories/i_auth_repository.dart';
import 'package:plass_getx/lib/src/domain/repositories/i_character_repository.dart';

class HomeController extends GetxController {
  final AuthenticateRepository _auth =
      AuthenticationImplementation(AuthenticateFirebase());

  final ICharacterRepository _characters = CharacterRepository();

  bool loadingCharacters = false;
  bool loadingUser = false;

  late StreamSubscription<DocumentSnapshot> userSubscription;

  //List
  List<CharacterModel>? characterList = <CharacterModel>[].obs;
  UserModel? userModel;

  Future<void> onInit() async {
    ///Get Characters
    loadingCharacters = true;
    try {
      characterList = await _characters.getCharacterList(CharacterSearchData(
        page: 1,
        gender: CharacterSearchDataFormGender.all,
        search: '',
      ));
      loadingCharacters = false;

      update();
    } catch (e) {
      loadingCharacters = false;
    }

    ///Get User Info
    loadingUser = true;
    userSubscription = _auth.getUserInfo().listen((event) {
      if (event.data() != null) {
        userModel = UserModel.fromJson(event.data()!);
        loadingUser = false;
        update();
      } else {
        userModel = null;
        loadingUser = false;
        update();
      }
    });
  }

  Future<String?> signOut() {
    return _auth.signOut();
  }
}
