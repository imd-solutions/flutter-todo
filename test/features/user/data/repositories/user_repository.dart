/*
*
*
   !!!!! DON'T FORGET TO RENAME THE FILE !!!!!
  group('getUsers', () {
    test('should call the [RemoteDataSource.getUsers] and return [List<Users>] when call to remote source is successful', () async {

      when(() => remoteDatasource.getUsers()).thenAnswer((_) async => []);

      final results = await repositoryImpl.getUsers();

      expect(results, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDatasource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDatasource);

    });

    test('should return a [ApiFailure] when theh call to the remote source is unsuccessful', () async {

      when(() => remoteDatasource.getUsers()).thenThrow(tException);

      final result = await repositoryImpl.getUsers();

      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => remoteDatasource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
  });
*
* */
