import Foundation

func normalise(_ input: String) -> String {
    return input.lowercased().replacingOccurrences(of: " ", with: "")
}

extension String {
    func isAnagramOf(_ s: String) -> Bool {
        return normalise(self).sorted() == normalise(s).sorted()
    }
    
    func isPalindrome() -> Bool {
        let forward = normalise(self)
        let reverse = String(forward.reversed())
        return  forward == reverse
    }
}
