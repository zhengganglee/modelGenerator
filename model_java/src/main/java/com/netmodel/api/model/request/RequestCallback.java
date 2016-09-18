package com.netmodel.api.model.request;


import com.netmodel.api.model.base.ApiResult;

public interface RequestCallback {

    /**
     * http 为200的情况下的回掉
     *
     * @param obj
     * @param result 请求HTTP的参数ID
     * @throws Exception
     */
    public void HttpResponseOk(Class<?> obj, ApiResult<?> result) throws Exception;

}
