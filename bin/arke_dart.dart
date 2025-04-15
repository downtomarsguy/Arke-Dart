import "dart:io";
import "package:nyxx/nyxx.dart";
import "package:dotenv/dotenv.dart";
import "package:nyxx_commands/nyxx_commands.dart";

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  var token = env["API_KEY"]!;
  var guild_id = env["GUILD_ID"]!;

  CommandsPlugin commands = CommandsPlugin(
    prefix: (message) => "!",
    guild: Snowflake.parse(guild_id),
    options: CommandsOptions(logErrors: true),
  );

  final client = await Nyxx.connectGateway(
    token,
    GatewayIntents.allUnprivileged | GatewayIntents.guildMembers,
    options: GatewayClientOptions(
      plugins: [commands, logging, cliIntegration, ignoreExceptions],
    ),
  );

  stdout.writeln("🟢 Bot Booted Online");

  ChatCommand pinger = ChatCommand(
    "pinger",
    "Checks if the bot is online",
    id("pinger", (ChatContext context) {
      context.respond(MessageBuilder(content: "sup nerds"));
    }),
  );

  commands.addCommand(pinger);
}
