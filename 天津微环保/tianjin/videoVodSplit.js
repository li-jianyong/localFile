var objCtrl = null;
var videoListData = null;//保存摄像头数据
var videoId;       //第一个视频id，加载第一个摄像头用
//进度条timer
var splitTimerID;

//切片数量
var splitNum = 0;
//切到了多少数量
var splitRunCnt = 0;
//
var splitTimeM;


/*$(window).unload(function(){
 console.log("获取到了页面要关闭的事件了！");
 stopPlayVideo();
 });*/

$(document).ready(function () {

    var height= $('.card').height();
    //var  mTop = $('#wwww')[0].offsetTop;
    //var  sTop = $(window).scrollTop();
    //var result = mTop - sTop;
    //todo 这里不起作用
    if (height > 700) {
        $(".numb_left").height(height * 0.82);
    } else {
        $(".numb_left").height(height * 0.82);
    }
    timeChange();
    //初始化页面
    pageInit();
    $("#top td").each(function (i) {
        if ($(this).attr("id") == 'moreTd') {
            $(this).find(".menuBarMore ul li a").each(function (i) {
                $(this).click(function () {
                    $("#top").find(".on").removeClass("on");
                    $(this).addClass("on");
                    return false;
                });
            });
        } else {
            $(this).click(function () {
                $("#top").find(".on").removeClass("on");
                $(this).addClass("on");
                return false;
            });
        }
    });


    $("#toSplit").bind("click", function () {
        //1、获取摄像头信息
        var videoInfo = getActiveVideoInfo();
        //2、获取开始时间和结束时间 20160515010000
        var startTime = getQueryTime($("#startHourTime"));
        var endTime = getQueryTime($("#endHourTime"));
        
        //获取切片数量
        var num = $("#splitNum").val();

        if (!/^[1-9]\d*$/.test(num)) {
            alert("请输入正整数");
            $("#splitNum").focus();
            //$.fn.showError("请输入正整数");
            return false;
        }
        if (parseInt(num) == 1) {
            alert("切片数量必须大于1");
            $("#splitNum").focus();
            return false;
        }
        if (parseInt(num) > 100) {
            alert("切片数量不能超过100");
            $("#splitNum").focus();
            //$.fn.showError("切片数量不能超过100");
            return false;
        }
        splitNum = num;
        splitPicture(videoInfo, startTime, endTime);
        $(this).attr("disabled", "disabled");
    });


});

//在页面加载的时候得到树中第一个污染源的psCode方法，是重写的左树种的方法
loadFirstNode = function (psCode, psName) {
    $("#psName").html(psName);
    showVideoList(psCode, psName);

};
clickNodeTree = function (obj) {
    switch (obj.type) {
        case "epsOnline":
        case "epsOffline":
            //停止原来的播放
            stopPlayVideo();
            $("#psName").html(obj.originalText);
            showVideoList(obj.id, obj.originalText);
            break;
        case "videoOn":
        case "videoOff":
            // console.log("click viceo");

            break;
    }

};

