// BSLLS:DuplicateStringLiteral-off

Перем СоответствиеТиповСодержимого Экспорт; // Содержит в себе коллекцию типов MIME по расширениям
Перем СоответствиеКодовHTTP Экспорт; // Коллекция кодов с их описанием

Функция ОпределитьТипСодержимого(Расширение) Экспорт
	
	Возврат СокрЛП(СоответствиеТиповСодержимого.Получить(Расширение));

КонецФункции

Функция ПолучитьРазмерДанных(Знач Данные) Экспорт

    Если ТипЗнч(Данные) = Тип("ДвоичныеДанные") Тогда
        ДанныеBase64 = Base64Строка(Данные);
    Иначе
        Возврат СтрДлина(XMLСтрока(Данные));
    КонецЕсли;

    // Base64 - специальный формат хранения данных в текстовом формате
    РазмерДанных = СтрДлина(ДанныеBase64) - ?(Прав(ДанныеBase64, 1) = "=", 1, 0) - ?(Прав(ДанныеBase64, 2) = "==", 1, 0);
    РазмерДанных = Цел(РазмерДанных / 4 * 3); // в байтах // BSLLS:MagicNumber-off

    Возврат РазмерДанных;

КонецФункции

// Возвращает описание кода ответа http
//
// Параметры:
//   Код - Число - Код ответа http
//
//  Возвращаемое значение:
//   Строка, Неопределено - Описание кода http или неопределено если передан не верный код
//
Функция ПолучитьОписаниеКодаHTTP(Код) Экспорт

	Возврат СоответствиеКодовHTTP.Получить(Код);

КонецФункции

Функция ЗначениеЗаголовкаПоКлючу(КоллекцияЗаголовков, Ключ) Экспорт
	
	Значение = "";
	
	Для каждого Элемент Из КоллекцияЗаголовков Цикл
		Если Элемент.Ключ = Ключ Тогда
			Значение = Элемент.Значение;
			Прервать;
		КонецЕсли;	
	КонецЦикла;

	Возврат Значение;

КонецФункции

