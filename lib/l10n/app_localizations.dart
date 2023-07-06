import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @login_masg.
  ///
  /// In en, this message translates to:
  /// **'Login to your account '**
  String get login_masg;

  /// No description provided for @valide_masg.
  ///
  /// In en, this message translates to:
  /// **'can not be large than 50'**
  String get valide_masg;

  /// No description provided for @validp_masg.
  ///
  /// In en, this message translates to:
  /// **'can not be small then 2'**
  String get validp_masg;

  /// No description provided for @hint_text.
  ///
  /// In en, this message translates to:
  /// **'Enter your email here'**
  String get hint_text;

  /// No description provided for @labeltext.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labeltext;

  /// No description provided for @hintp_text.
  ///
  /// In en, this message translates to:
  /// **'Enter your password here'**
  String get hintp_text;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'sign in'**
  String get sign_in;

  /// No description provided for @or_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Or Sign in with'**
  String get or_sign_in;

  /// No description provided for @success_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in success'**
  String get success_sign_in;

  /// No description provided for @error_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Error signing in.'**
  String get error_sign_in;

  /// No description provided for @dont_account.
  ///
  /// In en, this message translates to:
  /// **'     Don\'t have an account?'**
  String get dont_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @sign_up_msg.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get sign_up_msg;

  /// No description provided for @hintun_text.
  ///
  /// In en, this message translates to:
  /// **'Enter your name here'**
  String get hintun_text;

  /// No description provided for @labeluntext.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get labeluntext;

  /// No description provided for @hintcp_text.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password here'**
  String get hintcp_text;

  /// No description provided for @labelcptext.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get labelcptext;

  /// No description provided for @or_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Or Sign up with'**
  String get or_sign_up;

  /// No description provided for @have_account.
  ///
  /// In en, this message translates to:
  /// **'     Already have an account?'**
  String get have_account;

  /// No description provided for @home_msg.
  ///
  /// In en, this message translates to:
  /// **'Choose your report'**
  String get home_msg;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @water_disaster.
  ///
  /// In en, this message translates to:
  /// **'Water Disasters'**
  String get water_disaster;

  /// No description provided for @fire_disaster.
  ///
  /// In en, this message translates to:
  /// **'Fire Disasters'**
  String get fire_disaster;

  /// No description provided for @infrastructure_disaster.
  ///
  /// In en, this message translates to:
  /// **'infrastructure Disasters'**
  String get infrastructure_disaster;

  /// No description provided for @car_accidents.
  ///
  /// In en, this message translates to:
  /// **'Cars Accidents '**
  String get car_accidents;

  /// No description provided for @new_category.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get new_category;

  /// No description provided for @my_profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get my_profile;

  /// No description provided for @homepage.
  ///
  /// In en, this message translates to:
  /// **'HomePage'**
  String get homepage;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency numbers'**
  String get emergency;

  /// No description provided for @hospitals.
  ///
  /// In en, this message translates to:
  /// **'Hospitals numbers'**
  String get hospitals;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @helps_faqs.
  ///
  /// In en, this message translates to:
  /// **'Helps & FAQs'**
  String get helps_faqs;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name:  '**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone: '**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City:   '**
  String get city;

  /// No description provided for @your_phone.
  ///
  /// In en, this message translates to:
  /// **'Your Phone Number'**
  String get your_phone;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @about_msg.
  ///
  /// In en, this message translates to:
  /// **' The app uses machine learning to analyze photos from a mobile device\'s camera for signs of disaster, such as smoke or flooding. It provides real-time alerts to users in affected areas to help them evacuate safely and quickly. The app\'s primary goal is to enable swift response and reduce the damage caused by disasters. It aims to bridge the gap between affected communities and the necessary resources, providing a comprehensive solution for disaster response and relief efforts. '**
  String get about_msg;

  /// No description provided for @emergencyy.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergencyy;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Numbers'**
  String get phone_number;

  /// No description provided for @police.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get police;

  /// No description provided for @traffic_police.
  ///
  /// In en, this message translates to:
  /// **'Traffic Police'**
  String get traffic_police;

  /// No description provided for @fire_department.
  ///
  /// In en, this message translates to:
  /// **'Fire Department'**
  String get fire_department;

  /// No description provided for @ambulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get ambulance;

  /// No description provided for @highway_emergency.
  ///
  /// In en, this message translates to:
  /// **'Highway Emergency'**
  String get highway_emergency;

  /// No description provided for @erc.
  ///
  /// In en, this message translates to:
  /// **'Egyptian Red Crescent'**
  String get erc;

  /// No description provided for @public_services.
  ///
  /// In en, this message translates to:
  /// **'Public Services'**
  String get public_services;

  /// No description provided for @electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get electricity;

  /// No description provided for @eeaa.
  ///
  /// In en, this message translates to:
  /// **'Egyptian Environmental Affairs Agency'**
  String get eeaa;

  /// No description provided for @naturalgas.
  ///
  /// In en, this message translates to:
  /// **'Natural Gas'**
  String get naturalgas;

  /// No description provided for @meteorological.
  ///
  /// In en, this message translates to:
  /// **'Meteorological Authority'**
  String get meteorological;

  /// No description provided for @ain_shams.
  ///
  /// In en, this message translates to:
  /// **'Ain Shams Specialized'**
  String get ain_shams;

  /// No description provided for @akf.
  ///
  /// In en, this message translates to:
  /// **'Abdel Kader Fahmy'**
  String get akf;

  /// No description provided for @slam.
  ///
  /// In en, this message translates to:
  /// **'Al Salam'**
  String get slam;

  /// No description provided for @hussein.
  ///
  /// In en, this message translates to:
  /// **'Al Hussein University'**
  String get hussein;

  /// No description provided for @badran.
  ///
  /// In en, this message translates to:
  /// **'Badran'**
  String get badran;

  /// No description provided for @dar_fouad.
  ///
  /// In en, this message translates to:
  /// **'Dar Al Fouad'**
  String get dar_fouad;

  /// No description provided for @dar_shefaa.
  ///
  /// In en, this message translates to:
  /// **'Dar Ai Shefaa'**
  String get dar_shefaa;

  /// No description provided for @elagouza.
  ///
  /// In en, this message translates to:
  /// **'El Agouza'**
  String get elagouza;

  /// No description provided for @eldemerdash.
  ///
  /// In en, this message translates to:
  /// **'Eldemerdash'**
  String get eldemerdash;

  /// No description provided for @heluopls.
  ///
  /// In en, this message translates to:
  /// **'Heliopolis'**
  String get heluopls;

  /// No description provided for @loc_city.
  ///
  /// In en, this message translates to:
  /// **'Macrm Ebaid , Nacer city .'**
  String get loc_city;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @q_one.
  ///
  /// In en, this message translates to:
  /// **'what is BL3\'ny ?'**
  String get q_one;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @upload_post.
  ///
  /// In en, this message translates to:
  /// **'Upload Post In Community'**
  String get upload_post;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address: '**
  String get address;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community '**
  String get community;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Facebook Share '**
  String get share;

  /// No description provided for @image_picker.
  ///
  /// In en, this message translates to:
  /// **'Image Picker'**
  String get image_picker;

  /// No description provided for @image_show.
  ///
  /// In en, this message translates to:
  /// **'Image should appear here'**
  String get image_show;

  /// No description provided for @capture_image.
  ///
  /// In en, this message translates to:
  /// **'Capture Image'**
  String get capture_image;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @new_post.
  ///
  /// In en, this message translates to:
  /// **'Create New Post'**
  String get new_post;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @labelptext.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelptext;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