function splitPicture(videoObj, startTime, endTime) {

    if (splitTimerID) {
        clearInterval(splitTimerID);
    }


    var totalSecond = (endTime.getTime() - startTime.getTime()) / 1000;
    splitTimeM = totalSecond / splitNum;
    ////////////////////////////////////////////////////////////////////////////////////////////
    //先执行 要不然有些切不出来
    objCtrl.VodSplitPicture(
        1,
        videoObj.serverUuid, 		// 目标服务器UUID
        String(videoObj.deviceName), // 设备名称
        Number(2), // 设备类型
        String(videoObj.equipIp), // 设备IP
        Number(videoObj.equipPort), // 设备端口
        Number(videoObj.id), // 设备ID
        Number(videoObj.channel - 1), // 通道ID
        String(videoObj.equipUserName), // 用户名
        String(videoObj.equipPassword), // 密码
        Number(1), 	// VOD模式 0:文件;1:时间
        startTime.format("yyyyMMddhhmmss"), // 开始时间
        endTime.format("yyyyMMddhhmmss"), // 结束时间
        Number(splitRunCnt),		// 切分图片数
        String(splitTimeM * splitRunCnt) // 结束间隔
    );
    splitRunCnt++;
    ///////////////////////////////////////////////////////////////////////////////////////////////

    $("#progress").show();
    $("#progress").css("width", (splitRunCnt / splitNum) * 100 + "%");
    //延迟几秒开始定时
    setTimeout(function(){
        splitTimerID = setInterval(function () {
            $("#progress").css("width", (splitRunCnt / splitNum) * 100 + "%");
            if (splitRunCnt > splitNum) {
                $("#toSplit").removeAttr("disabled");
                clearInterval(splitTimerID);
                splitRunCnt = 0;
                //vodstop();
                return false;
            }
            if (objCtrl) {
                if (splitRunCnt < splitNum) {
                    var ret = objCtrl.VodSplitPicture(
                        1,
                        videoObj.serverUuid, 		// 目标服务器UUID
                        String(videoObj.deviceName), // 设备名称
                        Number(2), // 设备类型
                        String(videoObj.equipIp), // 设备IP
                        Number(videoObj.equipPort), // 设备端口
                        Number(videoObj.id), // 设备ID
                        Number(videoObj.channel - 1), // 通道ID
                        String(videoObj.equipUserName), // 用户名
                        String(videoObj.equipPassword), // 密码
                        Number(1), 	// VOD模式 0:文件;1:时间
                        startTime.format("yyyyMMddhhmmss"), // 开始时间
                        endTime.format("yyyyMMddhhmmss"), // 结束时间
                        Number(splitRunCnt),		// 切分图片数
                        String(splitTimeM * splitRunCnt) // 结束间隔
                    );
                } else {//最后一张图
                    var ret = objCtrl.VodSplitPicture(
                        1,
                        videoObj.serverUuid, 		// 目标服务器UUID
                        String(videoObj.deviceName), // 设备名称
                        Number(2), // 设备类型
                        String(videoObj.equipIp), // 设备IP
                        Number(videoObj.equipPort), // 设备端口
                        Number(videoObj.id), // 设备ID
                        Number(videoObj.channel - 1), // 通道ID
                        String(videoObj.equipUserName), // 用户名
                        String(videoObj.equipPassword), // 密码
                        Number(1), 	// VOD模式 0:文件;1:时间
                        startTime.format("yyyyMMddhhmmss"), // 开始时间
                        endTime.format("yyyyMMddhhmmss"), // 结束时间
                        Number(-2),		// 切分图片数 -1:不打开本地Explorer窗口;-2:打开本地Explorer窗口;
                        String("0") // 结束间隔
                    );
                }
                splitRunCnt++;
            }
        }, 2000);//每两秒执行切片
    },5000);


}


function getQueryTime(domObj) {
    var temp = domObj.val();
    temp = temp.replace(" ", "-").replace(":", "-");
    var ar = temp.split('-');
    var d = new Date(ar[0], ar[1] - 1, ar[2], ar[3], ar[4]);
    //console.log(d.format("yyyyMMddhhmmss"));
    return d;
}

function stopPlayVideo() {
    if (objCtrl) {
        try {
            var ret = objCtrl.VodStop();
        } catch (e) {
        }
    }

    if (splitTimerID) {
        clearInterval(splitTimerID);
    }
    //切片数量
    splitNum = 0;
    //切到了多少数量
    splitRunCnt = 0;
    splitTimeM = 0;
    $("#toSplit").removeAttr("disabled");
    $("#progress").css("width", "0%");
}


//时间开始跟结束验证
function timeChange() {

    $(".form_datetime").datetimepicker({
        autoclose: true,
        isRTL: Metronic.isRTL(),
        format: "yyyy-mm-dd hh:ii",
        language: 'zh-CN',
        pickDate: true,
        pickTime: true,
        hourStep: 1,
        minuteStep: 5,
        secondStep: 1,
        startView: 1,
        minView: 0,
        showMeridian: true,
        pickerPosition: (Metronic.isRTL() ? "bottom-right" : "bottom-left")
    });
    var date=new Date();
    date.setMinutes(0);
    date.setHours(date.getHours()-1);
    $("#endHourTime").datetimepicker("setDate", date);
    date.setMinutes(date.getMinutes()-1);
    $("#startHourTime").datetimepicker("setEndDate", date);
    date.setMinutes(0);
    $("#startHourTime").datetimepicker("setDate", date);
    date.setMinutes(1);
    $("#endHourTime").datetimepicker("setStartDate", date);

    $("#startHourTime").on("changeDate", function (dateOpt) {
        if (dateOpt.date) {
            //var temp=dateOpt.target.value;
            //temp=temp.replace(" ","-").replace(":","-");
            //var ar=temp.split('-');
            //var d=new Date(ar[0],ar[1]-1,ar[2],ar[3],ar[4]);
            //valueOf()得到毫秒 是国际时间 要减去8小时
            var ms = dateOpt.date.valueOf() - 8 * 60 * 60 * 1000;
            var times = ms + 60 * 1000;//加一分钟
            var d2 = new Date(times);
            $("#endHourTime").datetimepicker("setStartDate", d2.format('yyyy-MM-dd hh:mm'));
            //var d3 = new Date(ms + 2 * 60 * 60 * 1000);
            //$("#endHourTime").datetimepicker("setEndDate", d3.format('yyyy-MM-dd hh:mm'));
        }
    });

    $("#endHourTime").on("changeDate", function (dateOpt) {
        if (dateOpt.date) {
            var ms = dateOpt.date.valueOf() - 8 * 60 * 60 * 1000;
            var times = ms - 60 * 1000;
            var d2 = new Date(times);
            $("#startHourTime").datetimepicker("setEndDate", d2.format('yyyy-MM-dd hh:mm'));
        }
    });
}


