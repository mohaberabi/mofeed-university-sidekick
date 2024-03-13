import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mofeed_shared/localization/langs/app_local_ar.dart';
import 'package:mofeed_shared/localization/langs/app_local_en.dart';
import 'package:sakan/utils/enums/common_enums.dart';

abstract class AppLocalizations {
  final String locale;

  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String localizeError(String? code) {
    switch (code) {
      case "noNetWork":
        return noNetWork;
      case "unKnownError":
        return unKnownError;
      case "emailInUse":
        return emailInUse;
      case "wrongPass":
        return wrongPass;
      case "tooManyReq":
        return invalidEmail;
      case "invalidEmail":
        return invalidEmail;
      case "weakPassword":
        return weakPassword;
      case "emailReq":
        return emailReq;
      case "canceled":
        return canceled;
      case "notSameRestaurantId":
        return notSameRestaurantId;
      case "timeOut":
        return timeOut;
      case "invalidArgs":
        return invalidArgs;
      case "permissionDenied":
        return permissionDenied;
      case "unavailable":
        return unavailable;
      case "notFound":
        return notFound;
      case "noDomainNeededEmail":
        return noDomainNeededEmail;
      case "required":
        return required;
      case "sixCharPass":
        return sixCharPass;
      case "wrongPhone":
        return wrongPhone;
      default:
        return unKnownError;
    }
  }

  static const delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalDelegate();
  static const supportedLocales = [Locale('en'), Locale("ar")];

  String get verifyEmailAddress;

  String get iPrefer;

  String get readyToMoveAt;

  String get verifiedBy;

  String get sakanDeleted;

  String get kmfromYourUni;

  String get privateBath;

  String get sharedBath;

  String get flatMates;

  String get singleBed;

  String get sharedBed;

  String get address;

  String get chooseAddress;

  String get emailVerificationSent;

  String get emailSentDescribiton;

  String get infoUpdated;

  String get emailResnt;

  String get emailNotVerifiedError;

  String get didVerify;

  String get resendEmail;

  String get createAccount;

  String get createAccountSubTtl;

  String get privacyPolicy;

  String get helpSupport;

  String get and;

  String get disclaimerTtl;

  String get proudCrafted;

  String get fue;

  String get getStarted;

  String get yes;

  String get no;

  String get confirmUniveristyTitle;

  String get confirmUniversitySubtitle;

  String get confirmUniversityHint;

  String get email;

  String get passowrd;

  String get resendPassword;

  String get emailSent;

  String get viewCart;

  String get cart;

  String get confirmOrder;

  String get specialRequest;

  String get anySpecialRequest;

  String get online;

  String get offline;

  String get chats;

  String get noChatsYet;

  String get echoPosted;

  String get noEchosPosted;

  String get noEchosSubtitle;

  String get replies;

  String get delete;

  String get leaveEcho;

  String get needAnyHelp;

  String get post;

  String get echo;

  String get replyTo;

  String get reply;

  String get chooseUniversity;

  String get whereSideKick;

  String get confirm;

  String get flatInfo;

  String get foodCourt;

  String get sakan;

  String get parking;

  String get more;

  String get yourAccount;

  String get personalInfo;

  String get universityInfo;

  String get savedCars;

  String get orders;

  String get signOut;

  String get deleteAccount;

  String get termsCondition;

  String get choose;

  String get priceOnSelect;

  String get facultyHanodver;

  String get mins;

  String get noRestaurantsUseMofeed;

  String get startNewCart;

  String get startNewCartHint;

  String get cancel;

  String get clear;

  String get addToCart;

  String get chooseHandoverBuil;

  String get floor;

  String get room;

  String get howToPickup;

  String get whenWantOrder;

  String get chooseTime;

  String get orderTrackingIdle;

  String get handoverTime;

  String get orderFrom;

  String get talkToSupport;

  String get orderHandover;

  String get pickupFromFoodCourt;

  String get orderId;

  String get reOrder;

  String get uniAndResto;

