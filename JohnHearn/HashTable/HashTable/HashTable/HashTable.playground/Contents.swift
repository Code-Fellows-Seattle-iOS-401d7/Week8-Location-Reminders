import Foundation

func getNext(_ prime: Int) -> Int {
    // Returns a prime roughly twice the size of the current table size.
    // (Outside class so we can use it in the initializer.)
    switch prime {
        case 53:       return 107
        case 107:      return 223
        case 223:      return 443
        case 443:      return 883
        case 883:      return 1759
        case 1759:     return 3511
        case 3511:     return 7013
        case 7013:     return 14009
        case 14009:    return 28001
        case 28001:    return 56003
        case 56003:    return 111997
        case 111997:   return 224011
        case 224011:   return 448003
        case 448003:   return 896003
        case 896003:   return 1889999
        case 1889999:  return 3780017
        case 3780017:  return 7560013
        case 7560013:  return 15120011
        case 15120011: return 30240013
        default: return 0;
    }
}

public class HashTable {
    public typealias Element = (key:String, value:String)
    public typealias Bucket = [Element]
    private(set) public var buckets: [Bucket]
    private(set) public var elementCount = 0
    private(set) public var collisions = 0
    private(set) public var maxChain = 0
    private(set) public var numberOfExpansions = 0
    public var loadFactor: Double {
        return Double(elementCount)/Double(buckets.count)
    }
    public let kMaxLoadFactor: Double;


    public var isEmpty: Bool { return elementCount == 0 }

    public init?(_ capacity: Int = 53, max loadFactor: Double? = 0.5) {
        kMaxLoadFactor = loadFactor!
        var prime = 53
        if capacity < 1 || capacity > 30240013 { return nil }

        while prime < capacity {
            prime = getNext(prime);
        }

        buckets = Array<Bucket>(repeatElement([], count: prime))
    }

    func insert(_ element: Element) {
        let index = hash(element.key)

        if(!find(element.key)){
            buckets[index].append(element)
            elementCount += 1
            if buckets[index].count > 1 {
                collisions += 1
            }

            if buckets[index].count > maxChain {
                maxChain = buckets[index].count
            }

        } else {
            for (ii, e) in buckets[index].enumerated() {
                if element.key == e.key {
                    buckets[index][ii].value = element.value
                    break
                }
            }
        }

        if loadFactor > kMaxLoadFactor {   // Check to see if we need to expand the hash
            doubleSize();                  // table to maintain the desired load factor
        }
    }

    func remove(_ key: String) {
        let index = hash(key)

        if(find(key)){
            for ii in buckets[index].indices {
                buckets[index].remove(at: ii)
            }
            if buckets[index].count >= 1 {
                collisions -= 1
            }
            if maxChain == buckets[index].count + 1{
                //TODO: possibly recompute maxChain
            }
        }
    }

    func find(_ key: String) -> Bool {
        let index = hash(key)

        for e in buckets[index] {
            if key == e.key {
                return true
            }
        }

        return false
    }

    private func hash(_ key: String) -> Int {
        return key.hash % buckets.count
    }

    private func doubleSize() {
        let prime = getNext(buckets.count)

        let newTable = HashTable(prime, max: kMaxLoadFactor) // Might need var instead of let

        for bucket in buckets {
            for element in bucket {
                newTable!.insert(element)
            }
        }

        buckets = newTable!.buckets
        elementCount = newTable!.elementCount
        collisions = newTable!.collisions
        maxChain = newTable!.maxChain
        numberOfExpansions = newTable!.numberOfExpansions + 1
    }
}


var myHashTable = HashTable(53)

var myElement = (key:"Foo", value:"Bar")

"Foo".hash % 53

myHashTable!.insert(myElement)

myHashTable!.buckets[52]

myHashTable!.find(myElement.key)

var el = (key:"Foo", value:"Bat")

myHashTable!.insert(el)

myHashTable!.buckets[52]

myHashTable!.find(el.key)

for ii in 0...250 {
    var el = (key:"\(ii)", value:"\(2*ii)")
    myHashTable!.insert(el)
}

myHashTable!.numberOfExpansions
myHashTable!.elementCount
myHashTable!.loadFactor
myHashTable!.collisions
myHashTable!.maxChain













