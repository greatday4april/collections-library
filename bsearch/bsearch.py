from typing import List, Callable, Optional


def bsearch_low(arr: List[int], condition: Callable[[int], bool]) -> Optional[int]:
    low = 0
    high = len(arr)
    while low < high:
        mid = low + (high - low) // 2
        smaller = condition(arr[mid])
        # keep this upper-bound while trying lower upper-bound
        if smaller:
            high = mid
        else:
            low = mid + 1

    if low < 0 or low >= len(arr) or not condition(arr[low]):
        return None

    return low


def bsearch_high(arr: List[int], condition: Callable[[int], bool]) -> Optional[int]:
    low = 0
    high = len(arr)
    while low < high:
        mid = low + (high - low) // 2
        bigger = condition(arr[mid])
        # keep this lower-bound while trying higher lower-bound
        if bigger:
            low = mid
        else:
            high = mid - 1

    if low < 0 or low >= len(arr) or not condition(arr[low]):
        return None

    return low


if __name__ == '__main__':
    print(bsearch_low([], lambda ele: ele == 2))  # None
    print(bsearch_high([], lambda ele: ele == 2))  # None
    print(bsearch_low([1], lambda ele: ele == 2))  # None
    print(bsearch_low([1], lambda ele: ele == 2))  # None
    print('--------')

    print(bsearch_low([1, 2, 3, 4, 5, 6], lambda ele: ele == 4))  # 3
    print(bsearch_high([1, 2, 3, 4, 5, 6], lambda ele: ele == 4))  # 3
    print('--------')

    print(bsearch_low([1, 2, 4, 4, 4, 5], lambda ele: ele == 4))  # 2
    print(bsearch_low([1, 2, 4, 4, 4, 5], lambda ele: ele > 5))  # None
    print(bsearch_low([1, 2, 4, 4, 4, 5], lambda ele: ele >= 3))  # 2
    print('--------')

    print(bsearch_high([1, 2, 4, 4, 4, 5], lambda ele: ele == 4))  # 4
    print(bsearch_high([1, 2, 4, 4, 4, 5], lambda ele: ele <= 4))  # 4
    print('--------')

    print(bsearch_low([1, 2, 4, 4, 4, 5], lambda ele: ele <= 0))  # None
    print(bsearch_high([1, 2, 4, 4, 4, 5], lambda ele: ele > 5))  # None
