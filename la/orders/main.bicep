module la '../logic_app.bicep' = {
  params: {
    name: 'la_get_orders_v_1_0_0'
    definition: loadJsonContent('./get_orders_1_0_0.json')
  }
}

@secure()
output la_get_orders_trigger object = la.outputs.trigger
