import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ME configs
late final bool isProduction = dotenv.env['isProduction'] == 'true';

late final String? counterCanisterId = dotenv.env['counter'];

late final String? iiCanisterId = dotenv.env['ii'];
