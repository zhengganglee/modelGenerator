package com.netmodel.api.model.request;

import org.springframework.util.StringUtils;

import java.util.Collection;

public class RequestUtils {
	private static final String EMPTY = "";
	private static final String COLLECTION_STR_DELIM = ",";

	@SuppressWarnings("rawtypes")
	public static String object2String(Object object) {
		if (object == null) {
			return EMPTY;
		}

		if (object instanceof Collection) {
			return StringUtils.collectionToDelimitedString((Collection) object, COLLECTION_STR_DELIM);
		} else {
			return object.toString();
		}
	}

}
