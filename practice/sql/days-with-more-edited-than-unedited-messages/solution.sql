WITH daily_stats AS (
    SELECT
        DATE(sent_at) AS message_date,
        COUNT(*) FILTER (WHERE edited = TRUE) AS edited_count,
        COUNT(*) FILTER (WHERE edited = FALSE) AS unedited_count
    FROM chat_msgs
    GROUP BY DATE(sent_at)
    HAVING COUNT(*) FILTER (WHERE edited = TRUE)
         > COUNT(*) FILTER (WHERE edited = FALSE)
)

SELECT cm.*
FROM chat_msgs cm
JOIN daily_stats ds
    ON DATE(cm.sent_at) = ds.message_date;
