class SQLiteDB

  constructor: (@options={}) ->
    @databaseName = if options.constructor.name == "String"
      options
    else
      options.name

    throw "window.sqlitePlugin is undefined, load plugin" unless window.sqlitePlugin
    throw "database name required" unless @databaseName

    @db = window.sqlitePlugin.openDatabase(@databaseName)

  dropTable: (opts={}, callbacks={}) =>
    tableName = if opts.constructor.name == "String"
      opts
    else
      opts.name

    steroids.debug "dropping table #{tableName}"

    @execute
      statement: "DROP TABLE #{tableName}"
    , callbacks

  createTable: (opts={}, callbacks={}) =>
    tableName = if opts.constructor.name == "String"
      opts
    else
      opts.name

    steroids.debug "creating table #{tableName} with #{opts.columnDefinitionString}"

    @execute
      statement: "CREATE TABLE #{tableName} (#{opts.columnDefinitionString})"
    , callbacks

  execute: (opts={}, callbacks={}) =>
    statement = if opts.constructor.name == "String"
      opts
    else
      opts.statement

    @db.transaction (tx) =>
      steroids.debug "execute statement #{statement}"

      success = (stx, res) =>
        rows = []
        for i in [0..res.rows.length-1]
          rows.push res.rows.item(i)

        callbacks.onSuccess(rows, res, stx) if callbacks.onSuccess

      failure = (tx, err) =>
        callbacks.onFailure(err, tx) if callbacks.onFailure

      tx.executeSql statement, [], success, failure

