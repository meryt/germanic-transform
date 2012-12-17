package com.meryt.germanic.transform;

import static org.junit.Assert.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.junit.Test;

public class CharacterDatabaseTest
{
	@Test
	public void testConstructionOfHashmapFromLines()
	{
		ArrayList<String> arr = new ArrayList<String>();
		arr.add("# This line is a comment and should be ignored");
		arr.add("");
		arr.add("U00E9	&eacute;	é	ISO	Y	Y	e	e'	\\'e");
		arr.add("U00F0	&eth;	ð	ISO	Y	Y	th	d~	\\eth{}");
		
		CharacterDatabase db = new CharacterDatabase(arr);
		
		HashMap<String,String> hm;
		try {
			hm = db.getSearchReplaceTokens();
		} catch (IOException e) {
			fail("Should not throw an exception if we supply the lines");
			return;
		}
		
		assertEquals(2, hm.size());
		assertEquals("U00E9", hm.get("&eacute;"));
		assertEquals("U00F0", hm.get("&eth;"));
		
	}
}
