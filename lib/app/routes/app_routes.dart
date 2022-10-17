part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const RECORD_LIST = _Paths.RECORD_LIST;
  static const PLOT_LIST = _Paths.PLOT_LIST;
  static String PLOT_EDIT(int plot) => '${_Paths.PLOT_LIST}/edit/$plot';
  static String RECORD_EDIT(int logKey) => '${_Paths.RECORD_LIST}/edit/$logKey';
  static String RECORD_STATE(int logKey) =>
      '${_Paths.RECORD_LIST}/edit/$logKey/state';
  static const ABOUT = _Paths.ABOUT;
  static const HELP = _Paths.HELP;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/';
  static const RECORD_LIST = '/record-list';
  static const PLOT_LIST = '/plot-list';
  static const PLOT_EDIT = '/edit/:key';
  static const RECORD_EDIT = '/edit/:logKey';
  static const RECORD_STATE = '/state';
  static const ABOUT = '/about';
  static const HELP = '/help';
}
