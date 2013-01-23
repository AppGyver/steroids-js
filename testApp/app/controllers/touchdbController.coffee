
document.addEventListener "deviceready", ->
  Steroids.navigationBar.show { title: "TOUCHDB" }

  createSuccess = () =>
    console.log "suc created"
    addReplicas()

  createFailure = (msg) =>
    console.log "failed create"
    addReplicas()

  replicateSuccess = (msg) =>
    console.log "success replicate"
    console.log carDB.replicas
    carDB.startMonitoringChanges({}, {onChange: changeReceived})

  replicateFailure = (msg) ->
    console.log "failure replicate"
    console.log msg

  addReplicas = () =>
    carDB.addTwoWayReplica {
      url: "http://mitynedowneightterioneds:m8d6RfnAwoQcVgPaDJWnrAbf@appgyver.cloudant.com/mattitest"
    }, {
      onSuccess: replicateSuccess
      onFailure: replicateFailure
    }

  changeReceived = () =>
    alert("changed!")



  carDB = new Steroids.data.TouchDB
    name: "markos"

  carDB.createDB {}, {
    onSuccess: createSuccess
    onFailure: createFailure
  }
