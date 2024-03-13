import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mofeduserpp/core/utils/extensions/geolocator_ext.dart';
import 'package:mofeduserpp/core/widgets/sliver_scafolld.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_cubit.dart';
import 'package:mofeduserpp/features/sakan/cubit/sakan_cubit/sakan_state.dart';
import 'package:mofeduserpp/features/sakan/widgets/sakan_view_bg.dart';
import 'package:mofeduserpp/features/sakan/widgets/staying_period_sakan_view.dart';
import 'package:mofeduserpp/features/sakan/widgets/view_sakan_bottom_nav.dart';
import 'package:mofeduserpp/features/sakan/widgets/view_sakan_metadata.dart';
import 'package:mofeduserpp/features/sakan/widgets/view_sakan_room.dart';
import 'package:mofeed_shared/constants/const_methods.dart';
import 'package:mofeed_shared/model/favorite_model.dart';
import 'package:mofeed_shared/ui/icons/app_icons.dart';
import 'package:mofeed_shared/ui/spacing/spacing.dart';
import 'package:mofeed_shared/ui/theme/theme_ext.dart';
import 'package:mofeed_shared/ui/widgets/cached_image.dart';
import 'package:mofeed_shared/ui/widgets/loader.dart';
import 'package:mofeed_shared/ui/widgets/my_place_holder.dart';
import 'package:mofeed_shared/ui/widgets/read_more.dart';
import 'package:mofeed_shared/ui/widgets/text_icon.dart';
import 'package:mofeed_shared/utils/extensions/date_time_extension.dart';
import 'package:mofeed_shared/utils/extensions/nav_build_context_Ext.dart';
import 'package:mofeed_shared/utils/extensions/status_builder.dart';
import 'package:mofeed_shared/utils/extensions/text_style_ext.dart';
import 'package:mofeed_shared/utils/extensions/tr_exte.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';
import 'package:mofeed_shared/utils/time_ago.dart';

import 'package:sakan/model/mate_wanted.dart';
import 'package:sakan/model/sakan_model.dart';
import 'package:sakan/utils/enums/room_enums.dart';

import '../../../core/widgets/empty_scaffold.dart';
import '../../favorite/widget/favorite_detector.dart';
import '../../profile/cubit/profile_cubit.dart';

class ViewSakanScreen extends StatelessWidget {
  final Sakan sakan;

