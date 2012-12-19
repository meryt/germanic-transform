package com.meryt.germanic.transform;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class CharacterTest {

    @Test
    public void testCharacterString()
    {
        String tsvString = "U003E	&gt;	>	ASC	Y	Y			$>$";
        Character ch = new Character(tsvString);

        assertEquals("U003E", ch.getUtf8Str());
        assertEquals("&gt;", ch.getEntityName());
        assertEquals(">", ch.getCharLiteral());
        assertEquals("ASC", ch.getCharacterClass());
        assertTrue(ch.isValidEntity());
        assertTrue(ch.isValidGermanic());
        assertEquals("", ch.getStrippedChar());
    }

    @Test(expected=IllegalArgumentException.class)
    public void testCharacterStringThrowsIllegalArgumentExceptionIfStringHasNotEnoughFields()
    {
        String tsvString = "U003E	&gt;	>	";
        Character ch = new Character(tsvString);
    }

    @Test
    public void getUtf8EncodedCanEncodeSingleAsciiChars()
    {
        String tsvString = "U003E\t&gt;\t>\tASC\tY\tY\t\t\t$>$";
        Character ch = new Character(tsvString);
        assertEquals(">", ch.getUtf8Encoded());
    }

    @Test
    public void getUtf8EncodedCanEncodeSingleISO88591Chars()
    {
        String tsvString = "U00D0\t&ETH;\tÐ\tISO\tY\tY\tTH\tD~\t\\ETH{}";
        Character ch = new Character(tsvString);
        assertEquals("Ð", ch.getUtf8Encoded());
    }

    @Test
    public void getUtf8EncodedCanEncodeSingleUnicodeChars()
    {
        String tsvString = "U01E2\t&AElig-long;\tUNI\tN\tY\tAE\tA+E:\t\\=\\AE\\relax{}";
        Character ch = new Character(tsvString);
        assertEquals("Ǣ", ch.getUtf8Encoded());
    }

    @Test
    public void getUtf8EncodedCanEncodeMultipleUnicodeChars()
    {
        String tsvString = "U006D+U0304\t&m-long;\tUNI\tN\tY\tm\tm:\t\\=m";
        Character ch = new Character(tsvString);
        assertEquals("m̄", ch.getUtf8Encoded());
    }

}
