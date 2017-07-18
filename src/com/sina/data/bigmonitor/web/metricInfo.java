package com.sina.data.bigmonitor.web;

/**
 * Created by shiboyan on 8/27/16.
 */
public class metricInfo {

    String metricName;
    String metricId;
    String type;

    public metricInfo() {
    }

    public metricInfo(String metricName, String metricId) {
        this.metricName = metricName;
        this.metricId = metricId;
    }

    public metricInfo(String metricName, String metricId, String type) {
        this(metricName,metricId);
        this.type = type;
    }

    public String getMetricName() {
        return metricName;
    }

    public void setMetricName(String metricName) {
        this.metricName = metricName;
    }

    public String getMetricId() {
        return metricId;
    }

    public void setMetricId(String metricId) {
        this.metricId = metricId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
