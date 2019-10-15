# 四川汽车票务APP
网址：https://www.scqckypw.com/
解析html，没有现成接口
方便买票，从这个网站买票没有三块钱的服务费，但是这个网站没有适配手机端，也没有APP

# flutter_webview_plugin 改造
由于插件不支持cookie，所以需要进行修改
在WebviewManager.java中，修改下面的代码
 if (headers != null) {
            String cookie = headers.get("cookieStr");
            if(cookie != null && cookie.length() > 0){
                headers.remove("cookieStr");
                CookieManager.getInstance().setCookie("www.scqckypw.com", cookie);
            }
            webView.loadUrl(url, headers);
        } else {
            webView.loadUrl(url);
        }