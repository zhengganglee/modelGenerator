package com.qinglicai.webapp.service;

import java.util.Collections;
import java.util.List;

/**
 * Service返回值
 *
 * @author Li Zhenggang
 */
public class ServiceResult {

    private long code;

    private String message;

    private List<?> contentList;


    private ServiceResult(long code, String message, List<?> contentList) {
        this.code = code;
        this.message = message;
        this.contentList = contentList;
    }

    // 成功的返回
    public static ServiceResult createSuccess(Object recordContent) {
        return createSuccess(null, Collections.singletonList(recordContent));
    }

    public static ServiceResult createSuccess(List<?> contentList) {
        return createSuccess(null, contentList);
    }

    public static ServiceResult createSuccess(String message, List<?> contentList) {
        return new ServiceResult(0, message, contentList);
    }

    public long getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public List<?> getContentList() {
        return contentList;
    }

    public Object getFirstContent() {
        if (this.getContentList() == null || this.getContentList().size() == 0) {
            return null;
        }
        return this.getContentList().get(0);
    }

}
