import 'matrix_filter.dart';

class MatrixColor {
  List<Filter> filters;

  MatrixColor._privateConstructor(){
    setColor();
  }

  static final MatrixColor _instance = MatrixColor._privateConstructor();

  static MatrixColor get instance => _instance;

  void setColor(){
    filters= new List<Filter>();
    filters.add(new Filter('None', NO_FILTER));
    filters.add(new Filter('VINTAGE', VINTAGE_MATRIX));
    filters.add(new Filter('SWEET', SWEET_MATRIX));
    filters.add(new Filter('lsd', lsd));
    filters.add(new Filter('OldTime', OldTime));
    filters.add(new Filter('SEPIUM', SEPIUM));
    filters.add(new Filter('SEPIA', SEPIA_MATRIX));
    filters.add(new Filter('MONO', MONOCHROME));
    filters.add(new Filter('GREYSCALE', GREYSCALE_MATRIX));
    filters.add(new Filter('INVERT', INVERT));
    filters.add(new Filter('blackWhite', blackAndWhite));
    filters.add(new Filter('negative', negative));
    filters.add(new Filter('toBGR', toBGR));
    filters.add(new Filter('MILK', MILK));
  }
}
class Filter{
  String name;
  List<double> values;
  double sat = 1;
  double bright = 0;
  double con = 1;
  double sepia = 1;
  Filter(String name, List<double> values)
  {
    this.name= name;
    this.values= values;
  }
}