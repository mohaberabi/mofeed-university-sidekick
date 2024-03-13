import 'package:mofeduserpp/features/chat/cubit/chat_cubit.dart';
import 'package:mofeduserpp/features/chat/repository%20/chat_repository_impl.dart';
import 'package:mofeed_shared/clients/chat_client/chat_client.dart';
import 'package:mofeed_shared/clients/chat_client/firebase_chat_client.dart';

import '../service_lcoator.dart';

void initChat() {
  sl.registerLazySingleton<ChatClient>(
      () => FirebaseChatClient(firestore: sl()));
  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepository(chatClient: sl(), userStorage: sl()));
  sl.registerLazySingleton(() => ChatCubit(
      chatRepository: sl(), fcmRepository: sl(), authRepository: sl()));
}
