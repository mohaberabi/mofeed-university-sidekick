import 'package:mocktail/mocktail.dart';
import 'package:mofeduserpp/features/chat/repository%20/chat_repository_impl.dart';
import 'package:mofeduserpp/features/notifications/data/notifications_repository.dart';
import 'package:mofeed_shared/clients/auth_client/auth_client.dart';
import 'package:mofeed_shared/clients/chat_client/chat_client.dart';
import 'package:mofeed_shared/data/network_info.dart';
import 'package:mofeed_shared/helper/storage_client.dart';

class MockLocalNotiRepository extends Mock implements NotificationsRepository {}


class MockChatClient extends Mock implements ChatClient {}

class MockStorage extends Mock implements StorageClient {}

class MockNetWorkInfo extends Mock implements NetWorkInfo {}

class MockAuthClient extends Mock implements AuthClient {}

class MockNotificationRepository extends Mock
    implements NotificationsRepository {}

class MockChatRepository extends Mock implements ChatRepository {}
