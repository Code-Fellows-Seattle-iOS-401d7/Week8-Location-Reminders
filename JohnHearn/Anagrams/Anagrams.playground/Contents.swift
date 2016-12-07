//: Playground - noun: a place where people can play

import Foundation

extension String {
    var removePunctuation: String {
        return components(separatedBy: .punctuationCharacters).joined(separator: "")
    }
    var removeWhitespace: String {
        return components(separatedBy: .whitespaces).joined(separator: "")
    }

    var condensed: String {
        return lowercased()
               .removeWhitespace
               .removePunctuation
               .characters
               .sorted()
               .reduce("", {$0 + String($1) })
    }
}

func anagram(_ str1: String, _ str2: String ) -> Bool{
    return str1.condensed == str2.condensed
}

let resistance = "resistance"
let ancestries = "ancestries"

let poem1 =
        "The Little Boy and the Old Man" +
        "Shel Silverstein" +

        "Said the little boy, 'Sometimes I drop my spoon.'" +
        "Said the old man, 'I do that too.'" +
        "The little boy whispered, 'I wet my pants.'" +
        "'I do that too,' laughed the little old man." +
        "Said the little boy, 'I often cry.'" +
        "The old man nodded, 'So do I.'" +
        "'But worst of all,' said the boy, 'it seems" +
        "Grown-ups don't pay attention to me.'" +
        "And he felt the warmth of a wrinkled old hand." +
        "'I know what you mean,' said the little old man."

let poem2 =
        "The Tot and the Elder" +
        "Olin Foblioso & Billy Foblioso" +

        "The tiny tot went: 'When I eat I mess up.'" +
        "The elder replied: 'O, that makes two of us.'" +
        "'I soil myself,' went the tot with shame" +
        "And the elder added: 'O, I do the same.'" +
        "On the tot told him: 'I sob a lot.'" +
        "'O, not only you,' answered gramps to the tot." +
        "'And what's totally bad,' the tiny tot told," +
        "'I think mom and dad don't love me at all.'" +
        "While grandpa simply, pitiably smiled," +
        "then said: 'O, I understand, my child.' "

anagram(poem1, poem2)
anagram(resistance, ancestries)

//    print(poem1.condensed)
//    print(poem2.condensed)


