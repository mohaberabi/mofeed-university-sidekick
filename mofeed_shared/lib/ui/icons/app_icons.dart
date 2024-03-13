import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mofeed_shared/ui/colors/app_colors.dart';
import 'package:mofeed_shared/utils/extensions/widget_Ext.dart';

abstract class AppIcons {
  static const String _path = 'packages/mofeed_shared/assets';

  static const String logo = 'packages/mofeed_shared/assets/logo.svg';

  static const String home = '$_path/home.svg';
  static const String mail = '$_path/mail.svg';
  static const String car = '$_path/car.svg';
  static const String apps = '$_path/apps.svg';
  static const String bathhub = '$_path/bathhub.svg';
  static const String bed = '$_path/bed.svg';
  static const String bell = '$_path/bell.svg';
  static const String chat = '$_path/chat.svg';
  static const String clock = '$_path/clock.svg';
  static const String file = '$_path/file.svg';
  static const String help = '$_path/help.svg';
  static const String info = '$_path/info.svg';
  static const String insurance = '$_path/insurance.svg';
  static const String language = '$_path/language.svg';
  static const String location = '$_path/location.svg';
  static const String marker = '$_path/marker.svg';
  static const String meeting = '$_path/meeting.svg';
  static const String microphone = '$_path/microphone.svg';
  static const String money = '$_path/money.svg';
  static const String moto = '$_path/moto.svg';
  static const String phone = '$_path/phone.svg';
  static const String recipt = '$_path/recipt.svg';
  static const String share = '$_path/share.svg';
  static const String star = '$_path/star.svg';
  static const String takeaway = '$_path/takeaway.svg';
  static const String user = '$_path/user.svg';
  static const String wifi = '$_path/wifi.svg';
  static const String longAr = '$_path/longar.svg';
  static const String long = '$_path/long.svg';
  static const String done = '$_path/done.svg';
  static const String doneDark = '$_path/donDark.svg';

  static const String edit = '$_path/edit.svg';
  static const String uni = '$_path/uni.svg';
  static const String mates = '$_path/mates.svg';
  static const String room = '$_path/room.svg';
  static const String group = '$_path/group.svg';
  static const String park = '$_path/park.svg';
  static const String more = '$_path/more.svg';
  static const String pizza = '$_path/pizza.svg';

  static const String ac = '$_path/ac.svg';
  static const String bathtub = '$_path/bathtub.svg';
  static const String fries = '$_path/fries.svg';
  static const String microwave = '$_path/microwave.svg';
  static const String tv = '$_path/tv.svg';
  static const String washer = '$_path/washer.svg';

  static const String muslim = '$_path/muslim.svg';

  static const String cart = '$_path/cart.svg';

  static const String male = '$_path/male.svg';

  static const String female = '$_path/female.svg';

  static const String noPet = '$_path/noPet.svg';

  static const String pet = '$_path/pet.svg';

  static const String smoke = '$_path/smoke.svg';
  static const String calender = '$_path/calender.svg';

  static const String noSmoking = '$_path/noSmking.svg';
  static const String chris = '$_path/christ.svg';
  static const String min = '$_path/min.svg';
  static const String max = '$_path/max.svg';
  static const String area = '$_path/area.svg';
  static const String service = '$_path/service.svg';

  static const String peper = '$_path/peper.svg';
  static const String category = '$_path/category.svg';
  static const String gallery = '$_path/gallery.svg';
}

class AppIcon extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;
  final bool custom;

  const AppIcon(
    this.path, {
    Key? key,
    this.size = 22.0,
    this.color,
    this.custom = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choosedColor =
        custom ? color : (color ?? context.theme.iconTheme.color);
    return SvgPicture.asset(
      path,
      fit: BoxFit.cover,
      color: choosedColor,
      width: size,
      height: size,
    );
  }
}
