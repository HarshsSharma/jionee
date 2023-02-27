import 'package:get_it/get_it.dart';

import 'presentation/modules/bottom_nav_layout/time_off/repo/repo.dart';
import 'presentation/modules/bottom_nav_layout/time_off/view_model/time_off_view_model.dart';

GetIt sl = GetIt.instance;
setupServiceLocator() {
  sl.registerFactory(() => TimeOffViewModel(sl<TimeOffServices>()));
  sl.registerLazySingleton<TimeOffServices>(() => TimeOffServicesImpl());
}
