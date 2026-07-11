local khaoslib_recipe = require("__khaoslib__.prototypes.recipe")
local khaoslib_technology = require("__khaoslib__.prototypes.technology")

khaoslib_technology:load("factory-architecture-t1")
  :clear_prerequisites()
  :clear_unit()
  :set({
    research_trigger = {
      type = "craft-item",
      count = 30,
      item = {
        name = "stone-brick",
      },
    },
  })
  :commit()

khaoslib_recipe:load("factory-1")
  :replace_ingredient("stone", {type = "item", name = "stone-brick", amount = 50})
  :replace_ingredient("iron-plate", function(ingredient)
    ingredient.amount = 50
    return ingredient
  end)
  :replace_ingredient("copper-plate", function(ingredient)
    ingredient.amount = 20
    return ingredient
  end)
  :commit()

khaoslib_technology:load("factory-connection-type-fluid")
  :merge_unit {count = 20}
  :commit()

khaoslib_technology:load("factory-interior-upgrade-display")
  :replace_prerequisite("factory-architecture-t2", "factory-architecture-t1")
  :merge_unit {count = 50}
  :remove_science_pack("logistic-science-pack")
  :commit()

khaoslib_recipe:load("factory-2")
  :replace_ingredient("stone-brick", function(ingredient)
    ingredient.amount = 500
    return ingredient
  end)
  :replace_ingredient("big-electric-pole", function(ingredient)
    ingredient.amount = 10
    return ingredient
  end)
  :commit()

khaoslib_technology:load("factory-architecture-t3")
  :remove_prerequisite("production-science-pack")
  :remove_science_pack("production-science-pack")
  :merge_unit {count = 1000}
  :commit()

khaoslib_recipe:load("factory-3")
  :replace_ingredient("steel-plate", function(ingredient)
    ingredient.amount = 500
    return ingredient
  end)
  :replace_ingredient("substation", function(ingredient)
    ingredient.amount = 10
    return ingredient
  end)
  :replace_ingredient("concrete", function(ingredient)
    ingredient.amount = 1000
    return ingredient
  end)
  :commit()

if mods["space-age"] then
  khaoslib_technology:load("factory-upgrade-greenhouse")
    :add_prerequisite("agricultural-science-pack")
    :add_science_pack({"space-science-pack", 1})
    :add_science_pack({"agricultural-science-pack", 1})
    :commit()

  if settings.startup["Factorissimo2-space-architecture"].value then
    khaoslib_technology:load("factory-space-architecture")
      :remove_prerequisite("promethium-science-pack")
      :remove_science_pack("cryogenic-science-pack")
      :remove_science_pack("promethium-science-pack")
      :commit()
  end
end
