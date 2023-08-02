package main

import "fmt"

func sumOfInt(input []int) int {
	inc := 0
	for _, val := range input {
		inc += val
	}
	return inc
}

type Number interface {
	int | int64
}

func sumOf[T Number](input []T) T {
	var inc T
	for _, v := range input {
		inc += v
	}
	return inc
}

func main() {

	fmt.Printf("%d\n", sumOfInt([]int{1, 2, 3}))
	fmt.Printf("%d\n", sumOf([]int{1, 2, 3, 5}))
}
