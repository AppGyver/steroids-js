class SQLiteDB

  constructor: (@options={}) ->
    @databaseName = if options.constructor.name == "String"
      options
    else
      options.name

    throw "window.sqlitePlugin is undefined, please load plugin" unless window.sqlitePlugin
    throw "database name required" unless @databaseName

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

    statement = "CREATE TABLE #{tableName}"

    if opts.columns?
      columnsString = ("#{key} #{type.toUpperCase()}" for key, type of opts.columns)

      columnDefinitionString = columnsString.join(", ")

    steroids.debug "creating table #{tableName} with #{columnDefinitionString}"

    statement += " (#{columnDefinitionString})" if columnDefinitionString?

    @execute
      statement: statement
    , callbacks

  execute: (opts={}, callbacks={}) =>
    statement = if opts.constructor.name == "String"
      opts
    else
      opts.statement

    steroids.debug "stament to execute: #{statement}"

    document.addEventListener 'deviceready', ()=>

      unless @db
        @db = window.sqlitePlugin.openDatabase(@databaseName)

      @db.transaction (tx) =>
        steroids.debug "execute transaction started"

        success = (stx, res) =>
          rows = []
          for i in [0..res.rows.length-1]
            rows.push res.rows.item(i)

          steroids.debug "execute success, returned #{rows.length} rows"
          callbacks.onSuccess(rows, res, stx) if callbacks.onSuccess

        failure = (tx, err) =>
          steroids.debug "execute failure -- err.message: #{err.message}"
          callbacks.onFailure(err, tx) if callbacks.onFailure

        tx.executeSql statement, [], success, failure

