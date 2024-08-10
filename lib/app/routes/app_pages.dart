import 'package:get/get.dart';

import '../modules/admin_riwayat/bindings/admin_riwayat_binding.dart';
import '../modules/admin_riwayat/views/admin_riwayat_view.dart';
import '../modules/adminfaq/bindings/adminfaq_binding.dart';
import '../modules/adminfaq/views/adminfaq_view.dart';
import '../modules/adminhome/bindings/adminhome_binding.dart';
import '../modules/adminhome/views/adminhome_view.dart';
import '../modules/daftar/bindings/daftar_binding.dart';
import '../modules/daftar/views/daftar_view.dart';
import '../modules/daftarfaktaadmin/bindings/daftarfaktaadmin_binding.dart';
import '../modules/daftarfaktaadmin/views/daftarfaktaadmin_view.dart';
import '../modules/daftarmodel/bindings/daftarmodel_binding.dart';
import '../modules/daftarmodel/views/daftarmodel_view.dart';
import '../modules/fakta/bindings/fakta_binding.dart';
import '../modules/fakta/views/fakta_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lupaakun/bindings/lupaakun_binding.dart';
import '../modules/lupaakun/views/lupaakun_view.dart';
import '../modules/masuk/bindings/masuk_binding.dart';
import '../modules/masuk/views/masuk_view.dart';
import '../modules/modelrambutadmin/bindings/modelrambutadmin_binding.dart';
import '../modules/modelrambutadmin/views/modelrambutadmin_view.dart';
import '../modules/profile_admin/bindings/profile_admin_binding.dart';
import '../modules/profile_admin/views/profile_admin_view.dart';
import '../modules/profile_user/bindings/profile_user_binding.dart';
import '../modules/profile_user/views/profile_user_view.dart';
import '../modules/sistempakaruser/bindings/sistempakaruser_binding.dart';
import '../modules/sistempakaruser/views/sistempakaruser_view.dart';
import '../modules/splashscreeen/bindings/splashscreeen_binding.dart';
import '../modules/splashscreeen/views/splashscreeen_view.dart';
import '../modules/tambahmodelrambut/bindings/tambahmodelrambut_binding.dart';
import '../modules/tambahmodelrambut/views/tambahmodelrambut_view.dart';
import '../modules/user_riwayat/bindings/user_riwayat_binding.dart';
import '../modules/user_riwayat/views/user_riwayat_view.dart';
import '../modules/userfaq/bindings/userfaq_binding.dart';
import '../modules/userfaq/views/userfaq_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEEN,
      page: () => const SplashscreeenView(),
      binding: SplashscreeenBinding(),
    ),
    GetPage(
      name: _Paths.MASUK,
      page: () => const MasukView(),
      binding: MasukBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR,
      page: () => DaftarView(),
      binding: DaftarBinding(),
    ),
    GetPage(
      name: _Paths.LUPAAKUN,
      page: () => const LupaakunView(),
      binding: LupaakunBinding(),
    ),
    GetPage(
      name: _Paths.DAFTARMODEL,
      page: () => const DaftarmodelView(),
      binding: DaftarmodelBinding(),
    ),
    GetPage(
      name: _Paths.ADMINHOME,
      page: () => const AdminhomeView(),
      binding: AdminhomeBinding(),
    ),
    GetPage(
      name: _Paths.MODELRAMBUTADMIN,
      page: () => const ModelrambutadminView(),
      binding: ModelrambutadminBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAHMODELRAMBUT,
      page: () => const TambahmodelrambutView(),
      binding: TambahmodelrambutBinding(),
    ),
    GetPage(
      name: _Paths.FAKTA,
      page: () => const FaktaView(),
      binding: FaktaBinding(),
    ),
    GetPage(
      name: _Paths.DAFTARFAKTAADMIN,
      page: () => const DaftarfaktaadminView(),
      binding: DaftarfaktaadminBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_ADMIN,
      page: () => const ProfileAdminView(),
      binding: ProfileAdminBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_USER,
      page: () => const ProfileUserView(),
      binding: ProfileUserBinding(),
    ),
    GetPage(
      name: _Paths.SISTEMPAKARUSER,
      page: () => SistempakaruserView(),
      binding: SistempakaruserBinding(),
    ),
    GetPage(
      name: _Paths.ADMINFAQ,
      page: () => const AdminfaqView(),
      binding: AdminfaqBinding(),
    ),
    GetPage(
      name: _Paths.USERFAQ,
      page: () => const UserfaqView(),
      binding: UserfaqBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_RIWAYAT,
      page: () => AdminRiwayatView(),
      binding: AdminRiwayatBinding(),
    ),
    GetPage(
      name: _Paths.USER_RIWAYAT,
      page: () => const UserRiwayatView(),
      binding: UserRiwayatBinding(),
    ),
  ];
}
