import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'common/network/network_info.dart';
import 'presentation/modules/bottom_nav_layout/search/repo/movies_repo.dart';
import 'presentation/modules/bottom_nav_layout/search/view_model/movies_view_model.dart';
import 'presentation/modules/bottom_nav_layout/time_off/repo/repo.dart';
import 'presentation/modules/bottom_nav_layout/time_off/view_model/time_off_view_model.dart';

GetIt sl = GetIt.instance;
setupServiceLocator() {
  sl.registerFactory(() => TimeOffViewModel(sl<TimeOffServices>()));
  sl.registerLazySingleton<TimeOffServices>(() => TimeOffServicesImpl());
  
  sl.registerFactory(() => MoviesViewModel(sl<MoviesSevice>()));
  sl.registerLazySingleton<MoviesSevice>(() => MoviesSeviceImpl());

  // Core
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => Connectivity());
}
