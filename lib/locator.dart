import 'package:get_it/get_it.dart';
import 'package:lambda/modules/agent/agent_util.dart';
import 'package:lambda/modules/gcm/notify.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:youth/core/services/aimag_news_service.dart';
import 'package:youth/core/services/resolution_service.dart';
import 'package:youth/core/services/volunteer_work_service.dart';
import 'package:youth/core/viewmodels/aimag_news_model.dart';
import 'package:youth/core/viewmodels/resolution_model.dart';
import 'package:youth/core/viewmodels/volunteer_work_model.dart';
import 'core/services/aimag_service.dart';
import 'core/services/faq_service.dart';
import 'core/services/home_service.dart';
import 'core/services/movie_service.dart';
import 'core/services/national_council_service.dart';
import 'core/services/soum_service.dart';
import 'core/services/staff_service.dart';
import 'core/services/user_service.dart';
import 'core/services/video_service.dart';
import 'core/services/api.dart';
import 'core/viewmodels/aimag_model.dart';
import 'core/viewmodels/base_model.dart';
import 'core/viewmodels/faq_model.dart';
import 'core/viewmodels/job_model.dart';
import 'core/viewmodels/slide_model.dart';
import 'core/viewmodels/soum_model.dart';
import 'core/viewmodels/staff_model.dart';
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
  locator.registerLazySingleton(() => AimagService());
  locator.registerLazySingleton(() => SoumService());
  locator.registerLazySingleton(() => StaffService());
  locator.registerLazySingleton(() => AimagNewsService());
  locator.registerLazySingleton(() => ResolutionService());
  locator.registerLazySingleton(() => VolunteerWorkService());

  //App view models for busines logic
  locator.registerFactory(() => BaseModel());
  locator.registerFactory(() => VideoModel());
  locator.registerFactory(() => FaqModel());
  locator.registerFactory(() => SlidesModel());
  locator.registerFactory(() => UserModel());
  locator.registerFactory(() => JobModel());
  locator.registerFactory(() => NationalCouncilModel());
  locator.registerFactory(() => AimagModel());
  locator.registerFactory(() => SoumModel());
  locator.registerFactory(() => StaffModel());
  locator.registerFactory(() => AimagNewsModel());
  locator.registerFactory(() => ResolutionModel());
  locator.registerFactory(() => VolunteerWorkModel());
}