Функция ПролучитьСоответствиеТиповСодержимого()
	
	Соответствие = Новый Соответствие();

	Соответствие.Вставить("123", " application/vnd.lotus-1-2-3");
	Соответствие.Вставить("3ds", " image/x-3ds");
	Соответствие.Вставить("669", " audio/x-mod");
	Соответствие.Вставить("a", " application/x-archive");
	Соответствие.Вставить("abw", " application/x-abiword");
	Соответствие.Вставить("ac3", " audio/ac3");
	Соответствие.Вставить("adb", " text/x-adasrc");
	Соответствие.Вставить("ads", " text/x-adasrc");
	Соответствие.Вставить("afm", " application/x-font-afm");
	Соответствие.Вставить("ag", " image/x-applix-graphics");
	Соответствие.Вставить("ai", " application/illustrator");
	Соответствие.Вставить("aif", " audio/x-aiff");
	Соответствие.Вставить("aifc", " audio/x-aiff");
	Соответствие.Вставить("aiff", " audio/x-aiff");
	Соответствие.Вставить("al", " application/x-perl");
	Соответствие.Вставить("arj", " application/x-arj");
	Соответствие.Вставить("as", " application/x-applix-spreadsheet");
	Соответствие.Вставить("asc", " text/plain");
	Соответствие.Вставить("asf", " video/x-ms-asf");
	Соответствие.Вставить("asp", " application/x-asp");
	Соответствие.Вставить("asx", " video/x-ms-asf");
	Соответствие.Вставить("au", " audio/basic");
	Соответствие.Вставить("avi", " video/x-msvideo");
	Соответствие.Вставить("aw", " application/x-applix-word");
	Соответствие.Вставить("bak", " application/x-trash");
	Соответствие.Вставить("bcpio", " application/x-bcpio");
	Соответствие.Вставить("bdf", " application/x-font-bdf");
	Соответствие.Вставить("bib", " text/x-bibtex");
	Соответствие.Вставить("bin", " application/octet-stream");
	Соответствие.Вставить("blend", " application/x-blender");
	Соответствие.Вставить("blender", " application/x-blender");
	Соответствие.Вставить("bmp", " image/bmp");
	Соответствие.Вставить("bz", " application/x-bzip");
	Соответствие.Вставить("bz2", " application/x-bzip");
	Соответствие.Вставить("c", " text/x-csrc");
	Соответствие.Вставить("c++", " text/x-c++src");
	Соответствие.Вставить("cc", " text/x-c++src");
	Соответствие.Вставить("cdf", " application/x-netcdf");
	Соответствие.Вставить("cdr", " application/vnd.corel-draw");
	Соответствие.Вставить("cer", " application/x-x509-ca-cert");
	Соответствие.Вставить("cert", " application/x-x509-ca-cert");
	Соответствие.Вставить("cgi", " application/x-cgi");
	Соответствие.Вставить("cgm", " image/cgm");
	Соответствие.Вставить("chrt", " application/x-kchart");
	Соответствие.Вставить("class", " application/x-java");
	Соответствие.Вставить("cls", " text/x-tex");
	Соответствие.Вставить("cpio", " application/x-cpio");
	Соответствие.Вставить("cpp", " text/x-c++src");
	Соответствие.Вставить("crt", " application/x-x509-ca-cert");
	Соответствие.Вставить("cs", " text/x-csharp");
	Соответствие.Вставить("csh", " application/x-shellscript");
	Соответствие.Вставить("css", " text/css");
	Соответствие.Вставить("cssl", " text/css");
	Соответствие.Вставить("csv", " text/x-comma-separated-values");
	Соответствие.Вставить("cur", " image/x-win-bitmap");
	Соответствие.Вставить("cxx", " text/x-c++src");
	Соответствие.Вставить("dat", " video/mpeg");
	Соответствие.Вставить("dbf", " application/x-dbase");
	Соответствие.Вставить("dc", " application/x-dc-rom");
	Соответствие.Вставить("dcl", " text/x-dcl");
	Соответствие.Вставить("dcm", " image/x-dcm");
	Соответствие.Вставить("deb", " application/x-deb");
	Соответствие.Вставить("der", " application/x-x509-ca-cert");
	Соответствие.Вставить("desktop", " application/x-desktop");
	Соответствие.Вставить("dia", " application/x-dia-diagram");
	Соответствие.Вставить("diff", " text/x-patch");
	Соответствие.Вставить("djv", " image/vnd.djvu");
	Соответствие.Вставить("djvu", " image/vnd.djvu");
	Соответствие.Вставить("doc", " application/vnd.ms-word");
	Соответствие.Вставить("dsl", " text/x-dsl");
	Соответствие.Вставить("dtd", " text/x-dtd");
	Соответствие.Вставить("dvi", " application/x-dvi");
	Соответствие.Вставить("dwg", " image/vnd.dwg");
	Соответствие.Вставить("dxf", " image/vnd.dxf");
	Соответствие.Вставить("egon", " application/x-egon");
	Соответствие.Вставить("el", " text/x-emacs-lisp");
	Соответствие.Вставить("eps", " image/x-eps");
	Соответствие.Вставить("epsf", " image/x-eps");
	Соответствие.Вставить("epsi", " image/x-eps");
	Соответствие.Вставить("etheme", " application/x-e-theme");
	Соответствие.Вставить("etx", " text/x-setext");
	Соответствие.Вставить("exe", " application/x-ms-dos-executable");
	Соответствие.Вставить("ez", " application/andrew-inset");
	Соответствие.Вставить("f", " text/x-fortran");
	Соответствие.Вставить("fig", " image/x-xfig");
	Соответствие.Вставить("fits", " image/x-fits");
	Соответствие.Вставить("flac", " audio/x-flac");
	Соответствие.Вставить("flc", " video/x-flic");
	Соответствие.Вставить("fli", " video/x-flic");
	Соответствие.Вставить("flw", " application/x-kivio");
	Соответствие.Вставить("fo", " text/x-xslfo");
	Соответствие.Вставить("g3", " image/fax-g3");
	Соответствие.Вставить("gb", " application/x-gameboy-rom");
	Соответствие.Вставить("gcrd", " text/x-vcard");
	Соответствие.Вставить("gen", " application/x-genesis-rom");
	Соответствие.Вставить("gg", " application/x-sms-rom");
	Соответствие.Вставить("gif", " image/gif");
	Соответствие.Вставить("glade", " application/x-glade");
	Соответствие.Вставить("gmo", " application/x-gettext-translation");
	Соответствие.Вставить("gnc", " application/x-gnucash");
	Соответствие.Вставить("gnucash", " application/x-gnucash");
	Соответствие.Вставить("gnumeric", " application/x-gnumeric");
	Соответствие.Вставить("gra", " application/x-graphite");
	Соответствие.Вставить("gsf", " application/x-font-type1");
	Соответствие.Вставить("gtar", " application/x-gtar");
	Соответствие.Вставить("gz", " application/x-gzip");
	Соответствие.Вставить("h", " text/x-chdr");
	Соответствие.Вставить("h++", " text/x-chdr");
	Соответствие.Вставить("hdf", " application/x-hdf");
	Соответствие.Вставить("hh", " text/x-c++hdr");
	Соответствие.Вставить("hp", " text/x-chdr");
	Соответствие.Вставить("hpgl", " application/vnd.hp-hpgl");
	Соответствие.Вставить("hs", " text/x-haskell");
	Соответствие.Вставить("htm", " text/html");
	Соответствие.Вставить("html", " text/html");
	Соответствие.Вставить("icb", " image/x-icb");
	Соответствие.Вставить("ico", " image/x-ico");
	Соответствие.Вставить("ics", " text/calendar");
	Соответствие.Вставить("idl", " text/x-idl");
	Соответствие.Вставить("ief", " image/ief");
	Соответствие.Вставить("iff", " image/x-iff");
	Соответствие.Вставить("ilbm", " image/x-ilbm");
	Соответствие.Вставить("iso", " application/x-cd-image");
	Соответствие.Вставить("it", " audio/x-it");
	Соответствие.Вставить("jar", " application/x-jar");
	Соответствие.Вставить("java", " text/x-java");
	Соответствие.Вставить("jng", " image/x-jng");
	Соответствие.Вставить("jp2", " image/jpeg2000");
	Соответствие.Вставить("jpe", " image/jpeg");
	Соответствие.Вставить("jpeg", " image/jpeg");
	Соответствие.Вставить("jpg", " image/jpeg");
	Соответствие.Вставить("jpr", " application/x-jbuilder-project");
	Соответствие.Вставить("jpx", " application/x-jbuilder-project");
	Соответствие.Вставить("js", " application/x-javascript");
	Соответствие.Вставить("json", " application/json");
	Соответствие.Вставить("karbon", " application/x-karbon");
	Соответствие.Вставить("kdelnk", " application/x-desktop");
	Соответствие.Вставить("kfo", " application/x-kformula");
	Соответствие.Вставить("kil", " application/x-killustrator");
	Соответствие.Вставить("kon", " application/x-kontour");
	Соответствие.Вставить("kpm", " application/x-kpovmodeler");
	Соответствие.Вставить("kpr", " application/x-kpresenter");
	Соответствие.Вставить("kpt", " application/x-kpresenter");
	Соответствие.Вставить("kra", " application/x-krita");
	Соответствие.Вставить("ksp", " application/x-kspread");
	Соответствие.Вставить("kud", " application/x-kugar");
	Соответствие.Вставить("kwd", " application/x-kword");
	Соответствие.Вставить("kwt", " application/x-kword");
	Соответствие.Вставить("la", " application/x-shared-library-la");
	Соответствие.Вставить("lha", " application/x-lha");
	Соответствие.Вставить("lhs", " text/x-literate-haskell");
	Соответствие.Вставить("lhz", " application/x-lhz");
	Соответствие.Вставить("log", " text/x-log");
	Соответствие.Вставить("ltx", " text/x-tex");
	Соответствие.Вставить("lwo", " image/x-lwo");
	Соответствие.Вставить("lwob", " image/x-lwo");
	Соответствие.Вставить("lws", " image/x-lws");
	Соответствие.Вставить("lyx", " application/x-lyx");
	Соответствие.Вставить("lzh", " application/x-lha");
	Соответствие.Вставить("lzo", " application/x-lzop");
	Соответствие.Вставить("m", " text/x-objcsrc");
	Соответствие.Вставить("m15", " audio/x-mod");
	Соответствие.Вставить("m3u", " audio/x-mpegurl");
	Соответствие.Вставить("man", " application/x-troff-man");
	Соответствие.Вставить("md", " application/x-genesis-rom");
	Соответствие.Вставить("me", " text/x-troff-me");
	Соответствие.Вставить("mgp", " application/x-magicpoint");
	Соответствие.Вставить("mid", " audio/midi");
	Соответствие.Вставить("midi", " audio/midi");
	Соответствие.Вставить("mif", " application/x-mif");
	Соответствие.Вставить("mkv", " application/x-matroska");
	Соответствие.Вставить("mm", " text/x-troff-mm");
	Соответствие.Вставить("mml", " text/mathml");
	Соответствие.Вставить("mng", " video/x-mng");
	Соответствие.Вставить("moc", " text/x-moc");
	Соответствие.Вставить("mod", " audio/x-mod");
	Соответствие.Вставить("moov", " video/quicktime");
	Соответствие.Вставить("mov", " video/quicktime");
	Соответствие.Вставить("movie", " video/x-sgi-movie");
	Соответствие.Вставить("mp2", " video/mpeg");
	Соответствие.Вставить("mp3", " audio/x-mp3");
	Соответствие.Вставить("mpe", " video/mpeg");
	Соответствие.Вставить("mpeg", " video/mpeg");
	Соответствие.Вставить("mpg", " video/mpeg");
	Соответствие.Вставить("ms", " text/x-troff-ms");
	Соответствие.Вставить("msod", " image/x-msod");
	Соответствие.Вставить("msx", " application/x-msx-rom");
	Соответствие.Вставить("mtm", " audio/x-mod");
	Соответствие.Вставить("n64", " application/x-n64-rom");
	Соответствие.Вставить("nc", " application/x-netcdf");
	Соответствие.Вставить("nes", " application/x-nes-rom");
	Соответствие.Вставить("nsv", " video/x-nsv");
	Соответствие.Вставить("o", " application/x-object");
	Соответствие.Вставить("obj", " application/x-tgif");
	Соответствие.Вставить("oda", " application/oda");
	Соответствие.Вставить("ogg", " application/ogg");
	Соответствие.Вставить("old", " application/x-trash");
	Соответствие.Вставить("oleo", " application/x-oleo");
	Соответствие.Вставить("p", " text/x-pascal");
	Соответствие.Вставить("p12", " application/x-pkcs12");
	Соответствие.Вставить("p7s", " application/pkcs7-signature");
	Соответствие.Вставить("pas", " text/x-pascal");
	Соответствие.Вставить("patch", " text/x-patch");
	Соответствие.Вставить("pbm", " image/x-portable-bitmap");
	Соответствие.Вставить("pcd", " image/x-photo-cd");
	Соответствие.Вставить("pcf", " application/x-font-pcf");
	Соответствие.Вставить("pcl", " application/vnd.hp-pcl");
	Соответствие.Вставить("pdb", " application/vnd.palm");
	Соответствие.Вставить("pdf", " application/pdf");
	Соответствие.Вставить("pem", " application/x-x509-ca-cert");
	Соответствие.Вставить("perl", " application/x-perl");
	Соответствие.Вставить("pfa", " application/x-font-type1");
	Соответствие.Вставить("pfb", " application/x-font-type1");
	Соответствие.Вставить("pfx", " application/x-pkcs12");
	Соответствие.Вставить("pgm", " image/x-portable-graymap");
	Соответствие.Вставить("pgn", " application/x-chess-pgn");
	Соответствие.Вставить("pgp", " application/pgp");
	Соответствие.Вставить("php", " application/x-php");
	Соответствие.Вставить("php3", " application/x-php");
	Соответствие.Вставить("php4", " application/x-php");
	Соответствие.Вставить("pict", " image/x-pict");
	Соответствие.Вставить("pict1", " image/x-pict");
	Соответствие.Вставить("pict2", " image/x-pict");
	Соответствие.Вставить("pl", " application/x-perl");
	Соответствие.Вставить("pls", " audio/x-scpls");
	Соответствие.Вставить("pm", " application/x-perl");
	Соответствие.Вставить("png", " image/png");
	Соответствие.Вставить("pnm", " image/x-portable-anymap");
	Соответствие.Вставить("po", " text/x-gettext-translation");
	Соответствие.Вставить("pot", " text/x-gettext-translation-template");
	Соответствие.Вставить("ppm", " image/x-portable-pixmap");
	Соответствие.Вставить("pps", " application/vnd.ms-powerpoint");
	Соответствие.Вставить("ppt", " application/vnd.ms-powerpoint");
	Соответствие.Вставить("ppz", " application/vnd.ms-powerpoint");
	Соответствие.Вставить("ps", " application/postscript");
	Соответствие.Вставить("psd", " image/x-psd");
	Соответствие.Вставить("psf", " application/x-font-linux-psf");
	Соответствие.Вставить("psid", " audio/prs.sid");
	Соответствие.Вставить("pw", " application/x-pw");
	Соответствие.Вставить("py", " application/x-python");
	Соответствие.Вставить("pyc", " application/x-python-bytecode");
	Соответствие.Вставить("pyo", " application/x-python-bytecode");
	Соответствие.Вставить("qif", " application/x-qw");
	Соответствие.Вставить("qt", " video/quicktime");
	Соответствие.Вставить("qtvr", " video/quicktime");
	Соответствие.Вставить("ra", " audio/x-pn-realaudio");
	Соответствие.Вставить("ram", " audio/x-pn-realaudio");
	Соответствие.Вставить("rar", " application/x-rar");
	Соответствие.Вставить("ras", " image/x-cmu-raster");
	Соответствие.Вставить("rdf", " text/rdf");
	Соответствие.Вставить("rej", " application/x-reject");
	Соответствие.Вставить("rgb", " image/x-rgb");
	Соответствие.Вставить("rle", " image/rle");
	Соответствие.Вставить("rm", " audio/x-pn-realaudio");
	Соответствие.Вставить("roff", " application/x-troff");
	Соответствие.Вставить("rpm", " application/x-rpm");
	Соответствие.Вставить("rss", " text/rss");
	Соответствие.Вставить("rtf", " application/rtf");
	Соответствие.Вставить("rtx", " text/richtext");
	Соответствие.Вставить("s3m", " audio/x-s3m");
	Соответствие.Вставить("sam", " application/x-amipro");
	Соответствие.Вставить("scm", " text/x-scheme");
	Соответствие.Вставить("sda", " application/vnd.stardivision.draw");
	Соответствие.Вставить("sdc", " application/vnd.stardivision.calc");
	Соответствие.Вставить("sdd", " application/vnd.stardivision.impress");
	Соответствие.Вставить("sdp", " application/vnd.stardivision.impress");
	Соответствие.Вставить("sds", " application/vnd.stardivision.chart");
	Соответствие.Вставить("sdw", " application/vnd.stardivision.writer");
	Соответствие.Вставить("sgi", " image/x-sgi");
	Соответствие.Вставить("sgl", " application/vnd.stardivision.writer");
	Соответствие.Вставить("sgm", " text/sgml");
	Соответствие.Вставить("sgml", " text/sgml");
	Соответствие.Вставить("sh", " application/x-shellscript");
	Соответствие.Вставить("shar", " application/x-shar");
	Соответствие.Вставить("siag", " application/x-siag");
	Соответствие.Вставить("sid", " audio/prs.sid");
	Соответствие.Вставить("sik", " application/x-trash");
	Соответствие.Вставить("slk", " text/spreadsheet");
	Соответствие.Вставить("smd", " application/vnd.stardivision.mail");
	Соответствие.Вставить("smf", " application/vnd.stardivision.math");
	Соответствие.Вставить("smi", " application/smil");
	Соответствие.Вставить("smil", " application/smil");
	Соответствие.Вставить("sml", " application/smil");
	Соответствие.Вставить("sms", " application/x-sms-rom");
	Соответствие.Вставить("snd", " audio/basic");
	Соответствие.Вставить("so", " application/x-sharedlib");
	Соответствие.Вставить("spd", " application/x-font-speedo");
	Соответствие.Вставить("sql", " text/x-sql");
	Соответствие.Вставить("src", " application/x-wais-source");
	Соответствие.Вставить("stc", " application/vnd.sun.xml.calc.template");
	Соответствие.Вставить("std", " application/vnd.sun.xml.draw.template");
	Соответствие.Вставить("sti", " application/vnd.sun.xml.impress.template");
	Соответствие.Вставить("stm", " audio/x-stm");
	Соответствие.Вставить("stw", " application/vnd.sun.xml.writer.template");
	Соответствие.Вставить("sty", " text/x-tex");
	Соответствие.Вставить("sun", " image/x-sun-raster");
	Соответствие.Вставить("sv4cpio", " application/x-sv4cpio");
	Соответствие.Вставить("sv4crc", " application/x-sv4crc");
	Соответствие.Вставить("svg", " image/svg+xml");
	Соответствие.Вставить("swf", " application/x-shockwave-flash");
	Соответствие.Вставить("sxc", " application/vnd.sun.xml.calc");
	Соответствие.Вставить("sxd", " application/vnd.sun.xml.draw");
	Соответствие.Вставить("sxg", " application/vnd.sun.xml.writer.global");
	Соответствие.Вставить("sxi", " application/vnd.sun.xml.impress");
	Соответствие.Вставить("sxm", " application/vnd.sun.xml.math");
	Соответствие.Вставить("sxw", " application/vnd.sun.xml.writer");
	Соответствие.Вставить("sylk", " text/spreadsheet");
	Соответствие.Вставить("t", " application/x-troff");
	Соответствие.Вставить("tar", " application/x-tar");
	Соответствие.Вставить("tcl", " text/x-tcl");
	Соответствие.Вставить("tcpalette", " application/x-terminal-color-palette");
	Соответствие.Вставить("tex", " text/x-tex");
	Соответствие.Вставить("texi", " text/x-texinfo");
	Соответствие.Вставить("texinfo", " text/x-texinfo");
	Соответствие.Вставить("tga", " image/x-tga");
	Соответствие.Вставить("tgz", " application/x-compressed-tar");
	Соответствие.Вставить("theme", " application/x-theme");
	Соответствие.Вставить("tif", " image/tiff");
	Соответствие.Вставить("tiff", " image/tiff");
	Соответствие.Вставить("tk", " text/x-tcl");
	Соответствие.Вставить("torrent", " application/x-bittorrent");
	Соответствие.Вставить("tr", " application/x-troff");
	Соответствие.Вставить("ts", " application/x-linguist");
	Соответствие.Вставить("tsv", " text/tab-separated-values");
	Соответствие.Вставить("ttf", " application/x-font-ttf");
	Соответствие.Вставить("txt", " text/plain");
	Соответствие.Вставить("tzo", " application/x-tzo");
	Соответствие.Вставить("ui", " application/x-designer");
	Соответствие.Вставить("uil", " text/x-uil");
	Соответствие.Вставить("ult", " audio/x-mod");
	Соответствие.Вставить("uni", " audio/x-mod");
	Соответствие.Вставить("uri", " text/x-uri");
	Соответствие.Вставить("url", " text/x-uri");
	Соответствие.Вставить("ustar", " application/x-ustar");
	Соответствие.Вставить("vcf", " text/x-vcalendar");
	Соответствие.Вставить("vcs", " text/x-vcalendar");
	Соответствие.Вставить("vct", " text/x-vcard");
	Соответствие.Вставить("vob", " video/mpeg");
	Соответствие.Вставить("voc", " audio/x-voc");
	Соответствие.Вставить("vor", " application/vnd.stardivision.writer");
	Соответствие.Вставить("vpp", " application/x-extension-vpp");
	Соответствие.Вставить("wav", " audio/x-wav");
	Соответствие.Вставить("wb1", " application/x-quattropro");
	Соответствие.Вставить("wb2", " application/x-quattropro");
	Соответствие.Вставить("wb3", " application/x-quattropro");
	Соответствие.Вставить("wk1", " application/vnd.lotus-1-2-3");
	Соответствие.Вставить("wk3", " application/vnd.lotus-1-2-3");
	Соответствие.Вставить("wk4", " application/vnd.lotus-1-2-3");
	Соответствие.Вставить("wks", " application/vnd.lotus-1-2-3");
	Соответствие.Вставить("wmf", " image/x-wmf");
	Соответствие.Вставить("wml", " text/vnd.wap.wml");
	Соответствие.Вставить("wmv", " video/x-ms-wmv");
	Соответствие.Вставить("wpd", " application/vnd.wordperfect");
	Соответствие.Вставить("wpg", " application/x-wpg");
	Соответствие.Вставить("wri", " application/x-mswrite");
	Соответствие.Вставить("wrl", " model/vrml");
	Соответствие.Вставить("xac", " application/x-gnucash");
	Соответствие.Вставить("xbel", " application/x-xbel");
	Соответствие.Вставить("xbm", " image/x-xbitmap");
	Соответствие.Вставить("xcf", " image/x-xcf");
	Соответствие.Вставить("xhtml", " application/xhtml+xml");
	Соответствие.Вставить("xi", " audio/x-xi");
	Соответствие.Вставить("xla", " application/vnd.ms-excel");
	Соответствие.Вставить("xlc", " application/vnd.ms-excel");
	Соответствие.Вставить("xld", " application/vnd.ms-excel");
	Соответствие.Вставить("xll", " application/vnd.ms-excel");
	Соответствие.Вставить("xlm", " application/vnd.ms-excel");
	Соответствие.Вставить("xls", " application/vnd.ms-excel");
	Соответствие.Вставить("xlt", " application/vnd.ms-excel");
	Соответствие.Вставить("xlw", " application/vnd.ms-excel");
	Соответствие.Вставить("xm", " audio/x-xm");
	Соответствие.Вставить("xmi", " text/x-xmi");
	Соответствие.Вставить("xml", " text/xml");
	Соответствие.Вставить("xpm", " image/x-xpixmap");
	Соответствие.Вставить("xsl", " text/x-xslt");
	Соответствие.Вставить("xslfo", " text/x-xslfo");
	Соответствие.Вставить("xslt", " text/x-xslt");
	Соответствие.Вставить("xwd", " image/x-xwindowdump");
	Соответствие.Вставить("z", " application/x-compress");
	Соответствие.Вставить("zabw", " application/x-abiword");
	Соответствие.Вставить("zip", " application/zip");
	Соответствие.Вставить("zoo", " application/x-zoo");

	Возврат Соответствие;

