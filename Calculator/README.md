# Hybrid C++ & Flutter Calculator

A professional, cross-platform calculator application that combines a high-performance C++ mathematical backend with a modern Flutter user interface.

## Project Structure

- **`calculations/`**: Contains the C++ source code.
  - `arithmetics.cpp`: Core mathematical implementations with C-linkage.
  - `calc.h`: Header file for the arithmetic functions.
  - `lib/main.dart`: Main application UI and logic.
  - `lib/cpp_bridge.dart`: Dart-FFI bridge to the C++ backend.
- **`Makefile`**: Automates the build process.

## Prerequisites

- **C++ Compiler**: `g++`.
- **Flutter SDK**: Required to build and run the GUI.
  - On macOS: `brew install --cask flutter`

## Build & Run Instructions

1. **Build the C++ Backend**:
   ```bash
   make lib
   ```
2. **Run the Flutter App**:
   ```bash
   ./calc
   ```
   *Note: This requires the Flutter SDK to be installed.*

## Features

- **Standard Operations**: Addition, Subtraction, Multiplication, Division.
- **Rich Text Superscripts**: Exponents are rendered as true superscripts.
- **C++ Powered**: All math is handled by the high-performance C++ engine.
