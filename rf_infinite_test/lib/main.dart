import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rf_infinite_test/blocs/contact/contact_bloc.dart';
import 'package:rf_infinite_test/constants/color.dart';
import 'package:rf_infinite_test/cubits/cubits.dart';
import 'package:rf_infinite_test/repositories/contact_repository.dart';
import 'package:rf_infinite_test/services/contact_api_service.dart';

import 'pages/home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  // hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactRepository(
          contactApiService: ContactApiService(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CurrentSelectedContactCubit>(
            create: (context) => CurrentSelectedContactCubit(),
          ),
          BlocProvider<ContactBloc>(
            create: (context) => ContactBloc(
              contactRepository: context.read<ContactRepository>(),
              currentSelectedContactCubit:
                  context.read<CurrentSelectedContactCubit>(),
            ),
          ),
          BlocProvider<FilterCubit>(
            create: (context) => FilterCubit(),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(),
          ),
          BlocProvider<FilteredContactCubit>(
            create: (context) => FilteredContactCubit(
              initialContact: context.read<ContactBloc>().state.contactList,
              contactBloc: context.read<ContactBloc>(),
              filterCubit: context.read<FilterCubit>(),
              searchCubit: context.read<SearchCubit>(),
            ),
          ),
          BlocProvider<ContactProfileSettingCubit>(
            create: (context) => ContactProfileSettingCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Contacts',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: createMaterialColor(const Color(0xFF32BAA5)),
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