// 页面加载
function pageInit() {
    objCtrl = document.getElementById("View");
    if (objCtrl) {
        try {
            // InitCtrl(string serverIp, int serverPort) 服务器IP，服务器端口号
            objCtrl.InitVodCtrl(getConfig().videoServerIp, getConfig().videoServerPort, 0, 1); // 服务器IP，服务器端口号, 窗口数目(0:1;1:4...),实行模式(0:服务器转发,1:客户端直连)
            //objCtrl.InitVodCtrl("192.168.0.123", 6261, 0, 1); // 服务器IP，服务器端口号, 窗口数目(0:1;1:4...),实行模式(0:服务器转发,1:客户端直连)
            // splitchange(1);
        } catch (e) {
            console.log(e);
        }
    }
}


// 停止播放
function stop() {
    if (objCtrl) {
        var ret = objCtrl.Stop();
        if (ret != 1) {
            alert("停止失败");
        }
    }
}


//通过污染源psCode展现排口
showVideoList = function (psCode, psName) {
    $('#psCode').val(psCode);
    //$.fn.showAjax();
    //加载摄像头列表
    $.ajax({
        type: "post",
        url: getConfig().videoUrl,
        async: true,
        data: {psCode: psCode},
        dataType: "json",
        success: function (response) {
            videoListData = response;
            $('#tobVideo').empty();
            if (response != null && response != '' && response.length > 0) {

                drawVideoRow();
                changeVideoImage();
                //触发第一个视频的点击事件
                if (videoId) {
                    $("#" + videoId).trigger("click");
                }

            } else {
                // 隐藏遮罩层
                $('#tobVideo').html("<div id='msgTexts'> <span>" + psName + "</span> 下没有摄像头。</div>");
            }
        }
    });
};

/**
 * 在摄像头table渲染后再获取摄像头状态信息来改图标，解决firefox等浏览器不兼容视频插件造成的报错无法渲染摄像头列表，不好看问题
 */
function changeVideoImage() {
    var response = videoListData;
    for (var i = 0; i < response.length; i++) {
        var data = response[i];
        var img = $('#videoImg' + data.id);
        var camID = null;
        try {
            camID = ViewWnd.GetCameraIDByGUID(ServerID, data.guidDataOne, data.guidDataTwo, data.guidDataThree, data.deviceMac);
        } catch (e) {
            continue;
        }

        var states = GetCameraStatus(camID);
        if (states == 1) {
            if (data.deviceType == '0') {
                img.attr({
                    'src': getConfig().imgQingOn
                });
            } else {
                img.attr({
                    'src': getConfig().imgQiuOn
                });
            }
        } else {
            if (data.deviceType == '0') {
                img.attr({
                    'src': getConfig().imgQingOff
                });
            } else {
                img.attr({
                    'src': getConfig().imgQiuOff
                });
            }
        }
    }
};


//在线不在线
function GetCameraStatus(cmID) {
    ViewWnd.GetNodeStatus(cmID);
    var state = ViewWnd.sNodeStatus;
    return state;
}


