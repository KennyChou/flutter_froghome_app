import 'package:get/get.dart';

import '../modules/About/about_binding.dart';
import '../modules/About/about_view.dart';
import '../modules/Help/help_binding.dart';
import '../modules/Help/help_view.dart';
import '../modules/PlotEdit/plot_edit_binding.dart';
import '../modules/PlotEdit/plot_edit_view.dart';
import '../modules/PlotList/plot_list_binding.dart';
import '../modules/PlotList/plot_list_view.dart';
import '../modules/RecordEdit/record_edit_binding.dart';
import '../modules/RecordEdit/record_edit_view.dart';
import '../modules/RecordList/record_list_binding.dart';
import '../modules/RecordList/record_list_view.dart';
import '../modules/RecordState/record_state_binding.dart';
import '../modules/RecordState/record_state_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
          children: [
            GetPage(
                name: _Paths.RECORD_EDIT,
                participatesInRootNavigator: true,
                page: () => const RecordEditView(),
                binding: RecordEditBinding(),
                children: [
                  GetPage(
                    name: _Paths.RECORD_STATE,
                    participatesInRootNavigator: true,
                    page: () => const RecordStateView(),
                    binding: RecordStateBinding(),
                  ),
                ]),
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
          title: '操作說明',
          page: () => const HelpView(),
          binding: HelpBinding(),
        ),
      ],
    ),
  ];
}
