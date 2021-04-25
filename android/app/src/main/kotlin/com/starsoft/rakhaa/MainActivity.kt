package com.starsoft.rakhaa

import android.util.Log
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onStart() {
        super.onStart()
        val packageName = context.packageName
        Log.d("nussair", packageName)
    }
}