//TODO 摄像头
function drawVideoRow() {
    var data = videoListData;
    if (data == null || data.length == 0) {
        return;
    }
    $('#tobVideo').empty();
    $('#msgTexts').remove();
    //$('#tobVideo').html(response);//后台型
    //前台型
    var table = $('<table></table>');
    table.attr({'align': 'left', 'id': 'table_video'});
    var tbody = $('<tbody></tbody>');
    $('#tobVideo').append(table);
    var tr = $('<tr></tr>');
    tbody.append(tr);
    table.append(tbody);
    var th = $('<th>摄像头:</th>');
    tr.append(th);
    /*
     * 生成前面的摄像头列
     */
    var index = 0;
    var moreBool = false;
    for (var i = 0; i < data.length; i++) {
        if (i == 0) {
            videoId = "videoSpan" + data[i].id;
        }
        index = i;
        var td = createVideoTd(data[i]);
        tr.append(td);

        var tableWidth = table.width();
        var boundWidth = $('#tobVideo').width() - 100;
        if (tableWidth >= boundWidth) {
            td.remove();
            moreBool = true;
            break;
        }
    }
    /*
     * 生成【更多】列表
     */
    if (moreBool) {
        var moreTd = $('<td></td');
        moreTd.attr('id', 'videoMoreTd');
        tr.append(moreTd);

        var moreA = $('<a>更多...</a>');
        moreA.attr({
            'id': 'videoMoreA',
            'href': 'javascript:void(0);'
        });
        moreTd.append(moreA);

        var moreDiv = $('<div></div>');
        moreDiv.attr('class', 'menuBarMore');
        moreDiv.css('display', 'none');
        moreTd.append(moreDiv);

        var ul = $('<ul></ul>');
        moreDiv.append(ul);

        for (var i = index; i < data.length; i++) {
            var li = createVideoLi(data[i]);
            ul.append(li);
        }
    }

    //【更多】鼠标停留事件
    $('#videoMoreA').mouseover(function () {
        $("div.menuBarMore").show();
    });
    //鼠标离开选择框事件
    $('.menuBarMore').mouseleave(function () {
        $("div.menuBarMore").hide();
    });
    $("#tobVideo a").each(function (i) {
        $(this).click(function () {
            $("#tobVideo").find(".on").removeClass("on");
            $(this).addClass("on");
            return false;
        });
    });

}

//生成摄像头td
function createVideoTd(data) {
    var td = $('<td></td>');
    var a = $('<a></a>');
    a.attr({
        'href': 'javascript:void(0)',
        'class': 'videoa',
        'id': 'videoa' + data.id
    });
    var img = $('<img></img>');
    img.attr({
        'class': 'videoimg',
        'id': 'videoImg' + data.id
    });
    if (data.cameraType == '0') {
        img.attr({
            'src': getConfig().imgQingOn
        });
    } else {
        img.attr({
            'src': getConfig().imgQiuOn
        });
    }
    a.append(img);
    var span = $('<span>' + data.deviceName + '</span>');
    span.attr({
        'class': 'videospan',
        'id': 'videoSpan' + data.id
    });
    span.click(function () {
        videoVlick(data);
    });
    a.append(span);
    td.append(a);
    return td;
}


//生成摄像头li
function createVideoLi(data) {
    var li = $('<li></li>');
    var a = $('<a></a>');
    a.attr({
        'href': 'javascript:void(0)',
        'class': 'videoa',
        'id': 'videoa' + data.id
    });
    var img = $('<img></img>');
    img.attr({
        'class': 'videoimg',
        'id': 'videoImg' + data.id
    });
    if (data.cameraType == '0') {
        img.attr({
            'src': getConfig().imgQingOn
        });
    } else {
        img.attr({
            'src': getConfig().imgQiuOn
        });
    }
    a.append(img);
    var span = $('<span>' + data.deviceName + '</span>');
    span.attr({
        'class': 'videospan',
        'id': 'videoSpan' + data.id
    });
    span.click(function () {
        videoVlick(data);
    });
    a.append(span);
    li.append(a);

    return li;
}


// 停止播放
function vodStop() {
    if (hasStartVod == 0) {
        return;
    }
    if (objCtrl) {

        var ret = objCtrl.VodStop();
        if (ret != 1) {
            alert("停止失败");
        }
    }
    if (INTE) {
        clearInterval(INTE);
    }

    $("#progress").css("width", "0%");
    playSecond = 0;
}


function videoVlick(videoObj) {
    //isShowYuntai(videoObj.cameraType);
    //playVideo(videoObj);
    stopPlayVideo();
}


/**
 * 获取选中的摄像头信息
 */
function getActiveVideoInfo() {
    //首先找到视频信息对象
    //videoSpan255
    var videoSpan = $("#table_video tr:first td").find('.on').find('.videospan').attr('id');
    var videoId = videoSpan.substring('videoSpan'.length);
    var videoObj;
    for (var i in videoListData) {
        var o = videoListData[i];
        if (o.id == videoId) {
            videoObj = o;
            break;
        }
    }
    return videoObj
}

function downloadPlugin() {
    window.location.href = "/cpms/tools/VmsClientSetup.exe";
}

