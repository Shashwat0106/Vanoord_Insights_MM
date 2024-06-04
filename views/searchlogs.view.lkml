view: searchlogs {
  sql_table_name: public.searchlogs ;;

  dimension: application_session_id {
    type: string
    sql: ${TABLE}."applicationSessionId" ;;
  }
  dimension: query {
    type: string
    sql: ${TABLE}."query" ;;
  }
  dimension: route {
    type: string
    sql: ${TABLE}."route" ;;
  }
  dimension: searchid {
    primary_key: yes
    type: string
    sql: ${TABLE}."searchid" ;;
  }
  dimension_group: timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."timestamp" ;;
  }
  dimension: troubleshooting {
    type: string
    sql: ${TABLE}."troubleshooting" ;;
  }
  dimension: username {
    type: string
    sql: ${TABLE}."username" ;;
  }
  measure: total_users {
    type: count_distinct
    sql: ${username} ;;
  }
  measure: searches_per_users {
    type: number
    sql: ${count}/${total_users} ;;
  }
  measure: count {
    type: count
    drill_fields: [username]
  }
  measure: repeat_percent {
    type: number
    sql: CAST(${repeat_searches.count} AS FLOAT)/CAST(${count} AS FLOAT) ;;
    value_format_name: percent_2
  }

}
