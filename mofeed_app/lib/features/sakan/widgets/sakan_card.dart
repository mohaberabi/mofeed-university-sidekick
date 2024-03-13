import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mofeduserpp/features/favorite/widget/favorite_detector.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/utils/extensions/media_query_ext.dart';
import 'package:mofeed_shared/utils/extensions/num_extension.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/model/room_wanted.dart';
import 'package:sakan/model/sakan_model.dart';

class SakanCard extends StatelessWidget {
  final Sakan sakan;

  const SakanCard({super.key, required this.sakan});

  static Widget mateAddress(
    BuildContext context, {
    required Sakan sakan,
  }) {
    if (sakan is MateWanted) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        titleTextStyle: context.bodyLarge,
        title: Text(sakan.address.name),
        leading: const Icon(Icons.pin_drop_outlined),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xlg),
      child: sakan is MateWanted
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(context),
                const SizedBox(height: AppSpacing.xs),
                _title(context),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _avatar(context),
                    _price(context),
                  ],
                ),
                mateAddress(context, sakan: sakan as MateWanted),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _image(context),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _title(context),
                        const SizedBox(height: AppSpacing.md),
                        _avatar(context),
                        _price(context),
                      ]),
                )
              ],
            ),
    );
  }

  Widget _title(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: context.width * 0.9,
          child: Text(
            sakan.title,
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: context.width * 0.9,
          child: Text(
            sakan.description,
            style: context.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  Widget _image(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == sakan.uid) {
      return _heroImage(context);
    } else {
      return FavoriteDetector(
        backgroundColor: Colors.white,
        id: sakan.id,
        type: sakan is RoomWanted
            ? FavoriteType.roomWanted
            : FavoriteType.mateWanted,
        child: Hero(
          tag: sakan.id,
          child: CachedImage(
            w: sakan is MateWanted ? context.width : 150,
            h: 200,
            imageUrl: sakan.cover,
            decorated: true,
            radius: 8,
            boxFit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Widget _heroImage(BuildContext context) => Hero(
        tag: sakan.id,
        child: CachedImage(
          w: sakan is MateWanted ? context.width : 150,
          h: 200,
          imageUrl: sakan.cover,
          decorated: true,
          radius: 8,
          boxFit: BoxFit.cover,
        ),
      );

  Widget _avatar(BuildContext context) => Row(
        children: [
          CachedImage(
            w: 20,
            h: 20,
            imageUrl: sakan.profilePic,
            decorated: true,
            boxFit: BoxFit.cover,
            radius: 50,
          ),
          const SizedBox(width: 4),
          Text(sakan.username, style: context.bodySmall),
        ],
      );

  Widget _price(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            sakan.price.toPrice(context.lang),
            style: context.bodyMedium,
          ),
          Text(' /${sakan.billingPeriod.tr(context.lang)}',
              style: context.bodyMedium.copyWith(color: Colors.grey)),
        ],
      );
}
