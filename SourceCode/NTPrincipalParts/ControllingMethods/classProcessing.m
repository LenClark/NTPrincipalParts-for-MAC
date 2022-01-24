//
//  classProcessing.m
//  NTPrincipalParts
//
//  Created by Leonard Clark on 11/01/2022.
//

#import "classProcessing.h"

@implementation classProcessing

@synthesize grammarBreakdown;
@synthesize principalPartCode;
@synthesize  majiscules;
@synthesize miniscules;
@synthesize accentedChars;
@synthesize accentsRemoved;
@synthesize highGraves;
@synthesize lowGraves;
@synthesize allChars;
@synthesize allSimplified;
@synthesize translitChars1;
@synthesize translitChars2;
@synthesize transliterationTable;

-(id) init
{
    NSInteger idx, noOfItems, unicodeValue;
    unichar currChar;
    NSString *characterString, *currCharString, *resChars;
    translitChars1 = [[NSArray alloc] initWithObjects:@"A/", @"!", @"E/", @"H/", @"I/", @"!", @"O/", @"!", @"U/", @"W/",
                              @"i/:", @"A", @"B", @"G", @"D", @"E", @"Z", @"H", @"Q", @"I", @"K", @"L", @"M", @"N", @"C", @"O",
                              @"P", @"R", @"!", @"S", @"T", @"U", @"F", @"X", @"Y", @"W", @"I:", @"U:", @"a/", @"e/", @"h/", @"i/",
                              @"u/:", @"a", @"b", @"g", @"d", @"e", @"z", @"h", @"q", @"i", @"k", @"l", @"m", @"n", @"c", @"o",
                               @"p", @"r", @"j", @"s", @"t", @"u", @"f", @"x", @"y", @"w", @"i:", @"u:", @"o/", @"u/", @"w/", nil];
    translitChars2 = [[NSArray alloc] initWithObjects:@"a)", @"a(", @"a\\)", @"a\\(", @"a/)", @"a/(", @"a~)", @"a~(", @"A)", @"A(", @"A\\)", @"A\\(", @"A/)", @"A/(", @"A~)", @"A~(",
                               @"e)", @"e(", @"e\\)", @"e\\(", @"e/)", @"e/(", @"!",  @"!", @"E)", @"E(", @"E\\)", @"E\\(", @"E/)", @"E/(", @"!", @"!",
                               @"h)", @"h(", @"h\\)", @"h\\(", @"h/)", @"h/(", @"h~)", @"h~(", @"H)", @"H(", @"H\\)", @"H\\(", @"H/)", @"H/(", @"H~)", @"H~(",
                               @"i)", @"i(", @"i\\)", @"i\\(", @"i/)", @"i/(", @"i~)", @"i~(", @"I)", @"I(", @"I\\)", @"I\\(", @"I/)", @"I/(", @"I~)", @"I~(",
                               @"o)", @"o(", @"o\\)", @"o\\(", @"o/)", @"o/(", @"!", @"!", @"O)", @"O(", @"O\\)", @"O\\(", @"O/)", @"O/(", @"!", @"!",
                               @"u)", @"u(", @"u\\)", @"u\\(", @"u/)", @"u/(", @"u~)", @"u~(", @"!", @"U(", @"!", @"U\\(", @"!", @"U/(", @"!", @"U~(",
                               @"w)", @"w(", @"w\\)", @"w\\(", @"w/)", @"w/(", @"w~)", @"w~(", @"W)", @"W(", @"W\\)", @"W\\(", @"W/)", @"W/(", @"W~)", @"W~(",
                               @"a\\", @"a/", @"e\\", @"e/", @"h\\", @"h/", @"i\\", @"i/", @"o\\", @"o/", @"u\\", @"u/", @"w\\", @"w/", @"!", @"!",
                               @"a)|", @"a(|", @"a\\)|", @"a\\(|", @"a/)|", @"a/(|", @"a~)|", @"a~(|", @"A)|", @"A(|", @"A\\)|", @"A\\(|", @"A/)|", @"A/(|", @"A~)|", @"A~(|",
                               @"h)|", @"h(|", @"h\\)|", @"h\\(|", @"h/)|", @"h/(|", @"h~)|", @"h~(|", @"H)|", @"H(|", @"H\\)|", @"H\\(|", @"H/)|", @"H/(|", @"H~)|", @"H~(|",
                               @"w)|", @"w(|", @"w\\)|", @"w\\(|", @"w/)|", @"w/(|", @"w~)|", @"w~(|", @"W)|", @"W(|", @"W\\)|", @"W\\(|", @"W/)|", @"W/(|", @"W~)|", @"W~(|",
                               @"a+", @"a-", @"a\\|", @"a|", @"a/|", @"!", @"a~", @"a~|", @"A+", @"A-", @"A\\", @"A/", @"A|", @"!", @"!", @"!",
                               @"!", @"!", @"h\\|", @"h|", @"h/|", @"!", @"h~", @"h~|", @"E\\", @"E/", @"H\\", @"H/", @"H|", @"!", @"!", @"!",
                               @"i+", @"i-", @"i\\:", @"i/:", @"!", @"!", @"i~", @"i~:", @"I+", @"I-", @"I\\", @"I/", @"!", @"!", @"!", @"!",
                               @"u+", @"u-", @"u\\:", @"u/:", @"r)", @"r(", @"u~", @"u~:", @"U+", @"U-", @"U\\", @"U/", @"R(", @"!", @"!", @"!",
                               @"!", @"!", @"w\\|", @"w|", @"w/|", @"!", @"w~", @"w~|", @"O\\", @"O/", @"W\\", @"W/", @"W|", @"!", @"!", @"!", nil];

    self = [super init];
    majiscules = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"Majiscules"]];
    miniscules = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"Miniscules"]];
    accentedChars = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"accentedChars"]];
    accentsRemoved = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"accentsRemoved"]];
    highGraves = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"highGraves"]];
    lowGraves = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"lowGraves"]];
    allChars = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"allChars"]];
    allSimplified = [[NSArray alloc] initWithArray:[self getContentsOfFile:@"allSimplified"]];
    transliterationTable = [[NSMutableDictionary alloc] init];
    noOfItems = [translitChars1 count];
    unicodeValue = 3 * 256 + 8 * 16 + 6;
    for( idx = 0; idx < noOfItems; idx++)
    {
        characterString = [[NSString alloc] initWithString:[translitChars1 objectAtIndex:idx]];
        if( [characterString compare:@"!"] == NSOrderedSame)
        {
            unicodeValue++;
            continue;
        }
        currChar = unicodeValue++;
        currCharString = [[NSString alloc] initWithCharacters:&currChar length:1];
        resChars = [[NSString alloc] initWithString:[translitChars1 objectAtIndex:idx]];
        [transliterationTable setValue:[[NSString alloc] initWithFormat:@"%@", resChars] forKey:currCharString];
    }
    currChar = 3 * 256 + 13 * 16 + 12;
    currCharString = [[NSString alloc] initWithCharacters:&currChar length:1];
    [transliterationTable setValue:@"V" forKey:currCharString];
    currChar = 3 * 256 + 13 * 16 + 13;
    currCharString = [[NSString alloc] initWithCharacters:&currChar length:1];
    [transliterationTable setValue:@"v" forKey:currCharString];
    noOfItems = [translitChars2 count];
    unicodeValue = 4096 + 15 * 256;
    for( idx = 0; idx < noOfItems; idx++)
    {
        characterString = [[NSString alloc] initWithString:[translitChars2 objectAtIndex:idx]];
        if( [characterString compare:@"!"] == NSOrderedSame)
        {
            unicodeValue++;
            continue;
        }
        currChar = unicodeValue++;
        currCharString = [[NSString alloc] initWithCharacters:&currChar length:1];
        resChars = [[NSString alloc] initWithString:[translitChars2 objectAtIndex:idx]];
        [transliterationTable setValue:[[NSString alloc] initWithFormat:@"%@", resChars] forKey:currCharString];
    }
    return self;
}

