package com.enmotech.clanalysis.remote;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/11.
 */
public class RemoteInterface
{
    @Test
    public void testLogSource()
    {
        try
        {
            File file = new File("E:\\Enmotech\\接口文档\\getLogSources.js");
            ObjectMapper mapper = new ObjectMapper();
            TypeReference<List<Object>> typeRef
                    = new TypeReference<List<Object>>()
            {
            };
            List<Map<String, Object>> listMap = mapper.readValue(file, typeRef);
//            test(listMap);
            for (Map<String, Object> map : listMap)
            {
                System.out.println(map.get("id") + " => " + map.get("name"));
            }
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    public void test(List<Map<String, Object>> listMap)
    {
        String tag = "";

        for (Map<String, Object> map : listMap)
        {
            for (Map.Entry<String, Object> entry : map.entrySet())
            {
                if (entry.getValue() instanceof List)
                {
                    test((List<Map<String, Object>>) entry.getValue());
                }
                else
                {
                    System.out.println(
                            tag + entry.getKey() + " => " + entry.getValue());
                }
            }
        }
    }

    @Test
    public void test1()
    {
        getList("cols");
    }

    public void getList(String field)
    {
        File file = new File("E:\\Enmotech\\接口文档\\getLogSources.js");
        ObjectMapper mapper = new ObjectMapper();
        try
        {
            JsonNode root = mapper.readTree(file);
            List<JsonNode> list = root.findValues(field);
            System.out.println(list);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }
}
