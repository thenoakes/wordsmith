package main

import (
	"sort"
	"strings"
)

func normalise(input string) string {
	return strings.ReplaceAll(strings.ToLower(input), " ", "")
}

type runes []rune

func (r runes) Len() int           { return len(r) }
func (r runes) Less(i, j int) bool { return r[i] < r[j] }
func (r runes) Swap(i, j int)      { r[i], r[j] = r[j], r[i] }

func sortString(w string) string {
	r := []rune(w)
	sort.Sort(runes(r))
	return string(r)
}

// Or:

// func sortString(w string) string {
// 	s := strings.Split(w, "")
// 	sort.Strings(s)
// 	return strings.Join(s, "")
// }

func AreAnagrams(s, t string) bool {
	return sortString(normalise(s)) == sortString(normalise(t))
}

// Inefficient but concise - find a better solution
func reverseStr(str string) (out string) {
	for _, s := range str {
			out = string(s) + out
	}

	return
}

func IsPalindrome (s string) bool {
	var forward = normalise(s)
	var reverse = reverseStr(forward)
	return forward == reverse
}