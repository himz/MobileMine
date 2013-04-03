package com.example.mobilemine;

import android.os.Bundle;
import android.app.Activity;
import android.view.KeyEvent;
import android.view.Menu;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class MobileMine extends Activity {

	WebView myWebView;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		
		setContentView(R.layout.activity_mobile_mine);
		myWebView = (WebView) findViewById(R.id.WebView);
		WebSettings webSettings = myWebView.getSettings();
	    webSettings.setJavaScriptEnabled(true);
	    myWebView.setWebViewClient(new WebViewClient());
	   // myWebView.loadUrl("http://buythissellthat.heroku.com");
	    myWebView.loadUrl("http://128.2.19.125:3000");
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_mobile_mine, menu);
		return true;
	}

	
	
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
	    // Check if the key event was the BACK key and if there's history
	    if ((keyCode == KeyEvent.KEYCODE_BACK) && myWebView.canGoBack()) {
	        myWebView.goBack();
	        return true;
	    }
	    // If it wasn't the BACK key or there's no web page history, bubble up to the       default
	    // system behavior (probably exit the activity)
	    return super.onKeyDown(keyCode, event);
	}   
}
