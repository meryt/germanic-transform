package com.meryt.germanic.transform;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

public class CharacterDatabase
{
    String filePath;

    /**
     * The lines from the text file
     */
    ArrayList<String> lines = new ArrayList<String>();

    /**
     * Map of entity => Unicode string
     */
    HashMap<String,String> tokens = null;

    /**
     * Construct with a path to a text file
     *
     * @param filePath
     */
    public CharacterDatabase(String filePath)
    {
        this.filePath = filePath;
    }

    /**
     * Construct with lines of text as read from the text file
     *
     * @param lines
     */
    public CharacterDatabase(ArrayList<String> lines)
    {
        this.lines = lines;
    }

    /**
     * Get a hashmap of find=>replace pairs.
     *
     * @return HashMap<String,String>
     * @throws IOException
     */
    public HashMap<String,String> getSearchReplaceTokens(boolean asUnicode)
        throws IOException
    {
        if (null != tokens) {
            return tokens;
        }

        tokens = new HashMap<String,String>();

        lines = getLines();

        for (String line : lines) {
            // Exclude blank lines and comments from the output
            if (0 < line.length() && !(line.startsWith("#"))) {
                // Will throw exception if the line doesn't look right...
                // TODO should we skip these maybe?
                Character character = new Character(line);
                tokens.put(character.getEntityName(),
                    (asUnicode
                        ? character.getUtf8Encoded()
                        : character.getUtf8Str()));
            }

        }

        return tokens;
    }

    /**
     * Get the lines.  Read from a file if they haven't been set.
     *
     * @return ArrayList<String>
     * @throws IOException
     */
    private ArrayList<String> getLines() throws IOException
    {
        if (0 < lines.size()) {
            return lines;
        }

        BufferedReader reader = getFileReader();
        String line;
        while (null != (line = reader.readLine()))   {
            lines.add(line);
        }

        return lines;
    }

    /**
     * Get the reader for the specified file.
     *
     * @return BufferedReader
     * @throws FileNotFoundException
     */
    private BufferedReader getFileReader() throws FileNotFoundException
    {
        FileInputStream fis = new FileInputStream(filePath);
        InputStreamReader isr;
        try {
            // Germanic lexicon files are specified to use ISO-8859-1 encoding
            isr = new InputStreamReader(fis, "ISO-8859-1");
        } catch (UnsupportedEncodingException e) {
            // Do our best.
            isr = new InputStreamReader(fis);
        }
        BufferedReader br = new BufferedReader(isr);
        return br;
    }

}
