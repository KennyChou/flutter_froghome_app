import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';

import '../data/services/dbservices.dart';
import '../modules/About/about_binding.dart';
import '../modules/About/about_view.dart';
import '../modules/Help/help_binding.dart';
import '../modules/Help/help_view.dart';
import '../modules/LinkPage/link_page_binding.dart';
import '../modules/LinkPage/link_page_view.dart';
import '../modules/PlotEdit/plot_edit_binding.dart';
import '../modules/PlotEdit/plot_edit_view.dart';
import '../modules/PlotList/plot_list_binding.dart';
import '../modules/PlotList/plot_list_view.dart';
import '../modules/RecordEdit/record_edit_binding.dart';
import '../modules/RecordEdit/record_edit_view.dart';
import '../modules/RecordList/record_list_binding.dart';
import '../modules/RecordList/record_list_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';

part 'app_routes.dart';

class CheckPlotMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    // await Future.delayed(Duration(milliseconds: 500));

    if (DBService.plot.values.isEmpty) {
      return GetNavConfig.fromRoute(Routes.PLOT_LIST);
    }
    return await super.redirectDelegate(route);
  }
}

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          name: _Paths.RECORD_LIST,
          page: () => const RecordListView(),
          binding: RecordListBinding(),
          middlewares: [
            CheckPlotMiddleware(),
          ],
          children: [
            GetPage(
              name: _Paths.RECORD_EDIT,
              participatesInRootNavigator: true,
              page: () => const RecordEditView(),
              binding: RecordEditBinding(),
            ),
          ],
        ),
        GetPage(
            name: _Paths.PLOT_LIST,
            title: '樣區設定',
            page: () => const PlotListView(),
            binding: PlotListBinding(),
            children: [
              GetPage(
                name: _Paths.PLOT_EDIT,
                participatesInRootNavigator: true,
                page: () => const PlotEditView(),
                binding: PlotEditBinding(),
              ),
            ]),
        GetPage(
          name: _Paths.ABOUT,
          title: '關於程式',
          page: () => const AboutView(),
          binding: AboutBinding(),
        ),
        GetPage(
          name: _Paths.HELP,
          title: '系統設定',
          page: () => const HelpView(),
          binding: HelpBinding(),
        ),
        GetPage(
          name: _Paths.LINK_PAGE,
          title: '相關連結',
          page: () => const LinkPageView(),
          binding: LinkPageBinding(),
        ),
      ],
    ),
  ];
}
