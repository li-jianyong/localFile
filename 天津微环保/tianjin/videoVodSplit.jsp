<%@ page import="bizfuse.web.utils.PageControlUtils" %>
<%@ include file="/common/taglibs.jspf"%>
<%@ include file="/components/scdc/leftTrees/left-tree-polluter.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/assets/global/plugins/bootstrap-datepicker/css/datepicker3.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/assets/global/plugins/bootstrap-datetimepicker/css/datetimepicker.css'/>"/>
<link rel="stylesheet" href="${ctx}/assets/global/css/video.css">
<script type="text/javascript" src="<c:url value='/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/global/plugins/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/global/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js' />"></script>

<%--<script type="text/javascript" src="<c:url value='/scripts/bizfuse-common/date-common.js'/>"></script>--%>

<script type="text/javascript" src="<bizfuse:resourceUrl resourceUrl='videoVodSplit.js' />"></script>
<script>
    getConfig = function () {
        return {
            videoRtmpUrl: "<bizfuse:findInService url='/videoInfo/getRtmpUrl' />",
            videoPTZUrl: "<bizfuse:findInService url='/videoInfo/ptzUrl' />",
            videoUrl: "<bizfuse:findInService url='/videoInfo/psVideo' />",
            videoOnLineState: "<bizfuse:findInService url='/gis/eps/videoOnLineState' />",
            imgQingOn: "<bizfuse:resourceUrl resourceUrl='/scripts/common-video/images/xj.png'/>",
            imgQiuOn: "<bizfuse:resourceUrl resourceUrl='/scripts/common-video/images/sx.png'/>",
            imgQingOff: "<bizfuse:resourceUrl resourceUrl='/scripts/common-video/images/cw_03.png'/>",
            imgQiuOff: "<bizfuse:resourceUrl resourceUrl='/scripts/common-video/images/cw_03.png'/>",
            videoServerIp:"${videoServerIp}",
            videoServerPort:"${videoServerPort}"
        };
    };
</script>

<style type="text/css">
    .page-content{
        padding-top: 0px !important;
    }

</style>
<article>
    <ul class="url-nav">
        <li><a href="#">${parentMenu.title}</a></li>
        <li><a href="<%=request.getParameter(PageControlUtils.BACKURL)%>" id="pageTitle">${currentMenu.title}</a></li>
        <li><a href="#" id="psName"></a></li>
    </ul>
    <div class="card">
        <div class="row">
            <div class="col-md-12">
                <!-- BEGIN SAMPLE TABLE PORTLET-->
                <div class="portlet-header clearfix">
                    <!-- tabhead 链接公共页-->
                    <%@ include file="/common/tabs.jspf"%>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 clearfix">
                <div id="mainBody" <%--style="position: fixed"--%>>
                    <%--<div class="right_top" ><span class="fl" ></span><span class="fr"></span></div>--%>
                    <div class="right_box" id = "main1">
                        <div class="right_title">
                            <input type="hidden" id="psCode"/>
                            <input type="hidden" id="outputCode"/>
                            <input type="hidden" id="outputType" />
                            <input type="hidden" id="outputName"/>
                            <input type="hidden" id="camIds"/>
                            <input type="hidden" id="showWnd" />
                            <input type="hidden" name = "bool" id="bool" value="1"/><!--判断是否已经对云台禁用  1:表示 可以  0：表示 已经 禁用-->
                            <div id="yinCDIV"></div>
                            <div id="videoCamDiv"></div>
                            <input type="hidden" id="fenPing" value="2"/>
                        </div>
                        <div class="right_body">
                            <div id="overflowDiv">
                                <div class="body_top" id="tobVideo" style="border: 1px solid #CCCCCC; height: 25px">
                                </div>
                                <div class="body-main">
                                    <div id="yuntaiVideo" style="display: block;clear: both">
                                        <div class="numb_right" style="float:right;width:24.5%;background:#E3F3FB;" id="yunColor">
                                            <div class="form-horizontal">
                                                <div style="padding: 10px">
                                                    <p><span style="color: red">注意：切片失败时，需用管理员权限运行IE浏览器。</span></p>
                                                </div>
                                                <div style="padding: 10px">
                                                    <label class="control-label">开始时间：</label>
                                                    <div class="controls">
                                                        <input type="text" class="form-control form_datetime" readonly value=""
                                                               placeholder="开始时间" id="startHourTime">
                                                    </div>
                                                </div>
                                                <div style="padding: 10px">
                                                    <label class="control-label">结束时间：</label>
                                                    <div class="controls">
                                                        <input type="text" class="form-control form_datetime" readonly value=""
                                                               placeholder="结束时间" id="endHourTime">
                                                    </div>
                                                </div>
                                                <div style="padding: 10px">
                                                    <label class="control-label">切片数量：</label>
                                                    <div class="controls">
                                                        <input type="text" class="form-control"  placeholder="切片数量" id="splitNum">
                                                    </div>
                                                </div>
                                                <div class="progress">
                                                    <div id="progress" class="progress-bar" role="progressbar" aria-valuenow="60"
                                                         aria-valuemin="0" aria-valuemax="100" style="display: none">
                                                    </div>
                                                </div>
                                                <div style="text-align: center;padding: 10px 15px">
                                                    <button class="btn blue" id="toSplit">开始切片</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="numb_left" style="height:500px;width: 75%;z-index: -1000">
                                            <OBJECT id="View" style="width:100%; height:100%;"  classid="clsid:BB353411-79EA-45BD-82CE-23643FECBD32"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</article>


