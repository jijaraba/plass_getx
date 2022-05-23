import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:plass_getx/lib/src/core/hooks/curved_animation_hook.dart';
import 'package:plass_getx/lib/src/core/presentation/res/res.dart';
import 'package:plass_getx/lib/src/core/presentation/theme/theme.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/character_item.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/favorite_widget.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/shiny_icon_button.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/widgets.dart';
import 'package:plass_getx/lib/src/core/utils/commons_extensions.dart';
import 'package:plass_getx/lib/src/data/models/character_model.dart';
import 'package:plass_getx/lib/src/domain/entities/character_search_entity.dart';
import 'package:plass_getx/lib/src/presentation/home/home_controller.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return RefreshIndicator(
            color: UIColors.green100,
            onRefresh: () async {},
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Header
                  _CharacterDetailHeader(),

                  ///Favorite
                  _CharacterFavorite(),

                  ///Show Characters
                  if (controller.loadingCharacters)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (controller.characterList!.isNotEmpty)
                    Container(
                      child: _CharacterList(
                        characterList: controller.characterList!,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CharacterDetailHeader extends StatefulHookWidget {
  const _CharacterDetailHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<_CharacterDetailHeader> createState() => _CharacterDetailHeaderState();
}

class _CharacterDetailHeaderState extends State<_CharacterDetailHeader> {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final animation = useCurvedAnimation(
      animationController,
      curve: Curves.bounceInOut,
    );

    useMemoized(() => Future<void>(animationController.forward));

    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Image.asset(
                  Assets.background,
                  fit: BoxFit.cover,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  decoration: BoxDecoration(
                    color: UIColors.darkBlue,
                  ),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(child: _SearchTextField()),
                          HSpacing(40),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child:
                                PopupMenuButton<CharacterSearchDataFormGender>(
                              initialValue: CharacterSearchDataFormGender.all,
                              onSelected: (newGender) {
                                ///Update Search
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: borderRadiusSmall,
                              ),
                              child: ShinyIconButton(
                                icon: Icons.menu,
                                height: 50,
                                width: 50,
                              ),
                              color: UIColors.darkBlue,
                              itemBuilder: (_) =>
                                  CharacterSearchDataFormGender.values
                                      .map(
                                        (value) => PopupMenuItem<
                                            CharacterSearchDataFormGender>(
                                          value: value,
                                          child: PopOption(value: value),
                                        ),
                                      )
                                      .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              top: 40,
              child: Align(
                alignment: Alignment.topCenter,
                child: AspectRatio(
                  aspectRatio: 2.5 / 1.1,
                  child: ScaleTransition(
                    scale: animation,
                    child: Image.asset(
                      Assets.rickAndMortyLogo,
                      width: 300,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 30,
              top: 30,
              child: GestureDetector(
                onTap: () {
                  controller.signOut();
                  Navigator.pushNamed(
                    context,
                    AppRoutes.login,
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: UIColors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.close),
                ),
              ),
            ),
            if (controller.userModel != null)
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  width: 100,
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${controller.userModel!.firstName} ${controller.userModel!.lastName}',style: textNormal,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

class PopOption extends StatelessWidget {
  const PopOption({Key? key, required this.value}) : super(key: key);

  final CharacterSearchDataFormGender value;

  static final mapTitle = {
    CharacterSearchDataFormGender.all: 'Todos',
    CharacterSearchDataFormGender.unknown: 'Unknown',
    CharacterSearchDataFormGender.female: 'Female',
    CharacterSearchDataFormGender.male: 'Male',
    CharacterSearchDataFormGender.genderless: 'Genderless',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mapTitle[value] ?? '',
            style: textNormal.copyWith(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const HSpacing.regular(),
          Icon(
            Icons.menu,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class _SearchTextField extends HookWidget {
  const _SearchTextField({Key? key, this.value}) : super(key: key);

  final String? value;

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    final characterTextController = useTextEditingController(
      text: value,
    );
    return Container();
  }
}

class _CharacterList extends StatelessWidget {
  const _CharacterList({
    Key? key,
    required this.characterList,
  }) : super(key: key);

  final List<CharacterModel> characterList;

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        for (final item in characterList)
          CharacterItem(character: item, isFavorite: true),
      ],
    );
  }
}

class _CharacterFavorite extends StatefulHookWidget {
  const _CharacterFavorite({Key? key}) : super(key: key);

  @override
  State<_CharacterFavorite> createState() => _CharacterFavoriteState();
}

class _CharacterFavoriteState extends State<_CharacterFavorite> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Text(
            localization.text('common.showFavorites'),
            style: textNormal.copyWith(color: UIColors.black),
          ),
          HSpacing(10),
          FavoriteWidget(
            isFavorite: isFavorite,
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });

              ///TODO (jijaraba): Create favorite
            },
          )
        ],
      ),
    );
  }
}
