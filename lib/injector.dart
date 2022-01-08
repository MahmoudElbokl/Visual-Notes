import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'core/database_provider.dart';
import 'features/visual_notes_operations/data/data_source/get_visual_note_local_data_source.dart';
import 'features/visual_notes_operations/data/repositories/get_visual_note_repo_impl.dart';
import 'features/visual_notes_operations/domain/repositories/get_visual_notes_repo.dart';
import 'features/visual_notes_operations/domain/use_cases/get_visual_note_usecase.dart';
import 'features/visual_notes_operations/domain/use_cases/add_visual_note_usecase.dart';


final sl = GetIt.instance;

// inject my dependency
Future<void> init() async {
  // Use cases
  sl.registerLazySingleton<GetVisualNoteUseCases>(() => GetVisualNoteUseCases(sl()));
  sl.registerLazySingleton<AddVisualNoteUseCase>(() => AddVisualNoteUseCase(sl()));

  // Repository
  sl.registerLazySingleton<GetVisualNoteRepository>(
        () => GetVisualNoteRepositoryImpl(sl(),),
  );

  // Data sources
  sl.registerLazySingleton<GetVisualNotesLocalDataSource>(
        () => GetVisualNotesLocalDataSourceImpl(localStorage: sl()),
  );

  // Core
  Database database = await DatabaseProvider().database;
  sl.registerLazySingleton(() => database);
}
