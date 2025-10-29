import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vguru/pages/home/home_page.dart';
import 'package:vguru/pages/home/learn.dart';
import 'package:vguru/pages/home/practice.dart';
import 'package:vguru/pages/home/report.dart';
import 'package:vguru/pages/login/login_page_1.dart';
import 'package:vguru/pages/login/login_page_2.dart';
import 'package:vguru/pages/login/login_page_3.dart';
import 'package:vguru/pages/login/login_page_4.dart';
import 'package:vguru/pages/notes/notes_screen.dart';
import 'package:vguru/pages/onboarding/welcome_page.dart';
import 'package:vguru/pages/password/reset_password.dart';
import 'package:vguru/pages/profile/profile_page.dart';
import 'package:vguru/pages/provider/user_provider.dart';
import 'package:vguru/pages/quiz/quiz_screen.dart';
import 'package:vguru/pages/settings/settings_page.dart';
import 'package:vguru/pages/signup/signup_page_1.dart';
import 'package:vguru/pages/signup/signup_page_10.dart';
import 'package:vguru/pages/signup/signup_page_11.dart';
import 'package:vguru/pages/signup/signup_page_2.dart';
import 'package:vguru/pages/signup/signup_page_3.dart';
import 'package:vguru/pages/signup/signup_page_4.dart';
import 'package:vguru/pages/signup/signup_page_5.dart';
import 'package:vguru/pages/signup/signup_page_6.dart';
import 'package:vguru/pages/signup/signup_page_7.dart';
import 'package:vguru/pages/signup/signup_page_8.dart';
import 'package:vguru/pages/signup/signup_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/english/english_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/maths/maths_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/biology/biology_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/chemistry/chemistry_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/physics/physics_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/science/science.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/civics/civics_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/economics/economics_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/geography/geography_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_1.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_10.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_2.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_3.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_4.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_5.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_6.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_7.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_8.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/history/history_page_9.dart';
import 'package:vguru/pages/subjects/1st%20to%2010th/social/social.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/coloring/coloring_page_LKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/coloring/coloring_page_UKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/fun%20activities/fun_activities_page_LKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/fun%20activities/fun_activities_page_UKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/matching%20games/matching_games_page_LKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/matching%20games/matching_games_page_UKG%20.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/poems/poems_page_LKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/poems/poems_page_UKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/shapes/shapes_page_LKG.dart';
import 'package:vguru/pages/subjects/LKG%20and%20UKG/shapes/shapes_page_UKG.dart';
import 'package:vguru/pages/terms%20of%20service/help_page.dart';
import 'package:vguru/pages/terms%20of%20service/privacy_page.dart';
import 'package:vguru/pages/terms%20of%20service/terms_page.dart';
import 'package:vguru/pages/video/video_screen.dart';
import 'package:vguru/theme%20and%20sound/sound_manager.dart';
import 'package:vguru/theme%20and%20sound/theme.dart';
import 'package:vguru/theme%20and%20sound/theme_manager.dart';
import 'pages/password/forgot_password.dart';
import 'pages/splash screen/splash_screen.dart';
import 'pages/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeManager()),
        ChangeNotifierProvider(create: (context) => SoundManager()),

        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const VGuruApp(),
    ),
  );
}

