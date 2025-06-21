// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ExpenseDbBuilderContract {
  /// Adds migrations to the builder.
  $ExpenseDbBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ExpenseDbBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ExpenseDb> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorExpenseDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ExpenseDbBuilderContract databaseBuilder(String name) =>
      _$ExpenseDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ExpenseDbBuilderContract inMemoryDatabaseBuilder() =>
      _$ExpenseDbBuilder(null);
}

class _$ExpenseDbBuilder implements $ExpenseDbBuilderContract {
  _$ExpenseDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ExpenseDbBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ExpenseDbBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ExpenseDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ExpenseDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ExpenseDb extends ExpenseDb {
  _$ExpenseDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExpenseDAO? _expenseDaoInstance;

  TagDao? _tagDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expense` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `transactionDate` TEXT NOT NULL, `spent` REAL NOT NULL, `note` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tag` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expense_tag_join` (`expenseId` INTEGER NOT NULL, `tagId` INTEGER NOT NULL, FOREIGN KEY (`expenseId`) REFERENCES `expense` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`tagId`) REFERENCES `tag` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`expenseId`, `tagId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExpenseDAO get expenseDao {
    return _expenseDaoInstance ??= _$ExpenseDAO(database, changeListener);
  }

  @override
  TagDao get tagDao {
    return _tagDaoInstance ??= _$TagDao(database, changeListener);
  }
}

class _$ExpenseDAO extends ExpenseDAO {
  _$ExpenseDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _expenseEntityInsertionAdapter = InsertionAdapter(
            database,
            'expense',
            (ExpenseEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'transactionDate': item.transactionDate,
                  'spent': item.spent,
                  'note': item.note
                }),
        _expenseEntityDeletionAdapter = DeletionAdapter(
            database,
            'expense',
            ['id'],
            (ExpenseEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'transactionDate': item.transactionDate,
                  'spent': item.spent,
                  'note': item.note
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExpenseEntity> _expenseEntityInsertionAdapter;

  final DeletionAdapter<ExpenseEntity> _expenseEntityDeletionAdapter;

  @override
  Future<List<ExpenseEntity>> getAllExpenses() async {
    return _queryAdapter.queryList('SELECT * from expense',
        mapper: (Map<String, Object?> row) => ExpenseEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            transactionDate: row['transactionDate'] as String,
            spent: row['spent'] as double,
            note: row['note'] as String?));
  }

  @override
  Future<void> insertExpense(ExpenseEntity e) async {
    await _expenseEntityInsertionAdapter.insert(e, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeExpense(ExpenseEntity e) async {
    await _expenseEntityDeletionAdapter.delete(e);
  }
}

class _$TagDao extends TagDao {
  _$TagDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<TagEntity>> getAllTags() async {
    return _queryAdapter.queryList('SELECT * from tag',
        mapper: (Map<String, Object?> row) =>
            TagEntity(id: row['id'] as int?, name: row['name'] as String));
  }
}
