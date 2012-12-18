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

}