class VGuruApp extends StatelessWidget {
  const VGuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {

        // onboarding and splash screens routes
        '/splash': (context) => const SplashScreenWrapper(),
        '/onboarding': (context) => const OnBoarding(),
        '/welcome': (context) => const WelcomePage(),

        // login routes
        '/login1': (context) => const LoginPage1(),
        '/login2': (context) => const LoginPage2(),
        '/login3': (context) => const LoginPage3(),
        '/login4': (context) => const LoginPage4(),

        // password routes
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/reset_password': (context) => const ResetPasswordPage(),

        // terms of service routes
        '/terms': (context) => const TermsPage(),
        '/privacy': (context) => const PrivacyPage(),
        '/help' : (context) => const HelpPage(),

        // signup routes
        '/signup1': (context) => const SignUp1(),
        '/signup2': (context) => const SignUp2(),
        '/signup3': (context) => const SignUp3(),
        '/signup4': (context) => const SignUp4(),
        '/signup5': (context) => const SignUp5(),
        '/signup6': (context) => const SignUp6(),
        '/signup7': (context) => const SignUp7(),
        '/signup8': (context) => const SignUp8(),
        '/signup9': (context) => const SignUp9(),
        '/signup10': (context) => const SignUp10(),
        '/signup11': (context) => const SignUp11(),

        // main app routes
        '/home': (context) => const HomePage(),
        '/learn': (context) => const Learn(),
        '/practice': (context) => const Practice(),
        '/report': (context) => const Report(),
        '/profile': (context) => const Profile(),
        '/settings': (context) => const SettingsPage(),


        // Subject Pages


        // LKG and UKG

        // Coloring
        '/coloringLKG': (context) => const ColoringPageLKG(),
        '/coloringUKG': (context) => const ColoringPageUKG(),

        // Fun Activities
        '/funLKG': (context) => const FunActivitiesPageLKG(),
        '/funUKG': (context) => const FunActivitiesPageUKG(),

        // Shapes
        '/shapesLKG': (context) => const ShapesPageLKG(),
        '/shapesUKG': (context) => const ShapesPageUKG(),

        // Matching Games
        '/matchingLKG': (context) => const MatchingGamesPageLKG(),
        '/matchingUKG': (context) => const MatchingGamesPageUKG(),

        // Poems
        '/poemsLKG': (context) => const PoemsPageLKG(),
        '/poemsUKG': (context) => const PoemsPageUKG(),


        // 1st to 10th

        //English
        '/english1st': (context) => const EnglishPage1(),
        '/english2nd': (context) => const EnglishPage2(),
        '/english3rd': (context) => const EnglishPage3(),
        '/english4th': (context) => const EnglishPage4(),
        '/english5th': (context) => const EnglishPage5(),
        '/english6th': (context) => const EnglishPage6(),
        '/english7th': (context) => const EnglishPage7(),
        '/english8th': (context) => const EnglishPage8(),
        '/english9th': (context) => const EnglishPage9(),
        '/english10th': (context) => const EnglishPage10(),

        //Maths
        '/maths1st': (context) => const MathsPage1(),
        '/maths2nd': (context) => const MathsPage2(),
        '/maths3rd': (context) => const MathsPage3(),
        '/maths4th': (context) => const MathsPage4(),
        '/maths5th': (context) => const MathsPage5(),
        '/maths6th': (context) => const MathsPage6(),
        '/maths7th': (context) => const MathsPage7(),
        '/maths8th': (context) => const MathsPage8(),
        '/maths9th': (context) => const MathsPage9(),
        '/maths10th': (context) => const MathsPage10(),


        //Science
        '/science': (context) => const SciencePage(),

        //Physics
        '/physics1st': (context) => const PhysicsPage1(),
        '/physics2nd': (context) => const PhysicsPage2(),
        '/physics3rd': (context) => const PhysicsPage3(),
        '/physics4th': (context) => const PhysicsPage4(),
        '/physics5th': (context) => const PhysicsPage5(),
        '/physics6th': (context) => const PhysicsPage6(),
        '/physics7th': (context) => const PhysicsPage7(),
        '/physics8th': (context) => const PhysicsPage8(),
        '/physics9th': (context) => const PhysicsPage9(),
        '/physics10th': (context) => const PhysicsPage10(),

        //Chemistry
        '/chemistry1st': (context) => const ChemistryPage1(),
        '/chemistry2nd': (context) => const ChemistryPage2(),
        '/chemistry3rd': (context) => const ChemistryPage3(),
        '/chemistry4th': (context) => const ChemistryPage4(),
        '/chemistry5th': (context) => const ChemistryPage5(),
        '/chemistry6th': (context) => const ChemistryPage6(),
        '/chemistry7th': (context) => const ChemistryPage7(),
        '/chemistry8th': (context) => const ChemistryPage8(),
        '/chemistry9th': (context) => const ChemistryPage9(),
        '/chemistry10th': (context) => const ChemistryPage10(),

        //Biology
        '/biology1st': (context) => const BiologyPage1(),
        '/biology2nd': (context) => const BiologyPage2(),
        '/biology3rd': (context) => const BiologyPage3(),
        '/biology4th': (context) => const BiologyPage4(),
        '/biology5th': (context) => const BiologyPage5(),
        '/biology6th': (context) => const BiologyPage6(),
        '/biology7th': (context) => const BiologyPage7(),
        '/biology8th': (context) => const BiologyPage8(),
        '/biology9th': (context) => const BiologyPage9(),
        '/biology10th': (context) => const BiologyPage10(),


        //Social Studies
        '/social': (context) => const SocialPage(),

        // History
        '/history1st': (context) => const HistoryPage1(),
        '/history2nd': (context) => const HistoryPage2(),
        '/history3rd': (context) => const HistoryPage3(),
        '/history4th': (context) => const HistoryPage4(),
        '/history5th': (context) => const HistoryPage5(),
        '/history6th': (context) => const HistoryPage6(),
        '/history7th': (context) => const HistoryPage7(),
        '/history8th': (context) => const HistoryPage8(),
        '/history9th': (context) => const HistoryPage9(),
        '/history10th': (context) => const HistoryPage10(),

        // Geography
        '/geography1st': (context) => const GeographyPage1(),
        '/geography2nd': (context) => const GeographyPage2(),
        '/geography3rd': (context) => const GeographyPage3(),
        '/geography4th': (context) => const GeographyPage4(),
        '/geography5th': (context) => const GeographyPage5(),
        '/geography6th': (context) => const GeographyPage6(),
        '/geography7th': (context) => const GeographyPage7(),
        '/geography8th': (context) => const GeographyPage8(),
        '/geography9th': (context) => const GeographyPage9(),
        '/geography10th': (context) => const GeographyPage10(),

        // Civics
        '/civics1st': (context) => const CivicsPage1(),
        '/civics2nd': (context) => const CivicsPage2(),
        '/civics3rd': (context) => const CivicsPage3(),
        '/civics4th': (context) => const CivicsPage4(),
        '/civics5th': (context) => const CivicsPage5(),
        '/civics6th': (context) => const CivicsPage6(),
        '/civics7th': (context) => const CivicsPage7(),
        '/civics8th': (context) => const CivicsPage8(),
        '/civics9th': (context) => const CivicsPage9(),
        '/civics10th': (context) => const CivicsPage10(),

        // Economics
        '/economics1st': (context) => const EconomicsPage1(),
        '/economics2nd': (context) => const EconomicsPage2(),
        '/economics3rd': (context) => const EconomicsPage3(),
        '/economics4th': (context) => const EconomicsPage4(),
        '/economics5th': (context) => const EconomicsPage5(),
        '/economics6th': (context) => const EconomicsPage6(),
        '/economics7th': (context) => const EconomicsPage7(),
        '/economics8th': (context) => const EconomicsPage8(),
        '/economics9th': (context) => const EconomicsPage9(),
        '/economics10th': (context) => const EconomicsPage10(),

        // Notes
        '/notes': (context) => const NotesScreen(),

        // Videos
        '/video': (context) => const VideoScreen(),

        // Quiz
        '/quiz': (context) => const QuizScreen(),

      },
      title: 'VGuru',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeManager.themeMode,
      home: const SplashScreenWrapper(),
    );
  }
}
