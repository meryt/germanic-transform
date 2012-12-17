package com.meryt.germanic.transform;

import org.apache.commons.cli.*;

/**
 * Hello world!
 *
 */
public class App 
{
	
    public static void main( String[] args )
    {
    	// create the command line parser
    	CommandLineParser parser = new PosixParser();
    	
    	Options options = new Options();
    	options.addOption("a", "all", false, "do all the things");
    	options.addOption("h", "help", false, "show help");

    	boolean helloToAll = false;
    	try {
    	    // parse the command line arguments
    	    CommandLine line = parser.parse(options, args);

    	    if (line.hasOption( "all" ) ) {
    	        helloToAll = true;
    	    }
    	    if (line.hasOption("help") || 0 == args.length) {
    	    	showHelp(options);
    	    	return;
    	    }
    	}
    	catch( ParseException exp ) {
    	    System.out.println( "Unexpected exception:" + exp.getMessage() );
    	}
    	
    	String msg = helloToAll ? "Hello to all!" : "Hello World!";
        System.out.println(msg);
    }
    
    private static void showHelp(Options options)
    {
    	HelpFormatter formatter = new HelpFormatter();
    	formatter.printHelp("transform", options );
    }
}
