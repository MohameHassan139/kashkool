package app.kashkool

import android.content.Context
import android.content.SharedPreferences
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * Reads the values the Flutter side saved (see HomeWidgetService) and makes them safe to show
 * while the app is closed: when the saved data is from a previous day, "collected today" is
 * reset to zero instead of showing yesterday's number.
 */
object KashkoolWidgetData {
    private const val KEY_TOTAL_RECEIVABLES = "total_receivables"
    private const val KEY_COLLECTED_TODAY = "collected_today"
    private const val KEY_DUE_COUNT = "due_count"
    private const val KEY_UPDATED_DATE = "updated_date"
    private const val KEY_UPDATED_TIME = "updated_time"
    private const val KEY_PRIVACY_MODE = "privacy_mode"
    private const val KEY_WIDGET_ENABLED = "widget_enabled"
    private const val DASH = "—"
    private const val MASKED = "••••••"

    /** Reads a string safely: returns [fallback] if the key is missing or stored with another type. */
    private fun SharedPreferences.str(key: String, fallback: String?): String? =
        try { getString(key, fallback) } catch (e: ClassCastException) { fallback }

    private fun todayKey(): String = SimpleDateFormat("yyyy-MM-dd", Locale.US).format(Date())

    private fun isFromToday(data: SharedPreferences): Boolean =
        data.str(KEY_UPDATED_DATE, null) == todayKey()

    private fun isPrivate(data: SharedPreferences): Boolean =
        data.str(KEY_PRIVACY_MODE, "false") == "true"

    private fun isEnabled(data: SharedPreferences): Boolean =
        data.str(KEY_WIDGET_ENABLED, "true") != "false"

    fun totalReceivables(context: Context, data: SharedPreferences): String =
        if (!isEnabled(data)) context.getString(R.string.widget_disabled)
        else data.str(KEY_TOTAL_RECEIVABLES, null) ?: context.getString(R.string.widget_zero_amount)

    fun collectedToday(context: Context, data: SharedPreferences): String = when {
        !isEnabled(data) -> DASH
        isFromToday(data) -> data.str(KEY_COLLECTED_TODAY, null)
            ?: context.getString(R.string.widget_zero_amount)
        isPrivate(data) -> MASKED
        else -> context.getString(R.string.widget_zero_amount)
    }

    fun dueCount(context: Context, data: SharedPreferences): String =
        if (!isEnabled(data)) DASH
        else data.str(KEY_DUE_COUNT, null) ?: context.getString(R.string.widget_no_customers)

    fun lastUpdated(context: Context, data: SharedPreferences): String {
        if (!isEnabled(data)) return context.getString(R.string.widget_disabled_hint)
        val time = data.str(KEY_UPDATED_TIME, null)
        return if (time != null && isFromToday(data)) {
            context.getString(R.string.widget_updated_today, time)
        } else {
            context.getString(R.string.widget_open_to_update)
        }
    }
}