  const ViewSakanScreen({super.key, required this.sakan});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final onError = AppPlaceHolder.empty();
    final uid = context.read<ProfileCubit>().state.user.uId;
    final String amenitiesString =
        sakan is MateWanted ? local.amenities : local.iPrefer;
    final String movingTime =
        sakan is MateWanted ? local.availableFrom : local.readyToMoveAt;
    return BlocConsumer<SakanCubit, SakanState>(
      builder: (context, state) {
        final view = SliverScaffold(
          title: Text(sakan.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: context.bodyLarge.copyWith(fontSize: 16)),
          expandedHeight: 300,
          actions: [
            if (sakan.uid != uid)
              FavoriteDetector(
                  iconSize: 22,
                  type: (sakan is MateWanted)
                      ? FavoriteType.mateWanted
                      : FavoriteType.roomWanted,
                  id: sakan.id),
          ],
          bootomNavBar: ViewSakanBottomNavBar(sakan: sakan),
          background: SakanViewBG(sakan: sakan),
          body: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: CustomScrollView(
              slivers: [
                ...[
                  Text(sakan.title, style: context.headlineSmall),
                  ReadMore(sakan.description, style: context.bodyMedium),
                  SakanViewDistanceDetails(sakan: sakan),
                  const Divider(),
                  Row(
                    children: [
                      CachedImage(
                          imageUrl: sakan.profilePic,
                          decorated: true,
                          boxFit: BoxFit.cover,
                          radius: 100,
                          w: 36,
                          h: 36),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child:
                            Text(sakan.username, style: context.headlineMedium),
                      ),
                      Text(
                        TimeAgo(sakan.createdAt, context.lang).timeAgo,
                        style: context.bodyLarge.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  ViewSakanMetaData(sakan: sakan),
                  const Divider(),
                  TextIcon.svg(
                      iconFirst: true,
                      mainAxisAlignment: MainAxisAlignment.start,
                      text: "$movingTime ${sakan.availableFrom.mDy}",
                      path: AppIcons.calender,
                      size: 20,
                      style: context.bodyLarge),
                  StayingPeriodSakanView(sakan: sakan),
                  const Divider(),
                  Text(amenitiesString, style: context.headlineMedium),
                  MatePreferdData(sakan: sakan),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.md,
                    children: sakan.amenties.map((e) {
                      return SakanViewAminities(amenity: e);
                    }).toList(),
                  ),
                  const Divider(),
                  if (sakan is MateWanted)
                    MateWantedInfo(mateWanted: sakan as MateWanted),
                  Text(local.verifiedBy, style: context.headlineMedium),
                  ListTile(
                    horizontalTitleGap: 0,
                    leading: const AppIcon(AppIcons.uni),
                    title: Text(sakan.universityName[context.lang] ?? ""),
                  ),
                ].map((e) => e.toSliver).toList(),
              ],
            ),
          ),
        );
        return state.state.builder({
          SakanStatus.loading: () => const EmptyScaffold(child: Loader()),
          SakanStatus.error: () => onError,
          SakanStatus.populated: () => view,
        }, placeHolder: view);
      },
      listener: (context, state) {
        if (state.state == SakanStatus.deleted) {
          context.showSnackBar(
              message: local.sakanDeleted,
              doBefore: () => Navigator.pop(context));
        } else if (state.state == SakanStatus.error) {
          context.showSnackBar(
              message: state.error, state: FlushBarState.error);
        }
      },
    );
  }
}

class SakanViewAminities extends StatelessWidget {
  final RoomAmenity amenity;

  const SakanViewAminities({super.key, required this.amenity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (amenity.logo != null) AppIcon(amenity.logo!),
          const SizedBox(width: AppSpacing.sm),
          Text(
            amenity.tr(context.lang),
            style: context.bodyLarge.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}

class SakanViewDistanceDetails extends StatelessWidget {
  final Sakan sakan;

  const SakanViewDistanceDetails({
    super.key,
    required this.sakan,
  });

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final myUni = context.read<SakanCubit>().state.myUniversity;
    if (sakan is MateWanted) {
      final mate = sakan as MateWanted;
      final distanceInKm = context
          .distanceInKm(
              startLat: mate.address.lat,
              startLng: mate.address.lng,
              endLat: myUni.location.latitude,
              endLng: myUni.location.longitude)
          .toStringAsFixed(1);
      return myUni.isEmpty
          ? const SizedBox()
          : ListTile(
              horizontalTitleGap: 0,
              contentPadding: EdgeInsets.zero,
              leading: const AppIcon(AppIcons.location),
              title: Text("$distanceInKm ${local.kmfromYourUni}"),
              subtitle: Text(
                  '${(sakan as MateWanted).address.name} ${(sakan as MateWanted).address.subName}'),
            );
    } else {
      return const SizedBox();
    }
  }
}

class MatePreferdData extends StatelessWidget {
  final Sakan sakan;

  const MatePreferdData({super.key, required this.sakan});

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TextIcon.svg(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            text: sakan.privateBathRoom ? local.privateBath : local.sharedBath,
            columed: true,
            path: AppIcons.bathtub,
            size: 36,
          ),
          if (sakan is MateWanted)
            TextIcon.svg(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              text: "${(sakan as MateWanted).currentMates} ${local.flatMates}",
              columed: true,
              path: AppIcons.mates,
              size: 36,
            ),
          if (sakan is MateWanted)
            TextIcon.svg(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              text: (sakan as MateWanted).isSingle
                  ? local.singleBed
                  : local.sharedBed,
              columed: true,
              path: AppIcons.bed,
              size: 36,
            ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.all(AppSpacing.xxs),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: context.theme.primaryDecoration,
                    child: e,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