КонецФункции

Функция ПолучитьОписаниеКодовHTTP()

	Соответствие = Новый Соответствие();

	Соответствие.Вставить(100, "Continue");
	Соответствие.Вставить(101, "Switching Protocol");
	Соответствие.Вставить(102, "Processing");
	Соответствие.Вставить(103, "Early Hints");
	Соответствие.Вставить(200, "OK");
	Соответствие.Вставить(201, "Created");
	Соответствие.Вставить(202, "Accepted");
	Соответствие.Вставить(203, "Non-Authoritative Information");
	Соответствие.Вставить(204, "No Content");
	Соответствие.Вставить(205, "Reset Content");
	Соответствие.Вставить(206, "Partial Content");
	Соответствие.Вставить(300, "Multiple Choice");
	Соответствие.Вставить(301, "Moved Permanently");
	Соответствие.Вставить(302, "Found");
	Соответствие.Вставить(303, "See Other");
	Соответствие.Вставить(304, "Not Modified");
	Соответствие.Вставить(305, "Use Proxy");
	Соответствие.Вставить(306, "Switch Proxy");
	Соответствие.Вставить(307, "Temporary Redirect");
	Соответствие.Вставить(308, "Permanent Redirect");
	Соответствие.Вставить(400, "Bad Request");
	Соответствие.Вставить(401, "Unauthorized");
	Соответствие.Вставить(402, "Payment Required");
	Соответствие.Вставить(403, "Forbidden");
	Соответствие.Вставить(404, "Not Found");
	Соответствие.Вставить(405, "Method Not Allowed");
	Соответствие.Вставить(406, "Not Acceptable");
	Соответствие.Вставить(407, "Proxy Authentication Required");
	Соответствие.Вставить(408, "Request Timeout");
	Соответствие.Вставить(409, "Conflict");
	Соответствие.Вставить(410, "Gone");
	Соответствие.Вставить(411, "Length Required");
	Соответствие.Вставить(412, "Precondition Failed");
	Соответствие.Вставить(413, "Request Entity Too Large");
	Соответствие.Вставить(414, "Request-URI Too Long");
	Соответствие.Вставить(415, "Unsupported Media Type");
	Соответствие.Вставить(416, "Requested Range Not Satisfiable");
	Соответствие.Вставить(417, "Expectation Failed");
	Соответствие.Вставить(500, "InternalServerError");
	Соответствие.Вставить(501, "Not Implemented");
	Соответствие.Вставить(502, "Bad Gateway");
	Соответствие.Вставить(503, "Service Unavailable");
	Соответствие.Вставить(504, "Gateway Timeout");
	Соответствие.Вставить(505, "HTTP Version Not Supported");

	Возврат Соответствие;

КонецФункции

СоответствиеТиповСодержимого = ПролучитьСоответствиеТиповСодержимого();
СоответствиеКодовHTTP = ПолучитьОписаниеКодовHTTP();