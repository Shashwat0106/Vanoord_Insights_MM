connection: "vo-prod"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: vanoord_insights_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: vanoord_insights_default_datagroup

explore: applicationusagelogs {}

explore: documentlogs {
  join: searchlogs {
    type: left_outer
    relationship: many_to_one
    sql_on: ${documentlogs.searchid}=${searchlogs.searchid} ;;
  }
}

#explore: searchlogs {}
