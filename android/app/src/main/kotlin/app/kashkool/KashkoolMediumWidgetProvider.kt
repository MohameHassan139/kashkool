package app.kashkool

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
                setTextViewText(
                    R.id.widget_total_receivables,
                    KashkoolWidgetData.totalReceivables(context, widgetData)
                )
                setTextViewText(
                    R.id.widget_collected_today,
                    KashkoolWidgetData.collectedToday(context, widgetData)
                )
                setTextViewText(
                    R.id.widget_due_count,
                    KashkoolWidgetData.dueCount(context, widgetData)
                )
                setTextViewText(
                    R.id.widget_last_updated,
                    KashkoolWidgetData.lastUpdated(context, widgetData)
                )

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