- (NSArray *) getContentsOfFile: (NSString *) fileName
{
    NSString *masterFileName, *masterBuffer, *lineContent;
    NSArray *masterByLine, *masterContents;
    NSMutableArray *allMasterItems;
    
    allMasterItems = [[NSMutableArray alloc] init];
    masterFileName = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    masterBuffer = [NSString stringWithContentsOfFile:masterFileName encoding:NSUTF8StringEncoding error:nil];
    masterByLine = [[NSArray alloc] initWithArray:[masterBuffer componentsSeparatedByString:@"\n"]];
    for( lineContent in masterByLine)
    {
        masterContents = [[NSArray alloc] initWithArray:[lineContent componentsSeparatedByString:@"\t"]];
        [allMasterItems addObjectsFromArray:masterContents];
    }
    return [allMasterItems copy];
}

- (NSString *) integerString: (NSInteger) intValue
{
    return [[NSString alloc] initWithFormat:@"%ld", intValue];
}

- (NSString *) cleanWord: (NSString *) incomingWord
{
    /*========================================================================================*
     *                                                                                        *
     *                                    cleanWord                                           *
     *                                    =========                                           *
     *                                                                                        *
     *  This provides a form of the word form that is ready for comparisons.  It will do the  *
     *    following:                                                                          *
     *    a) reduce a leading majiscule (if it exists) to miniscule (using decapitalise);     *
     *    b) if the first (or only) accent is grave, change it to accute;                     *
     *    c) remove _any_ second accent.                                                      *
     *                                                                                        *
     *========================================================================================*/
    
    NSInteger idx, wordLength, accentCount = 0, index;
    NSString *currentChar;
    NSMutableString *outgoingWord;

    outgoingWord = [[NSMutableString alloc] initWithString:@""];
    wordLength = [incomingWord length];
    for( idx = 0; idx < wordLength; idx++)
    {
        currentChar = [[NSString alloc] initWithString:[incomingWord substringWithRange:(NSMakeRange(idx, 1))]];
        if( idx == 0) currentChar = [[NSString alloc] initWithString:[self decapitalise:currentChar]];
        if( [accentedChars containsObject:currentChar])
        {
            if( accentCount == 0)
            {
                if( [highGraves containsObject:currentChar])
                {
                    index = [highGraves indexOfObject:currentChar];
                    currentChar = [[NSString alloc] initWithString: [lowGraves objectAtIndex:index]];
                }
                accentCount++;
            }
            else
            {
                index = [accentedChars indexOfObject:currentChar];
                currentChar = [[NSString alloc] initWithString: [accentsRemoved objectAtIndex:index]];
            }
        }
        [outgoingWord appendString:currentChar];
    }
    return [outgoingWord copy];
}

