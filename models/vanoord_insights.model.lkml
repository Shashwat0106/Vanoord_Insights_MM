connection: "vo-prod"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: vanoord_insights_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: vanoord_insights_default_datagroup

access_grant: vanprod {
  user_attribute: department
  allowed_values: ["finance"]
}

explore: applicationusagelogs {}

explore: searchlogs {
  access_filter: {
    user_attribute: department
    field: documentlogs.searchid
  }
  sql_always_where: ${username}!='john.vandermarel@vanoord.com' and ${username}!='admin'  ;;
  label: "Documents & Search Logs"
  join: documentlogs {
    required_access_grants: [vanprod]
    type: left_outer
    relationship: many_to_one
    sql_on: ${documentlogs.searchid}=${searchlogs.searchid} ;;
  }
  join: repeat_searches {
    type: left_outer
    relationship: many_to_one
    sql_on: ${repeat_searches.searchlogs_username} = ${searchlogs.username} ;;
  }
}

#explore: searchlogs {}
