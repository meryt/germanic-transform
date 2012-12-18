package com.meryt.germanic.transform;

import java.util.HashMap;
import java.util.Map;

/**
 * Hello world!
 *
 */
public class App
{
    private static HashMap<String,String> validCommands = new HashMap<String,String>();

    public static void main( String[] args )
    {
        validCommands.put("help", "display this message, or help <command> for help with a command");
        validCommands.put("character-mappings", "display the character mappings");

        if (0 == args.length) {
            showGlobalHelp();
            return;
        }

        String command = args[0];
        if (isValidCommand(command)) {
            String[] remainingArgs = new String[args.length - 1];
            System.arraycopy(args, 1, remainingArgs, 0, args.length - 1);
            if ("help".equals(command)) {
                if (0 == remainingArgs.length) {
                    showGlobalHelp();
                    return;
                }
                String requestedCommand = remainingArgs[0];
                if (!isValidCommand(requestedCommand)) {
                    System.err.println("Unrecognized command: " + requestedCommand);
                    showGlobalHelp();
                    return;
                }
                showCommandHelp(requestedCommand);
                return;
            }
            else if ("character-mappings".equals(command)) {
                CharacterDatabase.main(remainingArgs);
                return;
            }
        } else {
            showGlobalHelp();
            return;
        }

    }

    /**
     * Determine whether the string is a valid top-level command
     * @param command - a command, such as "help"
     * @return boolean
     */
    private static boolean isValidCommand(String command)
    {
        return validCommands.containsKey(command);
    }

    /**
     * Show help for a given command
     */
    private static void showCommandHelp(String command)
    {
        if (command.equals("character-mappings")) {
            CharacterDatabase.showHelp();
            return;
        }
        System.out.println("Requested help for " + command);
    }

    /**
     * Show help for the app
     */
    private static void showGlobalHelp()
    {
        System.out.println("usage: transform <command> <options>");
        System.out.println("  Valid commands are:");

        for (Map.Entry<String, String> entry : validCommands.entrySet()) {
            String command = entry.getKey();
            String description = entry.getValue();
            System.out.println("    " + command + " - " + description);
        }
    }

}
