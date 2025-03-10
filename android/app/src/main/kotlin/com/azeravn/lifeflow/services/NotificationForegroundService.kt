package com.azeravn.lifeflow.services

import android.app.*
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.azeravn.lifeflow.R

class NotificationForegroundService : Service() {

    override fun onCreate() {
        super.onCreate()
        Log.d("NotificationService", "Service Created")
        // Start the foreground service
        startMyForeground()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("NotificationService", "Foreground Service Started")
        return START_STICKY // Ensure the service restarts if it is killed
    }

    private fun startMyForeground() {
        val channelId = "lifeflow_notification_channel"
        val channelName = "LifeFlow Notifications"

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                channelName,
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle("LifeFlow is running")
            .setContentText("Keep your habits on track!")
            .setSmallIcon(R.drawable.ic_notification)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()
        
        // Keeps the service alive on Android 8+ and shows a notification.
        startForeground(1, notification)
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("NotificationService", "Foreground Service Stopped")
    }

    // Restart the service if the app is killed
    override fun onTaskRemoved(rootIntent: Intent?) {
        super.onTaskRemoved(rootIntent)
        Log.d("NotificationService", "App Task Removed - restarting service...")

        val restartServiceIntent = Intent(applicationContext, NotificationForegroundService::class.java)
        restartServiceIntent.setPackage(packageName)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            applicationContext.startForegroundService(restartServiceIntent)
        } else {
            applicationContext.startService(restartServiceIntent)
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
