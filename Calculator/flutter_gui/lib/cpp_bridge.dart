import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:path/path.dart' as p;

// Typedefs for the C++ functions
typedef AdditionNative = ffi.Double Function(ffi.Double, ffi.Double);
typedef Addition = double Function(double, double);

typedef SubtractionNative = ffi.Double Function(ffi.Double, ffi.Double);
typedef Subtraction = double Function(double, double);

typedef MultiplicationNative = ffi.Double Function(ffi.Double, ffi.Double);
typedef Multiplication = double Function(double, double);

typedef DivisionNative = ffi.Double Function(ffi.Double, ffi.Double);
typedef Division = double Function(double, double);

typedef FactorialNative = ffi.Int32 Function(ffi.Int32);
typedef Factorial = int Function(int);

typedef PowerNative = ffi.Double Function(ffi.Double, ffi.Double);
typedef Power = double Function(double, double);

class CppBridge {
  late ffi.DynamicLibrary nativeLib;
  
  late Addition addition;
  late Subtraction subtraction;
  late Multiplication multiplication;
  late Division division;
  late Factorial factorial;
  late Power power;

  CppBridge() {
    // Load the library
    final String libPath = _getLibraryPath();
    nativeLib = ffi.DynamicLibrary.open(libPath);

    // Look up functions
    addition = nativeLib
        .lookup<ffi.NativeFunction<AdditionNative>>('Addition')
        .asFunction();
        
    subtraction = nativeLib
        .lookup<ffi.NativeFunction<SubtractionNative>>('Substraction')
        .asFunction();
        
    multiplication = nativeLib
        .lookup<ffi.NativeFunction<MultiplicationNative>>('Multiplication')
        .asFunction();
        
    division = nativeLib
        .lookup<ffi.NativeFunction<DivisionNative>>('Division')
        .asFunction();
        
    factorial = nativeLib
        .lookup<ffi.NativeFunction<FactorialNative>>('Factorial')
        .asFunction();
        
    power = nativeLib
        .lookup<ffi.NativeFunction<PowerNative>>('Power')
        .asFunction();
  }

  String _getLibraryPath() {
    final String currentDir = Directory.current.path;
    if (Platform.isMacOS) {
      return p.join(currentDir, 'libarith.dylib');
    } else if (Platform.isWindows) {
      return p.join(currentDir, 'libarith.dll');
    } else {
      return p.join(currentDir, 'libarith.so');
    }
  }
}
