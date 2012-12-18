package com.meryt.germanic.transform;

/**
 * A single entry from the character database. Fields of no interest to us
 * are not retained.
 */
public class Character
{
    /**
     * The Unicode definition, in a form like "U0022" or "U0065+U0307+U0303".
     * Will be "-" if no Unicode encoding exists.
     */
    private String utf8Str;

    /**
     * The HTML/XML entity name, if one exists, else an entity name fabricated
     * for use in this project
     */
    private String entityName;

    /**
     * The character itself, if it exists in ISO-8859-1, otherwise blank.
     */
    private String charLiteral;

    /**
     * The class of the character:
     *   - ASC if it is in ASCII
     *   - ISO if it is in ISO-8859-1 but not ASCII
     *   - UNI if it is in Unicode but not ISO-8859-1
     *   - SCJ if it is not in Unicode
     */
    private String characterClass;

    /**
     * True if the entityName is a valid entity, false if it was invented for
     * our purposes.
     */
    private boolean isValidEntity;

    /**
     * False if it's a character or entry we would never expect to see in a
     * Germanic lexicon (e.g. Japanese yen symbol)
     */
    private boolean isValidGermanic;

    /**
     * The character with diacritics removed, so only ASCII characters remain.
     * Some characters may be represented with multiple characters here:
     * e.g. thorn is "th".
     */
    private String strippedChar;

    /**
     * Construct a character from values for its members
     *
     * @param utf8Str
     * @param entityName
     * @param charLiteral
     * @param characterClass
     * @param isValidEntity
     * @param isValidGermanic
     * @param strippedChar
     */
    public Character(
            String utf8Str,
            String entityName,
            String charLiteral,
            String characterClass,
            boolean isValidEntity,
            boolean isValidGermanic,
            String strippedChar)
    {
        this.utf8Str = utf8Str;
        this.entityName = entityName;
        this.charLiteral = charLiteral;
        this.characterClass = characterClass;
        this.isValidEntity = isValidEntity;
        this.isValidGermanic = isValidGermanic;
        this.strippedChar = strippedChar;
    }

    /**
     * Construct a character from a string out of the tab-delimited data
     * file.
     * @param tsvString a line from the character database text file
     */
    public Character (String tsvString)
    {
        // Use -1 to get all columns, even if latter columns are empty
        String[] parts = tsvString.split("\\t", -1);
        if (7 > parts.length) {
            throw new IllegalArgumentException(
                "The TSV string \"" + tsvString +
                "\" did not have enough components to build a charater entry");
        }

        utf8Str = parts[0];
        entityName = parts[1];
        charLiteral = parts[2];
        characterClass = parts[3];
        isValidEntity = ("Y".equals(parts[4]));
        isValidGermanic = ("Y".equals(parts[5]));
        strippedChar = parts[6];
    }

    public String getCharacterClass() {
        return characterClass;
    }

    public void setCharacterClass(String characterClass) {
        this.characterClass = characterClass;
    }

    public String getUtf8Str() {
        return utf8Str;
    }

    public void setUtf8Str(String utf8Str) {
        this.utf8Str = utf8Str;
    }

    public String getEntityName() {
        return entityName;
    }

    public void setEntityName(String entityName) {
        this.entityName = entityName;
    }

    public String getCharLiteral() {
        return charLiteral;
    }

    public void setCharLiteral(String charLiteral) {
        this.charLiteral = charLiteral;
    }

    public boolean isValidEntity() {
        return isValidEntity;
    }

    public void setValidEntity(boolean isValidEntity) {
        this.isValidEntity = isValidEntity;
    }

    public boolean isValidGermanic() {
        return isValidGermanic;
    }

    public void setValidGermanic(boolean isValidGermanic) {
        this.isValidGermanic = isValidGermanic;
    }

    public String getStrippedChar() {
        return strippedChar;
    }

    public void setStrippedChar(String strippedChar) {
        this.strippedChar = strippedChar;
    }

}
