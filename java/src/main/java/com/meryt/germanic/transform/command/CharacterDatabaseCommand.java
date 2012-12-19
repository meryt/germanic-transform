package com.meryt.germanic.transform.command;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.PosixParser;

import com.meryt.germanic.transform.CharacterDatabase;

public class CharacterDatabaseCommand
{
    /**
     * Do something with the character database, depending on the args.
     * @param args
     */
    public static void main(String[] args)
    {
        // create the command line parser
        CommandLineParser parser = new PosixParser();

        Options options = getOptions();

        String filePath = null;
        try {
            // parse the command line arguments
            CommandLine commandline = parser.parse(options, args);
            filePath = commandline.getOptionValue("file");
            if (null == filePath || filePath.isEmpty()) {
                showHelp();
                System.exit(1);
            }
        }
        catch( ParseException exp ) {
            System.err.println("Unexpected exception:" + exp.getMessage());
            System.exit(1);
        }

        CharacterDatabase chardb = new CharacterDatabase(filePath);
        try {
            HashMap<String, String> mappings = chardb.getSearchReplaceTokens();
            displayMappings(mappings);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }

    }

    private static void displayMappings(HashMap<String,String> mappings)
    {
        for (Map.Entry<String, String> entry : mappings.entrySet()) {
            String entity = entry.getKey();
            String utf8Encoding = entry.getValue();
            System.out.println(entity + "\t" + utf8Encoding);
        }
    }

    private static Options getOptions()
    {
        Options options = new Options();
        options.addOption("f", "file", true,
                "path to the file containing character mappings (hint: character_database.txt");
        return options;
    }

    public static void showHelp()
    {
        HelpFormatter formatter = new HelpFormatter();
        formatter.printHelp("transform character-mappings", getOptions());
    }

}
