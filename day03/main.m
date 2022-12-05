#import <Foundation/Foundation.h>

int getValueForChar(unichar character) {
    BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:character];
    if (isUppercase) {
        return character - 38; // 65 is A uppercase ascii
    } else {
        return character - 96; // 97 is a lowercase ascii
    }
}

void partOne(void) {
    NSString *path = @"input.txt";
    NSString *fh = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    int sum = 0;
    for (NSString *line in [fh componentsSeparatedByCharactersInSet:NSCharacterSet.newlineCharacterSet]) {
        if ([line length] == 0) {
            break;
        }
        NSUInteger rucksackLength = [line length];
        NSString *firstCompartment = [line substringToIndex:rucksackLength / 2];
        NSString *secondCompartment = [line substringFromIndex:rucksackLength / 2];
        
        NSCharacterSet *firstCompartmentSet = [NSCharacterSet characterSetWithCharactersInString:firstCompartment];
        NSRange range = [secondCompartment rangeOfCharacterFromSet:firstCompartmentSet options:NSLiteralSearch];
        unichar commonChar = [[secondCompartment substringWithRange:range] characterAtIndex:0]; // common item type
        
        int charValue = getValueForChar(commonChar);
        sum += charValue;
        //NSLog(@"%d", charValue);
    }
    NSLog(@"The sum of the priorities of the item types for the first puzzle is: %d", sum);
}

void partTwo(void) {
    NSString *path = @"input.txt";
    NSString *fh = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSMutableArray *lineArray = [NSMutableArray array];
    for (NSString *line in [fh componentsSeparatedByCharactersInSet:NSCharacterSet.newlineCharacterSet]) {
        if ([line length] == 0) {
            break;
        }
        [lineArray addObject:line];
    }
    
    int sum = 0;
    for (int i = 0; i < lineArray.count; i += 3) {
        NSString *one = [lineArray objectAtIndex:i];
        NSString *two = [lineArray objectAtIndex:i+1];
        NSString *third = [lineArray objectAtIndex:i+2];

        for (int j = 0 ; j < [one length]; j++) {
            unichar oneChar = [one characterAtIndex:j];
            for (int x = 0; x < [two length]; x++) {
                unichar twoChar = [two characterAtIndex:x];
                for (int z = 0; z < [third length]; z++) {
                    unichar thirdChar = [third characterAtIndex:z];
                    if (oneChar == twoChar && twoChar == thirdChar) {
                        sum += getValueForChar(oneChar);
                        goto outer;
                    }
                }
            }
        }
        outer:;
    }
    NSLog(@"The sum of the priorities of the item types for the second puzzle is: %d", sum);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        partOne();
        partTwo();
        
    }
    return 0;
}
