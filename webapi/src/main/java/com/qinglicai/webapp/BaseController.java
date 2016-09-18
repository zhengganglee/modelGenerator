package com.qinglicai.webapp;

public class BaseController {

    protected String redirect(String url) {
        return new StringBuilder("redirect:").append(url).toString();
    }

}
