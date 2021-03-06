# ALGORITHMS
This project is my algorithm training ground. Learning by solving classic problems.
Trying to comment all parts of code so it can helps understend tricky parts of execution, for fellow learners.

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
Kadane's algorithm is based on splitting up the set of possible solutions into mutually exclusive (disjoint) sets. It exploits the fact that any solution (i.e., any member of the set of solutions) will always have a last element i (this is what is meant by "sum ending at position i"). Thus, we simply have to examine, one by one, the set of solutions whose last element's index is 1, the set of solutions whose last element's index is 2, then 3, and so forth to n. It turns out that this process can be carried out in linear time. The runtime complexity of Kadane's algorithm is O (n). Learn more on [wikipedia](https://en.wikipedia.org/wiki/Maximum_subarray_problem).

## Matrix multiplication algorithm
1. Iterative algorithm
The definition of matrix multiplication is that if C = AB for an n × m matrix A and an m × p matrix B, then C is an n × p matrix with entries. Algorithm can be constructed which loops over the indices i from 1 through n and j from 1 through p, computing the above using a 3 nested loops. This algorithm takes time Θ(nmp) (in asymptotic notation) in which case the running time is Θ(n3), i.e., cubic.
2. Divide and conquer algorithm
Relies on the block partitioning, which works for all square matrices whose dimensions are powers of two, i.e., the shapes are 2n × 2n for some n. The matrix product is now which consists of eight multiplications of pairs of submatrices, followed by an addition step. The divide and conquer algorithm computes the smaller multiplications recursively, using the scalar multiplication c11 = a11 x b11 as its base case. The complexity of this algorithm is Θ(n3), the same as the iterative algorithm.
Learn more on [wikipedia](https://en.wikipedia.org/wiki/Matrix_multiplication_algorithm).
3. Strassens algorithm
The Strassen algorithm is using 7 multiplications instead of 8. 
The complexity of Strassen’s matrix multiplication algorithm is O(nlog7). 
Learn more on [wikipedia](https://en.wikipedia.org/wiki/Strassen_algorithm).

Great explanation from [Abdul Bari](https://www.youtube.com/watch?v=0oJyNmEbS4w).

## Fibonacci Number in Sequence
Fibonacci numbers are the numbers in the following integer sequence, called the Fibonacci sequence, and characterized by the fact that every number after the first two is the sum of the two preceding ones: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ....

1. Iterativ algorithm
Instead of storing values in an array, we can simply use two variables. This requires some swapping around of values so that everything stays in the appropriate places.
Iterativ algorithm has time complexity of O(n).
2. Recursive algorithm
Direct recursive implementation mathematical recurrence of general formula: F(n) = F(n-1) + F(n-2), has time complexity T(n) = T(n-1) + T(n-2), exponential.
3. Dynamic algorithm
This is an iterative algorithm (one that uses loops instead of recursion) so we analyze it a little differently than we would a recursive algorithm. Basically, we just have to compute for each line, how many times that line is executed, by looking at which loops it's in and how many times each loop is executed. Time complexity of O(n).
4. Matrix algorithm
Algorithm initializes a matrix M to the identity matrix (the "zeroth power" of A) and then repeatedly multiplies M by A to form the (n-1)st power. Then by the formula above, the top left corner holds F(n), the value we want to return. Time complexity of O(n).
5. Matrix recursive algorithm
Basically all the time is in helper method matrix_power(), which is recursive: it tries to compute the nth power of A by squaring the (n/2)th power. However if n is odd, rounding down n/2 and squaring that power of A results in the (n-1)st power, which we "fix up" by multiplying one more factor of A. Time complexity of O(logN).

Learn more on [wikipedia](https://en.wikipedia.org/wiki/Fibonacci_number).
Learn more on [Geeks-for-Geeks](https://www.geeksforgeeks.org/program-for-nth-fibonacci-number/).
Learn more on [UCI](https://www.ics.uci.edu/~eppstein/161/960109.html).
Learn more on [Tutorials Point](https://www.tutorialspoint.com/data_structures_algorithms/fibonacci_series.htm).
Learn more on [programming interviews](http://tech-queries.blogspot.com/2010/09/nth-fibbonacci-number-in-ologn.html). 

## Peek finding algorithm
