import 'dart:io';
import 'package:nyxx/nyxx.dart';
import 'package:dotenv/dotenv.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  var token = env['API_KEY']!;

  final client = await Nyxx.connectGateway(
    token,
    GatewayIntents.allUnprivileged,
  );

  stdout.writeln("🟢 Bot Booted Online");
}
