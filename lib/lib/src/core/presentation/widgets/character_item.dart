import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plass_getx/lib/src/core/presentation/res/res.dart';
import 'package:plass_getx/lib/src/core/presentation/theme/theme.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/favorite_widget.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/widgets.dart';
import 'package:plass_getx/lib/src/core/utils/commons_extensions.dart';
import 'package:plass_getx/lib/src/data/models/character_model.dart';

class CharacterItem extends StatefulWidget {
  final CharacterModel character;
  final bool isFavorite;

  const CharacterItem(
      {Key? key, required this.character, this.isFavorite = false})
      : super(key: key);

  @override
  State<CharacterItem> createState() => _CharacterItemState();
}

class _CharacterItemState extends State<CharacterItem> {
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return GestureDetector(
      onTap: () {
        context.push('/home/character/${widget.character.id}');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: 150,
                    height: 155,
                    imageUrl: widget.character.image,
                    fit: BoxFit.fill,
                    errorWidget: (_, __, ___) => Icon(
                      Icons.restaurant,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FavoriteWidget(
                      isFavorite: isFavorite,
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///Alive
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 15),
                      child: Wrap(
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: widget.character.status == 'Alive'
                                      ? UIColors.green
                                      : Colors.red,
                                ),
                              ),
                              HSpacing(5),
                              Text(
                                widget.character.status,
                                style: textSmall.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(" - "),
                              Text(
                                widget.character.species,
                                style: textSmall.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.character.name,
                            overflow: TextOverflow.ellipsis,
                            style: textNormal.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///Last Know Location
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            localization.text('common.lastKnowLocation'),
                            overflow: TextOverflow.ellipsis,
                            style: textSmall.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.character.location?.name ?? 'unknown',
                            overflow: TextOverflow.ellipsis,
                            style: textNormal.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///First Seen in
                    _FirstSeenInWrapper(
                      firstEpisode: widget.character.getFirstEpisode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FirstSeenInWrapper extends StatelessWidget {
  final String firstEpisode;

  const _FirstSeenInWrapper({
    Key? key,
    required this.firstEpisode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            localization.text('common.firstSeenIn'),
            overflow: TextOverflow.ellipsis,
            style: textSmall.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            '',
            overflow: TextOverflow.ellipsis,
            style: textNormal.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
