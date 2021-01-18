import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:google_fonts/google_fonts.dart';
import 'package:prozone_app/core/constants/colors_constant.dart';
import 'package:prozone_app/core/constants/route_names.dart';
import 'package:prozone_app/core/dependencies/injection_container.dart' as di;
import 'package:prozone_app/core/routes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDi();
  await DotEnv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProZone App',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF10911d,
          ColorConstant.COLOR_SCRATCH,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.ptSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: DEFAULT_PAGE,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}
