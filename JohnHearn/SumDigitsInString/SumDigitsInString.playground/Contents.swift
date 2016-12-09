//: Playground - noun: a place where people can play

import Foundation

func sumDigits(_ str: String) -> Int{
    return str.characters
              .flatMap{ Int(String($0)) }
              .reduce(0, +)
}


var str = "1a2b3c4d,5"
var str2 = "31-9874  peijgh`-47ytf`f -h7f`v`7    h   7`g5=hv`48348t4983t3987t-1938yg17-h5g-h17b197hv1-75"

sumDigits(str)
sumDigits(str2)