- (NSString *) cleanTransliteratedWord: (NSString *) incomingWord
{
    /*========================================================================================*
     *                                                                                        *
     *                               cleanTransliteratedWord                                  *
     *                               =======================                                  *
     *                                                                                        *
     *  This provides a form of the word form that is ready for comparisons.  It will do the  *
     *    following:                                                                          *
     *    a) reduce a leading majiscule (if it exists) to miniscule (using decapitalise);     *
     *    b) remove _any_ second accent.                                                      *
     *                                                                                        *
     *  Note the codes of transliteration used here:                                          *
     *                                                                                        *
     *  α = a; β = b; γ = g; δ = d; ε = e; ζ = z; η = h; θ = q; ι = i; κ = k; λ = l; μ = m;   *
     *  ν = n; ξ = c; ο = o; π = p; ρ = r; ς = j; σ = s; τ = t; υ = u; φ = f; χ = x; ψ = y;   *
     *  ω = w; ϝ = v.                                                                         *
     *                                                                                        *
     *  All majiscules are the same character in upper case.  (Note, no upper case for ς.)    *
     *                                                                                        *
     *  Accents always follow the transliterated character first, where they exist:           *
     *    Grave = \; accute = /; circumflex = ~                                               *
     *                                                                                        *
     *  Next are breathings: rough = ), smooth = ( or diaereses = :                           *
     *                                                                                        *
     *  Short vowel symbol = +, long vowel symbol = -                                         *
     *                                                                                        *
     *  Iota subscript always comes last and is represented by |                              *
     *                                                                                        *
     *========================================================================================*/
    
    NSInteger idx, wordLength, accentCount = 0;
    NSString *currentChar;
    NSArray *simpleMinChars = [[NSArray alloc] initWithObjects: @"a", @"b", @"g", @"d", @"e", @"z", @"h", @"q", @"i", @"k", @"l", @"m"
                                                    @"n", @"c", @"o", @"p", @"r", @"j", @"s", @"t", @"u", @"f", @"x", @"y", @"w", @"v", nil];
    NSArray *simpleMajChars = [[NSArray alloc] initWithObjects: @"A", @"B", @"G", @"D", @"E", @"Z", @"H", @"Q", @"I", @"K", @"L", @"M"
                                                    @"N", @"C", @"O", @"P", @"R", @"", @"S", @"T", @"U", @"F", @"X", @"Y", @"W", @"V", nil];
    NSArray *accents = [[NSArray alloc] initWithObjects:@"\\", @"/", @"~", @"+", @"-", nil];
    NSMutableString *outgoingWord, *prevWord;

    outgoingWord = [[NSMutableString alloc] initWithString:@""];
    prevWord = [[NSMutableString alloc] initWithString:@""];
    wordLength = [incomingWord length];
    for( idx = 0; idx < wordLength; idx++)
    {
        currentChar = [[NSString alloc] initWithString:[incomingWord substringWithRange:(NSMakeRange(idx, 1))]];
        if( [simpleMajChars containsObject:currentChar] )
        {
            currentChar = [[NSString alloc] initWithString:[simpleMinChars objectAtIndex:[simpleMajChars indexOfObject:currentChar]]];
        }
        if( [simpleMinChars containsObject:currentChar])
        {
            if( [prevWord length] > 0)
            {
                [outgoingWord appendString:prevWord];
            }
            prevWord = [[NSMutableString alloc] initWithString:currentChar];
        }
        else
        {
            if( [accents containsObject:currentChar])
            {
                accentCount++;
                if( accentCount < 2)
                {
                    [prevWord appendString:currentChar];
                }
            }
            else
            {
                [prevWord appendString:currentChar];
            }
        }
    }
    if( [prevWord length] > 0) [outgoingWord appendString:prevWord];
    return [outgoingWord copy];
}

