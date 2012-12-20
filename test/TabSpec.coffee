buster.spec.expose()

describe "Tab", ->
  before ->
    window.AG_SCREEN_ID = window.top.AG_SCREEN_ID
    window.AG_LAYER_ID = window.top.AG_LAYER_ID
    window.AG_VIEW_ID = window.top.AG_VIEW_ID
    localStorage.setItem "SCREEN_ID_#{AG_SCREEN_ID}", false
    refute JSON.parse(localStorage.getItem("SCREEN_ID_#{AG_SCREEN_ID}"))


  it "should run parallel", (done)->

    localStorage.setItem "SCREEN_ID_#{AG_SCREEN_ID}", true
    neigbourKey = if AG_SCREEN_ID is 0 then 1 else 0
    intervaller = setInterval ()->

      neighbourValue = JSON.parse localStorage.getItem("SCREEN_ID_#{neigbourKey}")

      if neighbourValue is true
        assert true
        clearInterval intervaller
        done()
    , 25
