package com.mujinnong.model.generator.freemarker;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

import freemarker.cache.TemplateLoader;

public class TemplateAbsolutePathLoader implements TemplateLoader {

    public Object findTemplateSource(String name) throws IOException {
        File source = new File(name);
        return source.isFile() ? source : null;
    }

    public long getLastModified(Object templateSource) {
        return ((File) templateSource).lastModified();
    }

    public Reader getReader(Object templateSource, String encoding)
            throws IOException {
        if (!(templateSource instanceof File)) {
            throw new IllegalArgumentException("templateSource is a: " + templateSource.getClass().getName());
        }
        return new InputStreamReader(new FileInputStream((File) templateSource), encoding);
    }

    public void closeTemplateSource(Object templateSource) throws IOException {
        // Do nothing.
    }

}