  String get checkout;

  String get readBeforOrder;

  String get confirmPay;

  String get myOrders;

  String get noOrdersTitle;

  //Staying preferences

  String get stayPref;

  String get privateRoom;

  String get noOrdersSubtitle;

  String get billsHint;

  String get billsIncludedQ;

  String get chooseDate;

  String get maxPeriod;

  String get minPeriod;

  String get leaveEmptyIfNotYetKnow;

  String get justOneStep;

  String get phoneNo;

  String get showPhoneNo;

  String get shareSomeInfo;

  String get gieveDesc;

  String get giveTitle;

  String get sakanRequstTtlHint;

  String get back;

  String get next;

  String get addImages;

  String get availableFrom;

  String get roomPref;

  String get liveWithSameUniQ;

  String get howFarNearServiceQ;

  String get howFarNearServiceHint;

  String get metres;

  String get howManyMatesQ;

  String get saveExit;

  String get howToUseMofeed;

  String get clearAll;

  String get applyFilter;

  String get filterSakan;

  String get amenities;

  String get paymentPeriod;

  String get singleRoom;

  String get privateBathroom;

  String get profile;

  String get add;

  String get aboutYou;

  String get aboutYouHint;

  String get firstname;

  String get lastname;

  String get save;

  //

  String get noNetWork;

  String get unKnownError;

  String get emailInUse;

  String get wrongPass;

  String get tooManyReq;

  String get invalidEmail;

  String get weakPassword;

  String get emailReq;

  String get canceled;

  String get notSameRestaurantId;

  String get timeOut;

  String get invalidArgs;

  String get permissionDenied;

  String get unavailable;

  String get notFound;

  String get noDomainNeededEmail;

  String get required;

  String get sixCharPass;

  String get wrongPhone;

  String get aminityTtlMateWanted;

  String get aminityTtlRoomWanted;

  String get bathRoomTitleMateWanted;

  String get bathRoomTitleRoomWanted;

  String get paymentTitleRoomWanted;

  String get paymentTitleMateWanted;

  String get stayingTitleMateWanted;

  String get stayingTitleRoomWanted;

  String get priceTitleRoomWanted;

  String get priceTitleMateWanted;

  String get useCaseRoomWanted;

  String get userCaseMateWanted;

  String get roomReadyTitleMateWanted;

  String get roomReadyTitleRoomWanted;

  String get haveAnAccount;

  String get noListingsAdded;

  String get comBackLater;

  String get price;

  String get budget;

  String get allBillsInclueded;

  String get plustExtraBills;

  String get chat;

  String get moreInfo;

  String get aboutMe;

  String get km;

  String get nearestServices;

  String get writeSomeReview;

  String get reviews;

  String get leaveReview;

  String get restaurantHasNoReviews;

  String get makeOrderToReview;

  String get rate;

  String get shareYourExperienceWith;

  String get yourFeedBackPosted;

  String get notifications;

  String get recieveWhenNewEcho;

  String get recieveNotiUpdates;

  String get manageNotiFromSettingsTitle;

  String get manageNotiFromSettingsSubtitl;

  String get discard;

  String get listings;

  String get signOutQ;

  String get signOutExplain;

  String get settings;

  String get language;

  String get appearence;

  String get favorites;

  String get userDeletedNotFound;

  String get sorryComeLater;

  String get users;

  String get noFavorites;

  String get echoWasRemoved;

  String get helpReachedColleague;

  String get petOpinion;

  String get smoking;

  String get religion;

  String get gender;

  String get fname;

  String get lastName;

  String get phone;

  String get login;

  String get chooseProfilePic;

  String get letsSideKickTogether;

  String get loginUsingYouUniversityMail;

  String get completeProfile;

  String get resetPassword;

  String get explainWhyNeedData;
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<dynamic> old) {
    return false;
  }
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return const AppLocalizationsEng();
    case 'ar':
      return const AppLocalizationsAr();
    default:
      return const AppLocalizationsEng();
  }
}
