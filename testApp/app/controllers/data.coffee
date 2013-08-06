class window.DataController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "data" }

  @testPersistenceOverrideNativeSQL: ->
    unless window.sqlitePlugin.openDatabase
      alert "SQLitePlugin not loaded"
      return

    window.openDatabase = window.sqlitePlugin.openDatabase
    alert "done"

  @testPersistenceJSDropTestDB: ->
    persistencedb = new steroids.data.SQLiteDB("persistencedb")

    persistencedb.dropTable "Task", {
      onSuccess: ->
        alert "dropped"
      onFailure: ->
        alert "could not drop"
    }

  @getTask: ->
    Task = persistence.define('Task', {
      name: "TEXT",
      description: "TEXT",
      done: "BOOL"
    })

    return Task

  @testPersistenceJSDefineTask: ->
    @getTask()

    persistence.schemaSync ->
      alert "defined"

  @testPersistenceJSConfigure: ->
    persistence.store.websql.config(persistence, 'persistencedb', 'A database description', 5 * 1024 * 1024)
    alert "configured"

  @testPersistenceJSInsertTask: ->
    Task = @getTask()

    t = new Task()
    t.name = "taskname"
    t.description = "taskdescription"
    t.done = false

    persistence.add(t)
    persistence.flush () ->
      alert "inserted"

  @testPersistenceJSListAllTasks: ->
    Task = @getTask()

    Task.all().list (tasks) ->
      steroids.debug(tasks)
      alert "see console debug"

  @testSQLiteDB: ->
    sqlitedb = new steroids.data.SQLiteDB("testdb")

    if sqlitedb.databaseName == "testdb"
      alert "ok"
    else
      alert "not ok"

  @testSQLiteDBCreateTable: ->
    testdb = new steroids.data.SQLiteDB("testdb")
    testdb.createTable {
      name: "cars"
      columnDefinitionString: "id INTEGER PRIMARY KEY, name TEXT, age INTEGER"
    }, {
      onSuccess: -> alert "created"
      onFailure: -> alert "create failed"
    }

  @testSQLiteDBDropTable: ->
    testdb = new steroids.data.SQLiteDB("testdb")
    testdb.dropTable "cars", {
      onSuccess: -> alert "dropped"
      onFailure: -> alert "drop failed"
    }

  @testSQLiteDBexecute: ->
    testdb = new steroids.data.SQLiteDB("testdb")
    testdb.execute "INSERT INTO cars (name, age) VALUES ('lol', 1)",
      onSuccess: (rows, res, tx) ->
        steroids.debug res
      onFailure: (err) =>
        alert err.message

    testdb.execute "SELECT COUNT(id) as carcount FROM cars",
      onSuccess: (rows, res, tx) =>
        carCount = rows[0]["carcount"]
        alert "COUNT = #{carCount}"
      onFailure: (err) =>
        alert err.message

  @testTouchDBOnReadyExisting: ->
    touchdb = new steroids.data.TouchDB
      name: "testdb"

    touchdb.on 'ready', () =>
      alert "first 'testdb' ready"

      samedb = new steroids.data.TouchDB
        name: "testdb"

      samedb.on 'ready', () =>
        alert "second 'testdb' ready"

  @testTouchDBOnChange: ->
    touchdb = new steroids.data.TouchDB
      name: "testdb"

    touchdb.on 'change', =>
      alert('changed, always fired when set -- needs more thinking, cuz is currently required for ng-touchdb')

  @testRSSFetch: ->
    lol = new steroids.data.RSS("url")
    console.log(lol)