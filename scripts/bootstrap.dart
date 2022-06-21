// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:process_run/shell.dart';

final Shell shell = Shell();

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Displays this help information.',
    )
    ..addFlag(
      'production',
      defaultsTo: false,
      help: 'Whether to use development environment.',
    )
    ..addOption(
      'deploy',
      abbr: 'd',
      defaultsTo: './canister',
      help: 'Would you like to deploy canister',
    )
    ..addOption(
      'ii',
      abbr: 'i',
      defaultsTo: 'rwlgt-iiaaa-aaaaa-aaaaa-cai',
      help: 'II canister',
    );
  final ArgResults argResult = argParser.parse(arguments);
  if (argResult['help'] as bool) {
    print(argParser.usage);
    return;
  }
  final String deployPath = argResult['deploy'] as String;

  final bool isProduction = argResult['production'] as bool;

  await deploy(isProduction);
  await writeEnv(argResult);
}

Future<void> deploy(bool isProduction) async {
  if (isProduction) {
    // production build script
  } else {
    await shell.run('sh ./scripts/canister.sh');
  }
}

Future<void> writeEnv(ArgResults argResult) async {
  final bool isProduction = argResult['production'] as bool;
  final String deployPath = argResult['deploy'] as String;
  final String iiCanister = argResult['ii'] as String;
  final File envFile = File('.env');
  final String dfxJson = await File('$deployPath/dfx.json').readAsString();
  final String canisterIdsJson =
      await File('$deployPath/.dfx/local/canister_ids.json').readAsString();

  final Map<String, dynamic> dfxJsonObject = _decodeAsJson(dfxJson);
  final Map<String, dynamic> canisterIdsJsonnObject =
      _decodeAsJson(canisterIdsJson);
  final Map<String, dynamic> canisterList =
      Map<String, dynamic>.from(dfxJsonObject["canisters"]);

  final List<String> canisterKeys = canisterList.keys.toList();

  final canisterIdList = List<Map<String, dynamic>>.empty(growable: true);
  for (var k in canisterKeys) {
    canisterIdsJsonnObject.entries.forEach((element) {
      if (element.key == k) {
        canisterIdList
            .add({k: (element.value as Map<String, dynamic>)["local"]});
      }
    });
  }

  final List<String> concats = canisterIdList.map((e) {
    return "${e.entries.first.key}=${e.entries.first.value}";
  }).toList();
  final str = concats.join("\n");
  final String finalContent = '''
isProduction=$isProduction
ii=$iiCanister
$str
''';

  envFile.writeAsString(finalContent);
}

Map<String, dynamic> _decodeAsJson(String value) {
  return jsonDecode(value) as Map<String, dynamic>;
}

Map<String, String> _decodeAsStringJson(String value) {
  final Map<String, dynamic> result = jsonDecode(value) as Map<String, dynamic>;
  return result.cast<String, String>();
}
