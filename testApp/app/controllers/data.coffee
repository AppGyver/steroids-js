class window.DataController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "data" }


  # PERSISTENCE


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


  # SQLITE

  @testSQLiteDB: ->
    sqlitedb = new steroids.data.SQLiteDB("testdb")

    if sqlitedb.databaseName == "testdb"
      alert "ok"
    else
      alert "not ok"

  @testSQLiteDBCreateTable: ->
    sqlitedb = new steroids.data.SQLiteDB("testdb")

    sqlitedb.createTable
      name: "cars"
      columns:
        car_id: "integer"
        name: "text"
        description: "text"
        img: "blob"
        price: "real"
    ,
      onSuccess: ->
        alert "Created table"
      onFailure: ->
        alert "Failed creating table"

  @testSQLiteDBDropTable: ->
    testdb = new steroids.data.SQLiteDB("testdb")
    testdb.dropTable "cars", {
      onSuccess: -> alert "dropped"
      onFailure: -> alert "drop failed"
    }

  @testSQLiteDBexecute: ->
    testdb = new steroids.data.SQLiteDB("testdb")
    testdb.execute "INSERT INTO cars (car_id, name, description, img, price) VALUES (1, 'toyota', 'good car', 'somebase64image', 2.50)",
      onSuccess: (rows, res, tx) ->
        steroids.debug res
      onFailure: (err) =>
        alert err.message

    testdb.execute "SELECT COUNT(*) FROM cars",
      onSuccess: (rows, res, tx) =>
        alert "COUNT = #{rows[0]['COUNT(*)']}"
      onFailure: (err) =>
        alert err.message


  # TOUCHDB


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


  # RSS

  @testRSSFetch: ->
    lol = new steroids.data.RSS("url")
    steroids.logger.log(lol)