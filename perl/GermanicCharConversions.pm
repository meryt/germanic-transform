package GermanicCharConversions; sub to_utf8 {
$line = shift;
$line =~ s/&quot;/\x{0022}/g;
$line =~ s/&amp;/\x{0026}/g;
$line =~ s/&lt;/\x{003C}/g;
$line =~ s/&gt;/\x{003E}/g;
$line =~ s/&tilde;/\x{007E}/g;
$line =~ s/&nbsp;/\x{00A0}/g;
$line =~ s/&iexcl;/\x{00A1}/g;
$line =~ s/&cent;/\x{00A2}/g;
$line =~ s/&pound;/\x{00A3}/g;
$line =~ s/&curren;/\x{00A4}/g;
$line =~ s/&yen;/\x{00A5}/g;
$line =~ s/&brvbar;/\x{00A6}/g;
$line =~ s/&sect;/\x{00A7}/g;
$line =~ s/&uml;/\x{00A8}/g;
$line =~ s/&copy;/\x{00A9}/g;
$line =~ s/&ordf;/\x{00AA}/g;
$line =~ s/&laquo;/\x{00AB}/g;
$line =~ s/&not;/\x{00AC}/g;
$line =~ s/&shy;/\x{00AD}/g;
$line =~ s/&reg;/\x{00AE}/g;
$line =~ s/&macr;/\x{00AF}/g;
$line =~ s/&deg;/\x{00B0}/g;
$line =~ s/&plusmn;/\x{00B1}/g;
$line =~ s/&sup2;/\x{00B2}/g;
$line =~ s/&sup3;/\x{00B3}/g;
$line =~ s/&acute;/\x{00B4}/g;
$line =~ s/&micro;/\x{00B5}/g;
$line =~ s/&para;/\x{00B6}/g;
$line =~ s/&middot;/\x{00B7}/g;
$line =~ s/&cedil;/\x{00B8}/g;
$line =~ s/&sup1;/\x{00B9}/g;
$line =~ s/&ordm;/\x{00BA}/g;
$line =~ s/&raquo;/\x{00BB}/g;
$line =~ s/&frac14;/\x{00BC}/g;
$line =~ s/&frac12;/\x{00BD}/g;
$line =~ s/&frac34;/\x{00BE}/g;
$line =~ s/&iquest;/\x{00BF}/g;
$line =~ s/&Agrave;/\x{00C0}/g;
$line =~ s/&Aacute;/\x{00C1}/g;
$line =~ s/&Acirc;/\x{00C2}/g;
$line =~ s/&Atilde;/\x{00C3}/g;
$line =~ s/&Auml;/\x{00C4}/g;
$line =~ s/&Aring;/\x{00C5}/g;
$line =~ s/&AElig;/\x{00C6}/g;
$line =~ s/&Ccedil;/\x{00C7}/g;
$line =~ s/&Egrave;/\x{00C8}/g;
$line =~ s/&Eacute;/\x{00C9}/g;
$line =~ s/&Ecirc;/\x{00CA}/g;
$line =~ s/&Euml;/\x{00CB}/g;
$line =~ s/&Igrave;/\x{00CC}/g;
$line =~ s/&Iacute;/\x{00CD}/g;
$line =~ s/&Icirc;/\x{00CE}/g;
$line =~ s/&Iuml;/\x{00CF}/g;
$line =~ s/&ETH;/\x{00D0}/g;
$line =~ s/&Ntilde;/\x{00D1}/g;
$line =~ s/&Ograve;/\x{00D2}/g;
$line =~ s/&Oacute;/\x{00D3}/g;
$line =~ s/&Ocirc;/\x{00D4}/g;
$line =~ s/&Otilde;/\x{00D5}/g;
$line =~ s/&Ouml;/\x{00D6}/g;
$line =~ s/&times;/\x{00D7}/g;
$line =~ s/&Oslash;/\x{00D8}/g;
$line =~ s/&Ugrave;/\x{00D9}/g;
$line =~ s/&Uacute;/\x{00DA}/g;
$line =~ s/&Ucirc;/\x{00DB}/g;
$line =~ s/&Uuml;/\x{00DC}/g;
$line =~ s/&Yacute;/\x{00DD}/g;
$line =~ s/&THORN;/\x{00DE}/g;
$line =~ s/&szlig;/\x{00DF}/g;
$line =~ s/&agrave;/\x{00E0}/g;
$line =~ s/&aacute;/\x{00E1}/g;
$line =~ s/&acirc;/\x{00E2}/g;
$line =~ s/&atilde;/\x{00E3}/g;
$line =~ s/&auml;/\x{00E4}/g;
$line =~ s/&aring;/\x{00E5}/g;
$line =~ s/&aelig;/\x{00E6}/g;
$line =~ s/&ccedil;/\x{00E7}/g;
$line =~ s/&egrave;/\x{00E8}/g;
$line =~ s/&eacute;/\x{00E9}/g;
$line =~ s/&ecirc;/\x{00EA}/g;
$line =~ s/&euml;/\x{00EB}/g;
$line =~ s/&igrave;/\x{00EC}/g;
$line =~ s/&iacute;/\x{00ED}/g;
$line =~ s/&icirc;/\x{00EE}/g;
$line =~ s/&iuml;/\x{00EF}/g;
$line =~ s/&eth;/\x{00F0}/g;
$line =~ s/&ntilde;/\x{00F1}/g;
$line =~ s/&ograve;/\x{00F2}/g;
$line =~ s/&oacute;/\x{00F3}/g;
$line =~ s/&ocirc;/\x{00F4}/g;
$line =~ s/&otilde;/\x{00F5}/g;
$line =~ s/&ouml;/\x{00F6}/g;
$line =~ s/&divide;/\x{00F7}/g;
$line =~ s/&oslash;/\x{00F8}/g;
$line =~ s/&ugrave;/\x{00F9}/g;
$line =~ s/&uacute;/\x{00FA}/g;
$line =~ s/&ucirc;/\x{00FB}/g;
$line =~ s/&uuml;/\x{00FC}/g;
$line =~ s/&yacute;/\x{00FD}/g;
$line =~ s/&thorn;/\x{00FE}/g;
$line =~ s/&yuml;/\x{00FF}/g;
$line =~ s/&a-acute-hook;/\x{0061}\x{0301}\x{0328}/g;
$line =~ s/&a-long-acute;/\x{0061}\x{0304}\x{0301}/g;
$line =~ s/&a-long-short;/\x{0061}\x{0304}\x{0306}/g;
$line =~ s/&a-odot-acute;/\x{0061}\x{0307}\x{0301}/g;
$line =~ s/&a-uml-circ;/\x{0061}\x{0308}\x{0302}/g;
$line =~ s/&a-ohook;/\x{0061}\x{0313}/g;
$line =~ s/&b-tilde;/\x{0062}\x{0303}/g;
$line =~ s/&c-hachek-udot;/\x{0063}\x{030C}\x{0323}/g;
$line =~ s/&c-tilde;/\x{0063}\x{0303}/g;
$line =~ s/&c-udot;/\x{0063}\x{0323}/g;
$line =~ s/&e-acute-hook;/\x{0065}\x{0301}\x{0328}/g;
$line =~ s/&e-circ-acute;/\x{0065}\x{0302}\x{0301}/g;
$line =~ s/&e-tilde-hook;/\x{0065}\x{0303}\x{0328}/g;
$line =~ s/&e-long-short;/\x{0065}\x{0304}\x{0306}/g;
$line =~ s/&e-long-hook;/\x{0065}\x{0304}\x{0328}/g;
$line =~ s/&e-odot-acute;/\x{0065}\x{0307}\x{0301}/g;
$line =~ s/&e-odot-tilde;/\x{0065}\x{0307}\x{0303}/g;
$line =~ s/&e-uml-acute;/\x{0065}\x{0308}\x{0301}/g;
$line =~ s/&e-uml-tilde;/\x{0065}\x{0308}\x{0303}/g;
$line =~ s/&e-ohook;/\x{0065}\x{0313}/g;
$line =~ s/&g-long;/\x{0067}\x{0304}/g;
$line =~ s/&g-ocomma;/\x{0067}\x{0315}/g;
$line =~ s/&g-tilde;/\x{0067}\x{0303}/g;
$line =~ s/&h-tilde;/\x{0068}\x{0303}/g;
$line =~ s/&i-circ-acute;/\x{0069}\x{0302}\x{0301}/g;
$line =~ s/&i-tilde-hook;/\x{0069}\x{0303}\x{0328}/g;
$line =~ s/&i-long-acute;/\x{0069}\x{0304}\x{0301}/g;
$line =~ s/&i-long-short;/\x{0069}\x{0304}\x{0306}/g;
$line =~ s/&i-oring;/\x{0069}\x{030A}/g;
$line =~ s/&i-oring-acute;/\x{0069}\x{030A}\x{0301}/g;
$line =~ s/&i-oring-tilde;/\x{0069}\x{030A}\x{0303}/g;
$line =~ s/&i-nonsyllabic;/\x{0069}\x{032F}/g;
$line =~ s/&k-circ;/\x{006B}\x{0302}/g;
$line =~ s/&k-ocomma;/\x{006B}\x{0315}/g;
$line =~ s/&l-tilde;/\x{006C}\x{0303}/g;
$line =~ s/&l-ocomma;/\x{006C}\x{0315}/g;
$line =~ s/&l-uring;/\x{006C}\x{0325}/g;
$line =~ s/&m-tilde;/\x{006D}\x{0303}/g;
$line =~ s/&m-long;/\x{006E}\x{0304}/g;
$line =~ s/&m-uring;/\x{006D}\x{0325}/g;
$line =~ s/&n-tilde;/\x{006E}\x{0303}/g;
$line =~ s/&n-long;/\x{006E}\x{0304}/g;
$line =~ s/&n-ocomma;/\x{006E}\x{0315}/g;
$line =~ s/&n-uring;/\x{006E}\x{0325}/g;
$line =~ s/&o-acute-hook;/\x{006F}\x{0301}\x{0328}/g;
$line =~ s/&o-circ-acute;/\x{006F}\x{0302}\x{0301}/g;
$line =~ s/&o-circ-hook;/\x{006F}\x{0302}\x{0328}/g;
$line =~ s/&o-long-acute;/\x{006F}\x{0304}\x{0301}/g;
$line =~ s/&o-long-short;/\x{006F}\x{0304}\x{0306}/g;
$line =~ s/&o-uml-circ;/\x{006F}\x{0308}\x{0302}/g;
$line =~ s/&p-tilde;/\x{0070}\x{0303}/g;
$line =~ s/&q-bar;/\x{0071}\x{0336}/g;
$line =~ s/&r-acute-udot;/\x{0072}\x{0301}\x{0323}/g;
$line =~ s/&r-tilde;/\x{0072}\x{0303}/g;
$line =~ s/&r-long;/\x{0072}\x{0304}/g;
$line =~ s/&r-uring;/\x{0072}\x{0325}/g;
$line =~ s/&s-tilde;/\x{0073}\x{0303}/g;
$line =~ s/&s-ocomma;/\x{0073}\x{0315}/g;
$line =~ s/&t-ocomma;/\x{0074}\x{0315}/g;
$line =~ s/&u-circ-acute;/\x{0075}\x{0302}\x{0301}/g;
$line =~ s/&u-long-acute;/\x{0075}\x{0304}\x{0301}/g;
$line =~ s/&u-long-short;/\x{0075}\x{0304}\x{0306}/g;
$line =~ s/&u-odot;/\x{0075}\x{0307}/g;
$line =~ s/&u-uml-circ;/\x{0075}\x{0308}\x{0302}/g;
$line =~ s/&u-oring-acute;/\x{0075}\x{030A}\x{0301}/g;
$line =~ s/&u-oring-tilde;/\x{0075}\x{030A}\x{0303}/g;
$line =~ s/&u-nonsyllabic;/\x{0075}\x{032F}/g;
$line =~ s/&v-long;/\x{0076}\x{0304}/g;
$line =~ s/&y-short;/\x{0079}\x{0306}/g;
$line =~ s/&z-odot;/\x{007A}\x{0307}/g;
$line =~ s/&O-slash-long;/\x{00D8}\x{0304}/g;
$line =~ s/&a-tilde;/\x{00E3}/g;
$line =~ s/&aelig-circ;/\x{00E6}\x{0302}/g;
$line =~ s/&o-slash-long;/\x{00F8}\x{0304}/g;
$line =~ s/&A-long;/\x{0100}/g;
$line =~ s/&a-long;/\x{0101}/g;
$line =~ s/&A-short;/\x{0102}/g;
$line =~ s/&a-short;/\x{0103}/g;
$line =~ s/&a-hook;/\x{0105}/g;
$line =~ s/&c-acute;/\x{0107}/g;
$line =~ s/&c-hachek;/\x{010D}/g;
$line =~ s/&d-bar;/\x{0111}/g;
$line =~ s/&E-long;/\x{0112}/g;
$line =~ s/&e-long;/\x{0113}/g;
$line =~ s/&e-short;/\x{0115}/g;
$line =~ s/&e-odot;/\x{0117}/g;
$line =~ s/&E-hook;/\x{0118}/g;
$line =~ s/&e-hook;/\x{0119}/g;
$line =~ s/&e-hachek;/\x{011B}/g;
$line =~ s/&g-circ;/\x{011D}/g;
$line =~ s/&i-tilde;/\x{0129}/g;
$line =~ s/&I-long;/\x{012A}/g;
$line =~ s/&i-long;/\x{012B}/g;
$line =~ s/&i-short;/\x{012D}/g;
$line =~ s/&i-hook;/\x{012F}/g;
$line =~ s/&k-cedil;/\x{0137}/g;
$line =~ s/&l-bar;/\x{0142}/g;
$line =~ s/&n-acute;/\x{0144}/g;
$line =~ s/&O-long;/\x{014C}/g;
$line =~ s/&o-long;/\x{014D}/g;
$line =~ s/&O-short;/\x{014E}/g;
$line =~ s/&o-short;/\x{014F}/g;
$line =~ s/&OElig;/\x{0152}/g;
$line =~ s/&oelig;/\x{0153}/g;
$line =~ s/&OElig-acute;/\x{0152}\x{0301}/g;
$line =~ s/&oelig-acute;/\x{0153}\x{0301}/g;
$line =~ s/&oelig-circ;/\x{0153}\x{0302}/g;
$line =~ s/&r-hachek;/\x{0159}/g;
$line =~ s/&s-acute;/\x{015B}/g;
$line =~ s/&s-hachek;/\x{0161}/g;
$line =~ s/&u-tilde;/\x{0169}/g;
$line =~ s/&U-long;/\x{016A}/g;
$line =~ s/&u-long;/\x{016B}/g;
$line =~ s/&u-short;/\x{016D}/g;
$line =~ s/&u-oring;/\x{016F}/g;
$line =~ s/&w-circ;/\x{0175}/g;
$line =~ s/&y-circ;/\x{0177}/g;
$line =~ s/&z-hachek;/\x{017E}/g;
$line =~ s/&s-tall;/\x{017F}/g;
$line =~ s/&b-bar;/\x{0180}/g;
$line =~ s/&hw;/\x{0195}/g;
$line =~ s/&wynn;/\x{01BF}/g;
$line =~ s/&a-hachek;/\x{01CE}/g;
$line =~ s/&u-hachek;/\x{01D4}/g;
$line =~ s/&AElig-long;/\x{01E2}/g;
$line =~ s/&aelig-long;/\x{01E3}/g;
$line =~ s/&O-hook;/\x{01EA}/g;
$line =~ s/&o-hook;/\x{01EB}/g;
$line =~ s/&j-hachek;/\x{01F0}/g;
$line =~ s/&g-acute;/\x{01F5}/g;
$line =~ s/&AElig-acute;/\x{01FC}/g;
$line =~ s/&aelig-acute;/\x{01FD}/g;
$line =~ s/&YOGH;/\x{021C}/g;
$line =~ s/&yogh;/\x{021D}/g;
$line =~ s/&z-tail;/\x{0225}/g;
$line =~ s/&a-odot;/\x{0227}/g;
$line =~ s/&Y-long;/\x{0232}/g;
$line =~ s/&y-long;/\x{0233}/g;
$line =~ s/&schwa;/\x{0259}/g;
$line =~ s/&r-runic;/\x{0280}/g;
$line =~ s/&Alpha;/\x{0391}/g;
$line =~ s/&Beta;/\x{0392}/g;
$line =~ s/&Gamma;/\x{0393}/g;
$line =~ s/&Delta;/\x{0394}/g;
$line =~ s/&Epsilon;/\x{0395}/g;
$line =~ s/&Zeta;/\x{0396}/g;
$line =~ s/&Eta;/\x{0397}/g;
$line =~ s/&Theta;/\x{0398}/g;
$line =~ s/&Iota;/\x{0399}/g;
$line =~ s/&Kappa;/\x{039A}/g;
$line =~ s/&Lambda;/\x{039B}/g;
$line =~ s/&Mu;/\x{039C}/g;
$line =~ s/&Nu;/\x{039D}/g;
$line =~ s/&Xi;/\x{039E}/g;
$line =~ s/&Omicron;/\x{039F}/g;
$line =~ s/&Pi;/\x{03A0}/g;
$line =~ s/&Rho;/\x{03A1}/g;
$line =~ s/&Sigma;/\x{03A3}/g;
$line =~ s/&Tau;/\x{03A4}/g;
$line =~ s/&Upsilon;/\x{03A5}/g;
$line =~ s/&Phi;/\x{03A6}/g;
$line =~ s/&Chi;/\x{03A7}/g;
$line =~ s/&Psi;/\x{03A8}/g;
$line =~ s/&Omega;/\x{03A9}/g;
$line =~ s/&alpha;/\x{03B1}/g;
$line =~ s/&beta;/\x{03B2}/g;
$line =~ s/&gamma;/\x{03B3}/g;
$line =~ s/&delta;/\x{03B4}/g;
$line =~ s/&epsilon;/\x{03B5}/g;
$line =~ s/&epsilon-long;/\x{03B5}\x{0304}/g;
$line =~ s/&zeta;/\x{03B6}/g;
$line =~ s/&eta;/\x{03B7}/g;
$line =~ s/&theta;/\x{03B8}/g;
$line =~ s/&iota;/\x{03B9}/g;
$line =~ s/&kappa;/\x{03BA}/g;
$line =~ s/&lambda;/\x{03BB}/g;
$line =~ s/&mu;/\x{03BC}/g;
$line =~ s/&nu;/\x{03BD}/g;
$line =~ s/&xi;/\x{03BE}/g;
$line =~ s/&omicron;/\x{03BF}/g;
$line =~ s/&pi;/\x{03C0}/g;
$line =~ s/&rho;/\x{03C1}/g;
$line =~ s/&sigmaf;/\x{03C2}/g;
$line =~ s/&sigma;/\x{03C3}/g;
$line =~ s/&tau;/\x{03C4}/g;
$line =~ s/&upsilon;/\x{03C5}/g;
$line =~ s/&phi;/\x{03C6}/g;
$line =~ s/&chi;/\x{03C7}/g;
$line =~ s/&psi;/\x{03C8}/g;
$line =~ s/&omega;/\x{03C9}/g;
$line =~ s/&iota-diar;/\x{03CA}/g;
$line =~ s/&left-half-ring;/\x{0559}/g;
$line =~ s/&d-udot;/\x{1E0D}/g;
$line =~ s/&h-udot;/\x{1E25}/g;
$line =~ s/&l-udot;/\x{1E37}/g;
$line =~ s/&m-odot;/\x{1E41}/g;
$line =~ s/&m-udot;/\x{1E43}/g;
$line =~ s/&n-odot;/\x{1E45}/g;
$line =~ s/&n-udot;/\x{1E47}/g;
$line =~ s/&r-odot;/\x{1E59}/g;
$line =~ s/&r-udot;/\x{1E5B}/g;
$line =~ s/&s-udot;/\x{1E63}/g;
$line =~ s/&t-udot;/\x{1E6D}/g;
$line =~ s/&v-udot;/\x{1E7F}/g;
$line =~ s/&a-udot;/\x{1EA1}/g;
$line =~ s/&a-circ-acute;/\x{1EA5}/g;
$line =~ s/&e-udot;/\x{1EB9}/g;
$line =~ s/&e-tilde;/\x{1EBD}/g;
$line =~ s/&y-tilde;/\x{1EF9}/g;
$line =~ s/&alpha-psili;/\x{1F00}/g;
$line =~ s/&alpha-dasia;/\x{1F01}/g;
$line =~ s/&alpha-dasia-oxia;/\x{1F04}/g;
$line =~ s/&alpha-psili-oxia;/\x{1F04}/g;
$line =~ s/&Alpha-psili;/\x{1F08}/g;
$line =~ s/&Alpha-dasia;/\x{1F09}/g;
$line =~ s/&epsilon-psili;/\x{1F10}/g;
$line =~ s/&epsilon-dasia;/\x{1F11}/g;
$line =~ s/&epsilon-psili-oxia;/\x{1F14}/g;
$line =~ s/&epsilon-dasia-oxia;/\x{1F15}/g;
$line =~ s/&eta-psili;/\x{1F20}/g;
$line =~ s/&eta-psili-oxia;/\x{1F24}/g;
$line =~ s/&eta-dasia-oxia;/\x{1F25}/g;
$line =~ s/&eta-psili-peri;/\x{1F26}/g;
$line =~ s/&eta-dasia-peri;/\x{1F27}/g;
$line =~ s/&iota-dasia;/\x{1F31}/g;
$line =~ s/&iota-psili-oxia;/\x{1F34}/g;
$line =~ s/&iota-dasia-oxia;/\x{1F35}/g;
$line =~ s/&iota-psili-peri;/\x{1F36}/g;
$line =~ s/&iota-dasia-peri;/\x{1F37}/g;
$line =~ s/&omicron-psili;/\x{1F40}/g;
$line =~ s/&omicron-psili-peri;/\x{1F40}\x{0342}/g;
$line =~ s/&omicron-dasia;/\x{1F41}/g;
$line =~ s/&omicron-psili-oxia;/\x{1F44}/g;
$line =~ s/&omicron-dasia-oxia;/\x{1F45}/g;
$line =~ s/&upsilon-psili;/\x{1F50}/g;
$line =~ s/&upsilon-dasia;/\x{1F51}/g;
$line =~ s/&upsilon-psili-oxia;/\x{1F54}/g;
$line =~ s/&upsilon-dasia-oxia;/\x{1F55}/g;
$line =~ s/&upsilon-psili-peri;/\x{1F56}/g;
$line =~ s/&omega-psili;/\x{1F60}/g;
$line =~ s/&omega-psili-ypo;/\x{1F60}\x{0345}/g;
$line =~ s/&omega-psili-oxia;/\x{1F64}/g;
$line =~ s/&omega-dasia-oxia;/\x{1F65}/g;
$line =~ s/&omega-psili-peri;/\x{1F66}/g;
$line =~ s/&omega-dasia-peri;/\x{1F67}/g;
$line =~ s/&alpha-oxia;/\x{1F71}/g;
$line =~ s/&epsilon-oxia;/\x{1F73}/g;
$line =~ s/&eta-dasia;/\x{1F74}/g;
$line =~ s/&eta-oxia;/\x{1F75}/g;
$line =~ s/&iota-oxia;/\x{1F77}/g;
$line =~ s/&omicron-varia;/\x{1F78}/g;
$line =~ s/&omicron-oxia;/\x{1F79}/g;
$line =~ s/&upsilon-oxia;/\x{1F7B}/g;
$line =~ s/&omega-oxia;/\x{1F7D}/g;
$line =~ s/&alpha-long;/\x{1FB1}/g;
$line =~ s/&alpha-long-oxia;/\x{1FB1}\x{0301}/g;
$line =~ s/&alpha-long-psili-oxia;/\x{1FB1}\x{0313}\x{0301}/g;
$line =~ s/&alpha-peri;/\x{1FB6}/g;
$line =~ s/&eta-ypo;/\x{1FC3}/g;
$line =~ s/&eta-peri;/\x{1FC6}/g;
$line =~ s/&iota-long;/\x{1FD1}/g;
$line =~ s/&iota-long-oxia;/\x{1FD1}\x{0301}/g;
$line =~ s/&iota-long-psili;/\x{1FD1}\x{0313}/g;
$line =~ s/&iota-diar-oxia;/\x{1FD3}/g;
$line =~ s/&iota-peri;/\x{1FD6}/g;
$line =~ s/&iota-psili;/\x{1FD6}/g;
$line =~ s/&upsilon-long;/\x{1FE1}/g;
$line =~ s/&upsilon-long-oxia;/\x{1FE1}\x{0301}/g;
$line =~ s/&upsilon-long-dasia;/\x{1FE1}\x{0314}/g;
$line =~ s/&upsilon-diar-oxia;/\x{1FE3}/g;
$line =~ s/&rho-dasia;/\x{1FE5}/g;
$line =~ s/&upsilon-peri;/\x{1FE6}/g;
$line =~ s/&omega-ypo;/\x{1FF3}/g;
$line =~ s/&omega-peri;/\x{1FF6}/g;
$line =~ s/&omega-peri-ypo;/\x{1FF7}/g;
$line =~ s/&ndash;/\x{2013}/g;
$line =~ s/&mdash;/\x{2014}/g;
$line =~ s/&dash-acute;/\x{2014}\x{0301}/g;
$line =~ s/&highquote;/\x{2018}/g;
$line =~ s/&lowquote;/\x{201A}/g;
$line =~ s/&bull;/\x{2022}/g;
$line =~ s/&sup4;/\x{2074}/g;
$line =~ s/&hand;/\x{261E}/g;
$line =~ s/&f-rune;/\x{16A0}/g;
$line =~ s/&u-rune;/\x{16A2}/g;
$line =~ s/&c-rune;/\x{16B3}/g;
$line =~ s/&w-rune;/\x{16B9}/g;
$line =~ s/&n-rune;/\x{16BE}/g;
$line =~ s/&i-rune;/\x{16C1}/g;
$line =~ s/&y-rune;/\x{16C3}/g;
$line =~ s/&p-rune;/\x{16C8}/g;
$line =~ s/&b-rune;/\x{16D2}/g;
$line =~ s/&e-rune;/\x{16D6}/g;
$line =~ s/&m-rune;/\x{16D7}/g;
$line =~ s/&l-rune;/\x{16DA}/g;
$line =~ s/&ng-rune;/\x{16DC}/g;
$line =~ s/&d-rune;/\x{16DE}/g;
return $line; } 1;