- (NSString *) transliterateGreekWord: (NSString *) sourceWord
{
    NSInteger idx, wordLength;
    NSString *charRepresentation, *foundChar;
    NSArray *ignoredChars = [[NSArray alloc] initWithObjects:@"(", @")", @"[", @"]", @"-", @"ʹ", @"̈", @"\0", nil];
    NSMutableString *workingSpace;
    
    workingSpace = [[NSMutableString alloc] initWithString:@""];
    wordLength = [sourceWord length];
    for( idx = 0; idx < wordLength; idx++)
    {
        foundChar = [sourceWord substringWithRange:(NSMakeRange(idx, 1))];
        if( [ignoredChars containsObject: foundChar] ) continue;
            charRepresentation = [[NSString alloc] initWithString:[transliterationTable objectForKey:foundChar]];
        if( charRepresentation == nil) [workingSpace appendString:@"!"];
        else [workingSpace appendString:charRepresentation];
    }
    return [workingSpace copy];
}

- (NSString *) decapitalise: (NSString *) incomingChar
{
    /*========================================================================================*
     *                                                                                        *
     *                                   decapitalise                                         *
     *                                   ============                                         *
     *                                                                                        *
     *  This reduces a leading majiscule (if it exists) to miniscule. It assumes that the     *
     *    incoming string is a single character and returns a single character.               *
     *                                                                                        *
     *========================================================================================*/

    NSInteger index;
    NSString *outgoingChar;
    
    if( [majiscules containsObject:incomingChar] )
    {
        index = [majiscules indexOfObject:incomingChar];
        outgoingChar = [[NSString alloc] initWithString:[miniscules objectAtIndex:index]];
    }
    else outgoingChar = [[NSString alloc] initWithString:incomingChar];
    return outgoingChar;
}

