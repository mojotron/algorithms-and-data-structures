# ALGORITHMS

## Linear Search
Linear search or sequential search is a method for finding a target value within a list. It sequentially checks each element of the list for the target value until a match is found or until all the elements have been searched. For a list with n items, the best case is when the value is equal to the first element of the list, in which case only one comparison is needed. The worst case is when the value is not in the list (or occurs only once at the end of the list), in which case n comparisons are needed. Learn more on [wikipedia](https://en.wikipedia.org/wiki/Linear_search).

## Binary Search
Is a search algorithm that finds the position of a target value within a sorted array. Binary search compares the target value to the middle element of the array. If they are not equal, the half in which the target cannot lie is eliminated and the search continues on the remaining half, again taking the middle element to compare to the target value, and repeating this until the target value is found. If the search ends with the remaining half being empty, the target is not in the array. Even though the idea is simple, implementing binary search correctly requires attention to some subtleties about its exit conditions and midpoint calculation.
Binary search runs in logarithmic time in the worst case, making O(log n) comparisons, where n is the number of elements in the array, the O is Big O notation, and log is the logarithm. Binary search takes constant (O(1)) space, meaning that the space taken by the algorithm is the same for any number of elements in the array. Learn more on [wikipedia](https://en.wikipedia.org/wiki/Binary_search_algorithm).

## Insertion Sort
Insertion sort is a simple sorting algorithm that builds the final sorted array (or list) one item at a time. Insertion sort iterates, consuming one input element each repetition, and growing a sorted output list. At each iteration, insertion sort removes one element from the input data, finds the location it belongs within the sorted list, and inserts it there. It repeats until no input elements remain.
The best case input is an array that is already sorted. In this case insertion sort has a linear running time (i.e., O(n)). During each iteration, the first remaining element of the input is only compared with the right-most element of the sorted subsection of the array.
The simplest worst case input is an array sorted in reverse order. The set of all worst case inputs consists of all arrays where each element is the smallest or second-smallest of the elements before it. In these cases every iteration of the inner loop will scan and shift the entire sorted subsection of the array before inserting the next element. This gives insertion sort a quadratic running time (i.e., O(n2)). Learn more on [wikipedia](https://en.wikipedia.org/wiki/Insertion_sort).

## Bubble Sort
 Is a simple sorting algorithm that repeatedly steps through the list to be sorted, compares each pair of adjacent items and swaps them if they are in the wrong order. The pass through the list is repeated until no swaps are needed, which indicates that the list is sorted. Bubble sort has a worst-case and average complexity of О(n2), where n is the number of items being sorted. The only significant advantage that bubble sort has over most other algorithms, even quicksort, but not insertion sort, is that the ability to detect that the list is sorted efficiently is built into the algorithm. Learn more on [wikipedia](https://en.wikipedia.org/wiki/Bubble_sort).

 ## Selection Sort
 In computer science, selection sort is a sorting algorithm, specifically an in-place comparison sort. It has O(n2) time complexity, making it inefficient on large lists. The algorithm divides the input list into two parts: the sublist of items already sorted, which is built up from left to right at the front (left) of the list, and the sublist of items remaining to be sorted that occupy the rest of the list. Initially, the sorted sublist is empty and the unsorted sublist is the entire input list. The algorithm proceeds by finding the smallest (or largest, depending on sorting order) element in the unsorted sublist, exchanging (swapping) it with the leftmost unsorted element (putting it in sorted order), and moving the sublist boundaries one element to the right. Learn more on [wikipedia](https://en.wikipedia.org/wiki/Selection_sort).

 ## Merge Sort
 An efficient, general-purpose, comparison-based sorting algorithm. Most implementations produce a stable sort, which means that the implementation preserves the input order of equal elements in the sorted output. Merge sort is a divide and conquer algorithm.
 Conceptually, a merge sort works as follows:
1. Divide the unsorted list into n sublists, each containing 1 element (a list of 1 element is considered sorted).
2. Repeatedly merge sublists to produce new sorted sublists until there is only 1 sublist remaining. This will be the sorted list.
In sorting n objects, merge sort has an average and worst-case performance of O(n log n). Merge helper method takes time 0(n). Learn more on [wikipedia](https://en.wikipedia.org/wiki/Merge_sort).

## Maximum Subarray Algorithm
1. Brute Force Solution
Brute force is a general problem-solving technique which basically checks all possible solutions. It has O(n2) time complexity for this algorithm.
2. Divide and Conquer Solution
Using Divide and Conquer approach, we can find the maximum subarray sum in O(nLogn) time.
First, Divide the given array in two halves. Second, eturn the maximum of following three:
a. Maximum subarray sum in left half (Make a recursive call)
b. Maximum subarray sum in right half (Make a recursive call)
c. Maximum subarray sum such that the subarray crosses the midpoint

So we can divide the array up into three bits and look at each in turn to see where the largest pieces are, then compare them.
Learn more on [Geeks-for-geeks](https://www.geeksforgeeks.org/maximum-subarray-sum-using-divide-and-conquer-algorithm/), and on [Amber Wilkie](https://medium.com/craft-academy/intro-to-algorithms-chapter-four-the-maximum-sub-array-problem-7d02b178b55c) great blog post.
3. Solution with Kadane's Algorithm
Kadane's algorithm is based on splitting up the set of possible solutions into mutually exclusive (disjoint) sets. It exploits the fact that any solution (i.e., any member of the set of solutions) will always have a last element i {\displaystyle i} i (this is what is meant by "sum ending at position i {\displaystyle i} i"). Thus, we simply have to examine, one by one, the set of solutions whose last element's index is 1 {\displaystyle 1} 1, the set of solutions whose last element's index is 2 {\displaystyle 2} 2, then 3 {\displaystyle 3} 3, and so forth to n {\displaystyle n} n. It turns out that this process can be carried out in linear time. The runtime complexity of Kadane's algorithm is O ( n ) {\displaystyle O(n)} O(n). Learn more on [wikipedia](https://en.wikipedia.org/wiki/Maximum_subarray_problem).