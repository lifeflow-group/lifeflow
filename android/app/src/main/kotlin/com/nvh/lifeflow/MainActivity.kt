package com.nvh.lifeflow

import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.lifecycle.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.nvh.lifeflow.services.NotificationForegroundService

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Observe the lifecycle of the application (foreground/background)
        observeAppLifecycle()
    }

    private fun observeAppLifecycle() {
        // Observe the lifecycle of the application
        ProcessLifecycleOwner.get().lifecycle.addObserver(object : LifecycleObserver {

            @OnLifecycleEvent(Lifecycle.Event.ON_START)
            fun onEnterForeground() {
                Log.d("LifecycleObserver", "App is in foreground")
                // Stop foreground service to hide notification
                stopForegroundService()
            }

            @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
            fun onEnterBackground() {
                Log.d("LifecycleObserver", "App is in background")
                // Run foreground service to keep the app active and display notification.
                startForegroundService()
            }
        })
    }

    private fun startForegroundService() {
        val serviceIntent = Intent(this, NotificationForegroundService::class.java)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            startForegroundService(serviceIntent)
        } else {
            startService(serviceIntent)
        }
    }

    private fun stopForegroundService() {
        val serviceIntent = Intent(this, NotificationForegroundService::class.java)
        stopService(serviceIntent)
    }
}
