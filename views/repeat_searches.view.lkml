
view: repeat_searches {
  derived_table: {
    sql: SELECT
          searchlogs."username"  AS "searchlogs.username",
          COUNT(*) AS "searchlogs.count"
      FROM
          "public"."searchlogs" AS "searchlogs"
      GROUP BY
          1
      HAVING COUNT(*) > 1 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: searchlogs_username {
    primary_key: yes
    type: string
    sql: ${TABLE}."searchlogs.username" ;;
  }

  dimension: searchlogs_count {
    type: number
    sql: ${TABLE}."searchlogs.count" ;;
  }

  set: detail {
    fields: [
        searchlogs_username,
  searchlogs_count
    ]
  }
}
