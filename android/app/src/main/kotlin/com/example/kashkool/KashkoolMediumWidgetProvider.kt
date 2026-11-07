package com.example.kashkool

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class KashkoolMediumWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.kashkool_medium_widget).apply {
                val totalReceivables = widgetData.getString("total_receivables", "0 ج.م") ?: "0 ج.م"
                val collectedToday = widgetData.getString("collected_today", "0 ج.م") ?: "0 ج.م"
                val dueCount = widgetData.getString("due_count", "0 عملاء") ?: "0 عملاء"

                setTextViewText(R.id.widget_total_receivables, totalReceivables)
                setTextViewText(R.id.widget_collected_today, collectedToday)
                setTextViewText(R.id.widget_due_count, dueCount)

                // Open App Home
                val homeIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("kashkool://home")
                )
                setOnClickPendingIntent(R.id.widget_container, homeIntent)

                // Open Collection Tab directly
                val collectionIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("kashkool://collection")
                )
                setOnClickPendingIntent(R.id.btn_collection, collectionIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
