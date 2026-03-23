# Walkthrough - Calculator Fix

I have fixed the issue in [main.cpp](file:///Users/nchimunyamasenke/Projects/Calculator/cpp-mosular-arithmetic/Calculator/main.cpp) where the `option` variable was used before being initialized.

## Changes Made

### [Calculator](file:///Users/nchimunyamasenke/Projects/Calculator/cpp-mosular-arithmetic/Calculator)

#### [main.cpp](file:///Users/nchimunyamasenke/Projects/Calculator/cpp-mosular-arithmetic/Calculator/main.cpp)

Moved `cin >> option;` before the `if` statement to ensure the user's choice is captured before being checked.

```cpp
  cin >> option;
  if (option == 5) {
    cout << "Enter a number: ";
    cin >> num1;
  } else if (option >= 1 && option <= 4) {
    cout << "Enter num1: ";
    cin >> num1;
    cout << "Enter num2: ";
    cin >> num2;
  }
```

## Verification Results

### Automated Tests

- Compiled successfully using `g++ main.cpp arithmetics.cpp -o calc`.
- Verified Addition (option 1):
  - Input: `1`, `10`, `20`
  - Output: `Sum: 30`
- Verified Factorial (option 6):
  - Input: `6`, `5`
  - Output: `Factorial: 120`
- Verified Power (option 5):
  - Input: `5`, `1`, `-5` -> Output: `Power: 1`
  - Input: `5`, `2`, `-1` -> Output: `Power: 0`
  - Input: `5`, `2`, `3` -> Output: `Power: 8`

### Manual Verification

Correctly handles the input prompt based on the selected option:
- Option 6 asks for only one number.
- Options 1-5 ask for two numbers.
- Power function handles negative exponents without infinite recursion.
