import 'package:get_it/get_it.dart';
import 'package:lambda/modules/agent/agent_util.dart';
import 'package:lambda/modules/gcm/notify.dart';
import 'package:lambda/modules/network_util.dart';
import 'core/services/faq_service.dart';
import 'core/services/home_service.dart';
import 'core/services/movie_service.dart';
import 'core/services/national_council_service.dart';
import 'core/services/user_service.dart';
import 'core/services/video_service.dart';
import 'core/services/api.dart';
import 'core/viewmodels/base_model.dart';
import 'core/viewmodels/faq_model.dart';
import 'core/viewmodels/job_model.dart';
import 'core/viewmodels/slide_model.dart';
import 'core/viewmodels/user_model.dart';
import 'core/viewmodels/video_model.dart';
import 'core/viewmodels/national_council_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  //Basic services
  locator.registerSingleton<Notify>(new Notify());
  locator.registerSingleton<AgentUtil>(new AgentUtil());
  locator.registerSingleton<NetworkUtil>(new NetworkUtil());

  //App services for data fetch
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => MovieService());
  locator.registerLazySingleton(() => VideoService());
  locator.registerLazySingleton(() => HomeService());
  locator.registerLazySingleton(() => FaqService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => NationalCouncilService());

  //App view models for busines logic
  locator.registerFactory(() => BaseModel());
  locator.registerFactory(() => VideoModel());
  locator.registerFactory(() => FaqModel());
  locator.registerFactory(() => SlidesModel());
  locator.registerFactory(() => UserModel());
  locator.registerFactory(() => JobModel());
  locator.registerFactory(() => NationalCouncilModel());
}
