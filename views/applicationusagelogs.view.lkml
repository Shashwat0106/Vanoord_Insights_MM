view: applicationusagelogs {
  sql_table_name: public.applicationusagelogs ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."id" ;;
  }
  dimension_group: logintimestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."logintimestamp" ;;
  }
  dimension_group: logouttimestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."logouttimestamp" ;;
  }
  dimension: username {
    type: string
    sql: ${TABLE}."username" ;;
  }
  dimension_group: logged {
    type: duration
    sql_start: ${logintimestamp_raw} ;;
    sql_end: ${logouttimestamp_raw} ;;
    intervals: [minute]
  }
  measure: average_logtime {
    type: average
    sql: ${minutes_logged} ;;
    value_format_name: decimal_2
  }
  measure: count {
    type: count
    drill_fields: [id, username]
  }
}
