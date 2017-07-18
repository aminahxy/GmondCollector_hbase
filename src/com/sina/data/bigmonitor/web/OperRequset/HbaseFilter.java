package com.sina.data.bigmonitor.web.OperRequset;

import org.apache.hadoop.hbase.filter.*;
import org.apache.hadoop.hbase.util.Bytes;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by shiboyan on 8/27/16.
 */
public class HbaseFilter {
    public FilterList EqualFilterList(String rowName, String colKey, String colVal){
        List<Filter> filters = new ArrayList<Filter>();
        Filter filter = new SingleColumnValueFilter(Bytes.toBytes(rowName), Bytes.toBytes(colKey),
                CompareFilter.CompareOp.EQUAL, Bytes.toBytes(colVal));
        filters.add(filter);
        FilterList filterList = new FilterList(filters);
        return filterList;
    }

    public FilterList EqualRowFilterList(String rowName){
        List<Filter> filters = new ArrayList<Filter>();
        Filter filter = new RowFilter(CompareFilter.CompareOp.EQUAL, new BinaryComparator(rowName.getBytes()));
        filters.add(filter);
        FilterList filterList = new FilterList(filters);
        return filterList;
    }

    public FilterList PrefixRowFilterList(String rowName){
        List<Filter> filters = new ArrayList<Filter>();
        Filter filter = new RowFilter(CompareFilter.CompareOp.EQUAL, new BinaryPrefixComparator(rowName.getBytes()));
        filters.add(filter);
        FilterList filterList = new FilterList(filters);
        return filterList;
    }

    public FilterList RangeRowFilterList(String rowName, String rowId, String start, String end) {
        List<Filter> filters = new ArrayList<Filter>();
        String startStr = rowName + "#" + rowId + "#" + start;
        String endStr = rowName + "#" + rowId + "#" + end;
        System.out.println(startStr + "\n" + endStr);
        Filter filter1 = new RowFilter(CompareFilter.CompareOp.GREATER_OR_EQUAL,
                new BinaryComparator(Bytes.toBytes(startStr)));
	Filter filter2=new RowFilter(CompareFilter.CompareOp.LESS_OR_EQUAL,
				new BinaryComparator(Bytes.toBytes(endStr)));
        
        //Filter filter1 = new RowFilter(CompareFilter.CompareOp.GREATER_OR_EQUAL,
          //      new BinaryComparator(Bytes.toBytes("hadoop-2.4.0_master#100005#1469762820")));
	//hadoop-2.4.0_master#100005#1469762820
       // Filter filter2=new RowFilter(CompareFilter.CompareOp.LESS_OR_EQUAL,
	//			new BinaryComparator(Bytes.toBytes("hadoop-2.4.0_master#100005#1469763180")));
        filters.add(filter1);
        filters.add(filter2);
        FilterList filterList = new FilterList(filters);
        return filterList;
    }
}