- (NSString *) stripAll: (NSString *) incomingWord
{
    /*========================================================================================*
     *                                                                                        *
     *                                    stripAll                                            *
     *                                    ========                                            *
     *                                                                                        *
     *  This removes _all_ extraneous furniture from the word: breathings, accents, iota      *
     *    subscript, diereses.  It is used for sorting words irrespective of these extras.    *
     *                                                                                        *
     *========================================================================================*/
    
    NSInteger idx, wordLength, index;
    NSString *currentChar;
    NSMutableString *outgoingWord;

    outgoingWord = [[NSMutableString alloc] initWithString:@""];
    wordLength = [incomingWord length];
    for( idx = 0; idx < wordLength; idx++)
    {
        currentChar = [[NSString alloc] initWithString:[incomingWord substringWithRange:(NSMakeRange(idx, 1))]];
        if( idx == 0) currentChar = [[NSString alloc] initWithString:[self decapitalise:currentChar]];
        if( [allChars containsObject:currentChar])
        {
            index = [allChars indexOfObject:currentChar];
            currentChar = [[NSString alloc] initWithString: [allSimplified objectAtIndex:index]];
        }
        [outgoingWord appendString:currentChar];
    }
    return [outgoingWord copy];

}

- (NSInteger) getNTParseInfo: (NSString *) inParseInfo
{
    /*=================================================================================================================*
     *                                                                                                                 *
     *                                            getNTParseInfo                                                       *
     *                                            ==============                                                       *
     *                                                                                                                 *
     *  Decode the Parse Code for NT source data and convert it into an integer value that uniquely identifies its     *
     *  grammatical function.  The numeric code is formed as follows:                                                  *
     *                                                                                                                 *
     *    Person:  1, 2 or 3 according to person                                                                       *
     *             Plural: add 3 to person value                                                                       *
     *             If the source code is -, Singular = 7 and Plural = 8                                                *
     *             Initially (before looking at plural) workingInt is "1" = -, "2" = 1, "3" = 2 "-"/none = 3;          *
     *                                                  parseCode becomes "1" = 1, "2" = 2, "3" = 3 and "-" = 7        *
     *             grammarCategory[0] is 0 (no prson given), 1 = "1", 2 = "2", 3 = "3".                                *
     *      Plural adds 3 if person is 1-3, adds 1 if person is 7.                                                     *
     *             grammarCategory[1] is simply 0 (no sing/plur given), 1 = sing, 2 = plur.                            *
     *    Tense:   Add 1 - 6 times 10, (so Present adds 10, imperfect adds 20, aorist adds 30, etc.)                   *
     *             workingInt is finally: P(res) = 1, I(mpf) = 2, A(orist) = 3, X (Perf) = 4, Y (Plupf) = 5, F(ut) = 6 *
     *               this value times 10 is added to the parse code;                                                   *
     *               grammarCategory[4] = workingIt;                                                                   *
     *               "-" is ignored - so grammarCategory[4] = 0                                                        *
     *    Mood:    add 1 - 6 times 100, (so indicative adds 100, imperative adds 200, etc.)                            *
     *    Voice:   add 1 - 3 times 1000, according to voice                                                            *
     *    Case:    add 1 - 5 times 10000, according to case                                                            *
     *    Gender:  add 1 - 3 times 100000, according to gender                                                         *
     *                                                                                                                 *
     *  The method also adds the same coded values to grammarStore and uses this information to identify the principal *
     *  part related to the specific word form.                                                                        *
     *                                                                                                                 *
     *=================================================================================================================*/

    const NSInteger grammarCategories = 7;
    
    NSInteger idx, workingInt, parseCode = 0;
    NSString *targetChar;
    NSArray *numberCode = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"-", nil];
    NSArray *singCode = [[NSArray alloc] initWithObjects:@"S", @"D", @"P", @"-", nil];
    NSArray *caseCode = [[NSArray alloc] initWithObjects:@"N", @"V", @"A", @"G", @"D", @"-", nil];
    NSArray *genderCode = [[NSArray alloc] initWithObjects:@"M", @"N", @"F", @"-", nil];
    NSArray *tenseCode = [[NSArray alloc] initWithObjects:@"P", @"I", @"A", @"X", @"Y", @"F", @"-", nil];
    NSArray *moodCode = [[NSArray alloc] initWithObjects:@"I", @"D", @"S", @"O", @"N", @"P", @"-", nil];
    NSArray *voiceCode = [[NSArray alloc] initWithObjects:@"A", @"M", @"P", @"-", nil];
    NSMutableArray *grammarStore = [[NSMutableArray alloc] init];
    
    for( idx = 0; idx < grammarCategories; idx++)
    {
        [grammarStore addObject:[self integerString:0]];
    }
    // Inspect the code character in position 0 - = 1, 2, 3 or "-" - see numberCode above
    targetChar = [[NSString alloc] initWithString:[inParseInfo substringToIndex:1]];
    // Use the reference array, numberCode, to identify an associated integer value
    workingInt = [numberCode indexOfObject:targetChar];
    // Handle exceptions
    if( workingInt == NSNotFound ) workingInt = 3;
    // Store the found number in grammarStore (or zero for "-" or errors)
    if( workingInt < 3 ) [grammarStore replaceObjectAtIndex:0 withObject:targetChar];
    else [grammarStore replaceObjectAtIndex:0 withObject:@"0"];
    // Start calculating the parseCode
    parseCode = ++workingInt;
    if( parseCode == 4) parseCode = 7;
    // Now for plurals - these are not like all that follows
    workingInt = [singCode indexOfObject:[inParseInfo substringWithRange:(NSMakeRange(5, 1))]];
    if( workingInt == NSNotFound ) workingInt = 3;
    switch (workingInt)
    {
        case 0: [grammarStore replaceObjectAtIndex:1 withObject:@"1"]; break;
        case 1:
        case 2:
            if( parseCode == 7 ) parseCode = 8;
            else parseCode += 3;
            [grammarStore replaceObjectAtIndex:1 withObject:@"2"];
            break;
        default: break;
    }
    targetChar = [[NSString alloc] initWithString:[inParseInfo substringWithRange:(NSMakeRange(1, 1))]];
    workingInt = [tenseCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 6;
    if( workingInt < 6 )
    {
        parseCode += (++workingInt) * 10;
        [grammarStore replaceObjectAtIndex:4 withObject:[self integerString:workingInt]];
    }
    targetChar = [[NSString alloc] initWithString:[inParseInfo substringWithRange:(NSMakeRange(3, 1))]];
    workingInt = [moodCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 6;
    if( workingInt < 6 )
    {
        parseCode += (++workingInt) * 100;
        [grammarStore replaceObjectAtIndex:5 withObject:[self integerString:workingInt]];
    }
    targetChar = [[NSString alloc] initWithString:[inParseInfo substringWithRange:(NSMakeRange(2, 1))]];
    workingInt = [voiceCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 3;
    if( workingInt < 3 )
    {
        parseCode += (++workingInt) * 1000;
        [grammarStore replaceObjectAtIndex:6 withObject:[self integerString:workingInt]];
    }
    targetChar = [[NSString alloc] initWithString:[inParseInfo substringWithRange:(NSMakeRange(4, 1))]];
    workingInt = [caseCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 5;
    if( workingInt < 5 )
    {
        parseCode += (++workingInt) * 10000;
        [grammarStore replaceObjectAtIndex:2 withObject:[self integerString:workingInt]];
    }
    targetChar = [[NSString alloc] initWithString:[inParseInfo substringWithRange:(NSMakeRange(6, 1))]];
    workingInt = [genderCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 3;
    if( workingInt < 3 )
    {
        parseCode += (++workingInt) * 100000;
        [grammarStore replaceObjectAtIndex:3 withObject:[self integerString:workingInt]];
    }
    grammarBreakdown = [[NSArray alloc] initWithArray:grammarStore];
    switch ([[grammarBreakdown objectAtIndex:4] integerValue])
    {
        case 1:
        case 2: principalPartCode = 1; break;  // Present or Imperfect - of any voice
        case 3:  // Aorist
            if ([[grammarBreakdown objectAtIndex:6] integerValue] < 3) principalPartCode = 3;  // Active or middle
            else principalPartCode = 6;  // Passive
            break;
        case 4:
        case 5:  // Perfect and Pluperfect
            if ([[grammarBreakdown objectAtIndex:6] integerValue] == 1) principalPartCode = 4; // Active
            else principalPartCode = 5; // Middle or Passive
            break;
        case 6:  // Future
            if ([[grammarBreakdown objectAtIndex:6] integerValue] < 3) principalPartCode = 2;  // Active or Middle
            else principalPartCode = 6;  // Passive
            break;
    }
    return parseCode;
}

- (NSInteger) getLXXParseInfo: (NSString *) inParseInfo
{
    /*=================================================================================================================*
     *                                                                                                                 *
     *                                            getLXXParseInfo                                                      *
     *                                            ===============                                                      *
     *                                                                                                                 *
     *  Decode the Parse Code for LXX source data and convert it into an integer value that uniquely identifies its    *
     *  grammatical function.  The numeric code is formed as follows:                                                  *
     *                                                                                                                 *
     *    Person:  1, 2 or 3 according to person                                                                       *
     *             Plural: add 3 to person value                                                                       *
     *             If the source code is -, Singular = 7 and Plural = 8                                                *
     *    Tense:   Add 1 - 6 times 10, (so Present adds 10, imperfect adds 20, aorist adds 30, etc.)                   *
     *    Mood:    add 1 - 6 times 100, (so indicative adds 100, imperative adds 200, etc.)                            *
     *    Voice:   add 1 - 3 times 1000, according to voice                                                            *
     *    Case:    add 1 - 5 times 10000, according to case                                                            *
     *    Gender:  add 1 - 3 times 100000, according to gender                                                         *
     *                                                                                                                 *
     *  The method also adds the same coded values to grammarStore and uses this information to identify the principal *
     *  part related to the specific word form.                                                                        *
     *                                                                                                                 *
     *=================================================================================================================*/

    const NSInteger grammarCategories = 7;
    
    bool is7 = false;
    NSInteger idx, workingInt, wordLength, parseCode = 0;
    NSString *targetChar;
    NSArray *numberCode = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"-", nil];
    NSArray *singCode = [[NSArray alloc] initWithObjects:@"S", @"D", @"P", @"-", nil];
    NSArray *caseCode = [[NSArray alloc] initWithObjects:@"N", @"V", @"A", @"G", @"D", @"-", nil];
    NSArray *genderCode = [[NSArray alloc] initWithObjects:@"M", @"N", @"F", @"-", nil];
    NSArray *tenseCode = [[NSArray alloc] initWithObjects:@"P", @"I", @"A", @"X", @"Y", @"F", @"-", nil];
    NSArray *moodCode = [[NSArray alloc] initWithObjects:@"I", @"D", @"S", @"O", @"N", @"P", @"-", nil];
    NSArray *voiceCode = [[NSArray alloc] initWithObjects:@"A", @"M", @"P", @"-", nil];
    NSMutableArray *grammarStore = [[NSMutableArray alloc] init];
    NSMutableString *revisedCode;
    
    for( idx = 0; idx < grammarCategories; idx++)
    {
        [grammarStore addObject:[self integerString:0]];
    }
    // Ensure the code is always 6 characters in length
    wordLength = [inParseInfo length];
    revisedCode = [[NSMutableString alloc] initWithString:inParseInfo];
    for( idx = wordLength; idx <= 6; idx++) [revisedCode appendString:@"-"];
    
    targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(0, 1))]];
    workingInt = [tenseCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 6;
    if( workingInt < 6 )
    {
        parseCode += (++workingInt) * 10;
        [grammarStore replaceObjectAtIndex:4 withObject:[self integerString:workingInt]];
    }
    targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(1, 1))]];
    workingInt = [voiceCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 3;
    if( workingInt < 3 )
    {
        parseCode += (++workingInt) * 1000;
        [grammarStore replaceObjectAtIndex:6 withObject:[self integerString:workingInt]];
    }
    targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(2, 1))]];
    workingInt = [moodCode indexOfObject:targetChar];
    if( workingInt == NSNotFound ) workingInt = 7;
    if( workingInt < 6 )
    {
        parseCode += (++workingInt) * 100;
        [grammarStore replaceObjectAtIndex:5 withObject:[self integerString:workingInt]];
    }
    if( workingInt == 6 ) // i.e. we're looking at a participle
    {
        targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(3, 1))]];
        workingInt = [caseCode indexOfObject:targetChar];
        if( workingInt == NSNotFound ) workingInt = 5;
        if( workingInt < 5 )
        {
            parseCode += (++workingInt) * 10000;
            [grammarStore replaceObjectAtIndex:2 withObject:[self integerString:workingInt]];
        }
        targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(4, 1))]];
        workingInt = [singCode indexOfObject:targetChar];
        if( workingInt == NSNotFound ) workingInt = 3;
        switch (workingInt)
        {
            case 0:
                parseCode += 7;
                [grammarStore replaceObjectAtIndex:1 withObject:@"1"]; break;
            case 1:
            case 2:
                parseCode += 8;
                [grammarStore replaceObjectAtIndex:1 withObject:@"2"];
                break;
            default: break;
        }
        targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(5, 1))]];
        workingInt = [genderCode indexOfObject:targetChar];
        if( workingInt == NSNotFound ) workingInt = 3;
        if( workingInt < 3 )
        {
            parseCode += (++workingInt) * 100000;
            [grammarStore replaceObjectAtIndex:3 withObject:[self integerString:workingInt]];
        }
    }
    else
    {
        targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(3, 1))]];
        // Use the reference array, numberCode, to identify an associated integer value
        workingInt = [numberCode indexOfObject:targetChar];
        // Handle exceptions
        if( workingInt == NSNotFound ) workingInt = 3;
        // Store the found number in grammarStore (or zero for "-" or errors)
        if( workingInt < 3 ) [grammarStore replaceObjectAtIndex:0 withObject:targetChar];
        else [grammarStore replaceObjectAtIndex:0 withObject:@"0"];
        // Start calculating the parseCode
        if( workingInt < 3) parseCode += ++workingInt;
        else
        {
            parseCode += 7;
            is7 = true;
        }
        // Now for plurals - these are not like all that follows
        targetChar = [[NSString alloc] initWithString:[revisedCode substringWithRange:(NSMakeRange(4, 1))]];
        workingInt = [singCode indexOfObject:targetChar];
        if( workingInt == NSNotFound ) workingInt = 3;
        switch (workingInt)
        {
            case 0: [grammarStore replaceObjectAtIndex:1 withObject:@"1"]; break;
            case 1:
            case 2:
                if( is7 ) ++parseCode;
                else parseCode += 3;
                [grammarStore replaceObjectAtIndex:1 withObject:@"2"];
                break;
            default: break;
        }
    }
    grammarBreakdown = [[NSArray alloc] initWithArray:grammarStore];
    switch ([[grammarBreakdown objectAtIndex:4] integerValue])
    {
        case 1:
        case 2: principalPartCode = 1; break;
        case 3:
            if ([[grammarBreakdown objectAtIndex:6] integerValue] < 3) principalPartCode = 3;
            else principalPartCode = 6;
            break;
        case 4:
        case 5:
            if ([[grammarBreakdown objectAtIndex:6] integerValue] == 1) principalPartCode = 4;
            else principalPartCode = 5;
            break;
        case 6:
            if ([[grammarBreakdown objectAtIndex:6] integerValue] < 3) principalPartCode = 2;
            else principalPartCode = 6;
            break;
    }
    return parseCode;
}

@end
