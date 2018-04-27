#pragma once
#include <objsafe.h>
#include "vms_webplayerPropPage.h"
#include "vms_clientrt.h"
#include "VMS_ComHeader.h"
#include "DMS_SWSInterface.h"

// vms_webplayerCtrl.h : vms_webplayerCtrl ActiveX 控件类的声明。
//TODO PRE DELETE BEGIN
#include "log4cxx/PropertyConfigurator.h"
#include "log4cxx/helpers/exception.h"
#include "DMS_IDeviceInterface.h"
#include "VMS_PublicStructDef.h"
#include "DMS_Object.h"
#include "DMS_IDeviceCom.h"
//TODO PRE DELETE END

#include<boost/unordered_map.hpp> 
#include "VMS_OSMutex.h"

typedef DMS_IDeviceCom* (*funvms_create_object)();
// vms_webplayerCtrl : 有关实现的信息，请参阅 vms_webplayerCtrl.cpp。

class vms_webplayerCtrl : public COleControl,public RSSink
{
	DECLARE_DYNCREATE(vms_webplayerCtrl)
	// for ObjectSafety start 
	DECLARE_INTERFACE_MAP()   
	BEGIN_INTERFACE_PART(ObjSafe,   IObjectSafety)   
		STDMETHOD_(HRESULT,   GetInterfaceSafetyOptions)   (     
		/*   [in]   */   REFIID   riid,   
		/*   [out]   */   DWORD   __RPC_FAR   *pdwSupportedOptions,   
		/*   [out]   */   DWORD   __RPC_FAR   *pdwEnabledOptions   
		);   

		STDMETHOD_(HRESULT,   SetInterfaceSafetyOptions)   (     
			/*   [in]   */   REFIID   riid,   
			/*   [in]   */   DWORD   dwOptionSetMask,   
			/*   [in]   */   DWORD   dwEnabledOptions   
			);   
	END_INTERFACE_PART(ObjSafe); 
	// for ObjectSafety end 
// 构造函数
public:
	vms_webplayerCtrl();

// 重写
public:
	virtual void OnDraw(CDC* pdc, const CRect& rcBounds, const CRect& rcInvalid);
	virtual void DoPropExchange(CPropExchange* pPX);
	virtual void OnResetState();
	virtual void OnClose(DWORD dwSaveOption);
	//virtual BOOL OnSetObjectRects(LPCRECT lpRectPos, LPCRECT lpRectClip); // 解决闪烁

// 实现
protected:
	~vms_webplayerCtrl();

	DECLARE_OLECREATE_EX(vms_webplayerCtrl)    // 类工厂和 guid
	DECLARE_OLETYPELIB(vms_webplayerCtrl)      // GetTypeInfo
	DECLARE_PROPPAGEIDS(vms_webplayerCtrl)     // 属性页 ID
	DECLARE_OLECTLTYPE(vms_webplayerCtrl)		// 类型名称和杂项状态

// 消息映射
	DECLARE_MESSAGE_MAP()

// 调度映射
	DECLARE_DISPATCH_MAP()

	afx_msg void AboutBox();

// 事件映射
	DECLARE_EVENT_MAP()

// 调度和事件 ID
public:
	enum {
		dispidInitWindow = 36L,
		dispidSelectFolder = 35L,
		dispidTransferKeyCommand = 34L,
		dispidSetImageConfiguration = 33L,
		dispidGetImageConfiguration = 32L,
		dispidStartRecorde = 31L,
		dispidRecorde_Screen_Shot = 30L,
		dispidStopVodStream = 29L,
		dispidStartVodStream = 28L,
		dispidFindStopFile = 27L,
		dispidfind_next_file = 26L,
		dispidFindFile = 25L,
		dispidScreen_Shot = 24L,
		dispidPtz_Control = 23L,
		dispidSetTextInfo = 22L,
		eventidOnWinSelected = 1L,
		dispidGetWinState = 21L,
		dispidGetSelWin = 20L,

		dispidVodCommand = 19L,
		dispidStopVodFileList = 18L,
		dispidGetVodFileList = 17L,
		dispidVodSplitPicture = 16L,
		dispidVodSeek = 15L,
		dispidStopVodDownload = 14L,
		dispidVodDownload = 13L,
		dispidInitVodCtrl = 12L,
		dispidVodStopByWin = 11L,
		dispidVodPlayByWin = 10L,
		dispidVodStop = 9L,
		dispidVodPlay = 8L,

		dispidStopByWin = 7L,
		dispidPlayByWin = 6L,
		dispidStopAll = 5L,
		dispidSetSplit = 4L,
		dispidInitCtrl = 3L,
		dispidStop = 2L,
		dispidPlay = 1L
	};

// vms start 
private:

	OSMutex					m_visitThisMtx;
	boost::unordered_map<std::string,VMSClientRuntime*> ump_uuid_client;

	int m_server_port;
	std::string m_server_ip;
	unsigned long *m_ptr_play_session;
	int m_init_split;

	PUBLIC_STRUCT::ST_DeviceInfo m_voddevice_info;
	PUBLIC_STRUCT::ST_VodInfo	 m_vod_info;
	std::string	 m_vod_struuid;

	int m_nmode;	// 0:实时流模式(默认);1:VOD模式
	int m_runmode;	// 0:服务器转发模式(默认);1:客户端直连模式
	unsigned long long m_vod_play_handle;

	unsigned long m_vod_mode;
	unsigned long long m_vod_start_time;
	unsigned long long m_vod_end_time;

	unsigned long long m_vod_download_start_time;
	unsigned long long m_vod_download_end_time;
	std::string m_vod_filepathname;
	int m_vod_download_mode;
	unsigned long long m_vod_download_handle;
	unsigned long long m_vod_download_object;
	bool				m_bvod_has_play;
	std::string			m_vod_server_uuid;
	std::string			m_vod_download_uuid;
	std::string			m_vod_split_path;
	//BYTE *image_buffer; //指向位图buffer的全局指针，window下像素格式: BGRA(4个字节)

public:
	vms_webplayerPropPage m_main_window;
	BOOL PreTranslateMessage(MSG* pMsg);
	unsigned long GetSessionId(LONG pWinID){if(m_ptr_play_session){m_ptr_play_session[pWinID]; } else {return -1;}}
	VMSClientRuntime* GetRunTime(std::string pUUID){VMSClientRuntime *pclient_runtime = ump_uuid_client[pUUID];if(pclient_runtime){return ump_uuid_client[pUUID];}else{return NULL;}}
// vms end 
public:
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	std::string SelFilePath();
public:
	void SetSplit(LONG nSplit);
	LONG PlayByWin(LONG winID, LONG streamType, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd);
	LONG StopByWin(LONG winID);
	LONG SetTextInfo(LONG winID, LPCTSTR textInfo);
	LONG VodStop(void);
	LONG InitVodCtrl(LPCTSTR server, LONG port, LONG split, LONG runMode);
	
	/************************************************************************************************
	*函数名：Ptz_Control
	*功  能：云台控制
	*参  数：
		winID						窗口编号
		serverUuid					uuid
		dwDeviceID					设备Id
		dwCameraID					摄像头id
		dChannelID					通道id
		strIP						设备ip
		ptzCotlCommand				控制命令
		ptzComSpeed					控制速度
		bState						状态
	*返回值：
		int					成功/失败
	*备  注：
	*************************************************************************************************/
	LONG Ptz_Control(LONG winID,LPCTSTR serverUuid,LONG dwDeviceID,LONG dwCameraID,LONG dChannelID,LPCTSTR strIP,LONG ptzCotlCommand,LONG ptzComSpeed,LONG bState);


	/************************************************************************************************
	*函数名：VodSeek
	*功  能：在DVR视频录像机上查找制定的VOD视频文件
	*参  数：
		winID						窗口ID
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
		playID						播放ID
		vodMode						VOD点播类型 0：文件 1:时间
		startTime					VOD点播开始时间
		endTime						VOD点播结束时间
	*返回值：
		LONG						查找结果句柄（停止查找用）
	*备  注：
	*************************************************************************************************/
	LONG VodSeek(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG playID, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime, LONG seekTime);

	/////////////////////////////// 以上非调用级接口 //////////////////////////////////////////
	

	/////////////////////////////// 以下为公开的调用级接口 //////////////////////////////////////////
	/************************************************************************************************
	*函数名：Play
	*功  能：播放实时流
	*参  数：
		winID						窗口编号
		streamType					码流类型
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG Play(LONG winID, LONG streamType,LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd);
	
	/************************************************************************************************
	*函数名：Stop
	*功  能：停止播放实时流
	*参  数：
		winID						窗口编号
	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG Stop(LONG winID);

	/************************************************************************************************
	*函数名：InitCtrl
	*功  能：连接服务器
	*参  数：
		split						画面数量
	*返回值：
		int							成功/失败
	*备  注：播放控件初期化
	*************************************************************************************************/
	LONG InitCtrl(LONG split);
	/************************************************************************************************
	*函数名：InitWindow
	*功  能：初期化当前窗口
	*参  数：
		winID					    窗口ID
		serverUuid					uuid
		server						服务器ip
		port						服务器端口
		runMode						模式 0：实时流模式  1：VOD模式
	*返回值：
		int							成功/失败
	*备  注：调用Play函数前需要调用该函数
	*************************************************************************************************/
	LONG InitWindow(LONG winID, LPCTSTR serverUuid,LPCTSTR server, LONG port, LONG runMode);

	/************************************************************************************************
	*函数名：StopAll
	*功  能：停止全部视频流
	*参  数：
	*返回值：
		
	*备  注：关闭IE窗口时需要调用
	*************************************************************************************************/
	void StopAll(void);

	/************************************************************************************************
	*函数名：GetSelWin
	*功  能：取得被选择窗口ID
	*参  数：
	*返回值：
		被选择窗口ID
	*备  注：
	*************************************************************************************************/
	LONG GetSelWin(void);

	/************************************************************************************************
	*函数名：SelectFolder
	*功  能：选择图片/视频文件保存的文件夹
	*参  数：
	*			winID		窗口ID
	*			type		类型 0：视频截屏图片保存文件夹 1：截取的视频文件保存文件夹
	*返回值：
		1/0     成功/失败
	*备  注：  在调用截取函数前调用该函数，需要判断该函数的返回值，如果返回值为0，不可调用截取函数
	*************************************************************************************************/
	LONG SelectFolder(LONG winID, LONG type);

	/************************************************************************************************
	*函数名：GetWinState
	*功  能：取得窗口状态
	*参  数：
	*			winID		窗口ID
	*返回值：
		1/0     播放/未播放
	*备  注：  
	*************************************************************************************************/
	LONG GetWinState(LONG winId);
//VOD

	/************************************************************************************************
	*函数名：VodPlay
	*功  能：播放VOD点播流
	*参  数：
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
		vodMode						VOD点播类型 0：文件 1:时间
		startTime					VOD点播开始时间
		endTime						VOD点播结束时间
	*返回值：
		1/0							成功/失败
	*备  注：播放窗口为当前被选择窗口
	*************************************************************************************************/
	LONG VodPlay(LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*函数名：VodStopByWin
	*功  能：停止VOD点播流
	*参  数：
		winID						窗口ID		
	*返回值：
		1/0							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG VodStopByWin(LONG winID);

	/************************************************************************************************
	*函数名：VodPlayByWin
	*功  能：播放VOD点播流
	*参  数：
		winID						窗口ID
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
		vodMode						VOD点播类型 0：文件 1:时间
		startTime					VOD点播开始时间
		endTime						VOD点播结束时间
	*返回值：
		1/0							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG VodPlayByWin(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*函数名：VodDownload
	*功  能：VOD视频下载
	*参  数：
		winID						窗口ID
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
		vodMode						VOD点播类型 0：文件 1:时间
		startTime					VOD点播开始时间
		endTime						VOD点播结束时间
	*返回值：
		BSTR						文件的下载句柄（停止下载用）
	*备  注：
	*************************************************************************************************/
	BSTR VodDownload(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);
	//LONG VodDownload(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);
	

	/************************************************************************************************
	*函数名：VodDownload
	*功  能：停止VOD视频流下载
	*参  数：
		BSTR						文件的下载句柄
	*返回值：
		1/0							成功/失败
	*备  注：参数为VodDownload函数的返回值
	*************************************************************************************************/
	LONG StopVodDownload(LPCTSTR downloadFile);
	
	//LPCTSTR VodSplitPicture(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime, LONG splitTime);

	/************************************************************************************************
	*函数名：VodSplitPicture
	*功  能：在DVR视频录像机上查找制定的VOD视频文件
	*参  数：
		winID						窗口ID
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
		playID						播放ID
		vodMode						VOD点播类型 0：文件 1:时间
		startTime					VOD点播开始时间
		endTime						VOD点播结束时间
		splitCnt					VOD截屏数量
		splitTime					VOD截屏总时间
	*返回值：
		BSTR						文件保存位置
	*备  注：
	*************************************************************************************************/
	BSTR VodSplitPicture(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime, LONG splitCnt, LONG splitTime);

	/************************************************************************************************
	*函数名：GetVodFileList
	*功  能：取得VOD查找结果的文件列表
	*参  数：
		winID						窗口ID
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
		playID						播放ID
		vodMode						VOD点播类型 0：文件 1:时间
		startTime					VOD点播开始时间
		endTime						VOD点播结束时间
	*返回值：
		BSTR						查找结果文件列表 
	*备  注：返回值JSON中含有查找结果句柄（停止查找用）
	*************************************************************************************************/
	BSTR GetVodFileList(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*函数名：StopVodFileList
	*功  能：停止VOD查找
	*参  数：
		winID						窗口ID
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
		getFileListID				查找结果句柄（函数GetVodFileList的返回值中含有）
		vodMode						VOD点播类型 0：文件 1:时间
		startTime					VOD点播开始时间
		endTime						VOD点播结束时间
	*返回值：
		BSTR						查找结果文件列表
	*备  注：
	*************************************************************************************************/
	LONG StopVodFileList(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG getFileListID, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*函数名：VodCommand
	*功  能：录像回放控制
	*参  数：
		serverUuid					uuid	
		pplay_session				实时流句柄
		strVodUuid					
		vodCommand					控制命令	
		uParam		
	*返回值：
		int					成功/失败
	*备  注：
	*************************************************************************************************/
	LONG VodCommand(LPCTSTR serverUuid,BSTR pplay_session,BSTR strVodUuid,LONG vodCommand,BSTR uParam);
	
	/************************************************************************************************
	*函数名：Screen_Shot
	*功  能：实时流截屏
	*参  数：
		winID						窗口编号
		serverUuid					uuid
		picture_path				保存图片路径
	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG Screen_Shot(LONG winID,LPCTSTR serverUuid,LPCTSTR picture_path);
	
	/************************************************************************************************
	*函数名：FindFile
	*功  能：查找录像
	*参  数：
		winID						窗口编号
		serverUuid					uuid
		devicePort					设备端口号
		strIP						设备ip
		deviceUser					设备用户名
		devicePwd					设备密码
		dwDeviceID					设备Id
		dwReserved
		DeviceCnts					子设备数
		DeviceType					设备类型
		dwCameraID					摄像头id
		dChannelID					通道id
		vodMode						播放模式
		enumFileType				文件类型
		startTime					开始时间
		endTime						结束时间
	*返回值：
		BSTR						句柄
	*备  注：
	*************************************************************************************************/
	BSTR FindFile(LONG winID,LPCTSTR serverUuid,LONG devicePort,LPCTSTR strIP,LPCTSTR deviceUser, LPCTSTR devicePwd,LONG dwDeviceID,LONG dwReserved,LONG DeviceCnts,LONG DeviceType,LONG dwCameraID,LONG dChannelID,LONG vodMode,LONG enumFileType,LONG startTime,LONG endTime);

	/************************************************************************************************
	*函数名：find_next_file
	*功  能：返回录像信息
	*参  数：
		serverUuid					uuid
		BSTR						由	FindFile 返回的句柄
	*返回值：
		BSTR						录像信息
	*备  注：
	*************************************************************************************************/
	BSTR find_next_file(LPCTSTR serverUuid,BSTR llFindHandle);
	
	/************************************************************************************************
	*函数名：FindStopFile
	*功  能：停止录像查询
	*参  数：
		serverUuid					uuid
		BSTR						由	FindFile 返回的句柄
	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/	
	LONG FindStopFile(LPCTSTR serverUuid,BSTR llFindHandle);
	
	/************************************************************************************************
	*函数名：StartVodStream
	*功  能：开始录像播放
	*参  数：
		winID						窗口编号
		devicePort					设备端口号
		strIP						设备ip
		deviceUser					设备用户名
		devicePwd					设备密码
		dwDeviceID					设备Id
		dwReserved
		DeviceCnts					子设备数
		DeviceType					设备类型
		dwCameraID					摄像头id
		dChannelID					通道id
		startTime					开始时间
		endTime						结束时间
		dold_sessionid
		serveruuid					uuid
		dReserved
	*返回值：
		BSTR						播放句柄
	*备  注：
	*************************************************************************************************/
	BSTR StartVodStream(LONG winID,LONG devicePort,BSTR strIP,BSTR deviceUser, BSTR devicePwd,LONG dwDeviceID,LONG dwReserved,LONG DeviceCnts,LONG DeviceType,LONG dwCameraID,LONG dChannelID,LONG startTime,LONG endTime,LONG dold_sessionid,LPCTSTR serveruuid, LONG dReserved);
	
	/************************************************************************************************
	*函数名：StopVodStream
	*功  能：停止录像播放
	*参  数：
		serverUuid					uuid
		play_session				由 StartVodStream 返回的句柄
	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/		
	LONG StopVodStream(LPCTSTR serverUuid,BSTR play_session);

	/************************************************************************************************
	*函数名：Recorde_Screen_Shot
	*功  能：播放录像时截屏
	*参  数：
		winID						窗口编号
		serverUuid					uuid
		picture_path				摄像头名称（设备名+摄像头编号或通道号）
	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG Recorde_Screen_Shot(LONG winID,LPCTSTR serverUuid,LPCTSTR picture_path);

	/************************************************************************************************
	*函数名：StartRecorde
	*功  能：开始录像
	*参  数：
		winID						窗口编号
		serverUuid					uuid
		video_path					保存录像的路径
	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG StartRecorde(LONG winID,LPCTSTR serverUuid,LPCTSTR video_path);

	/************************************************************************************************
	*函数名：GetImageConfiguration
	*功  能：得到图像参数的信息
	*参  数：
		winID						窗口编号
		serverUuid					uuid
		deviceName					设备名称
		DeviceType					设备类型
		deviceHost					设备ip
		devicePort					设备端口号
		dwDeviceID					设备Id
		dChannelID					通道id
		deviceUser					设备用户名
		devicePwd					设备密码
	*返回值：
		BSTR						图像信息
	*备  注：
	*************************************************************************************************/
	BSTR GetImageConfiguration(LONG winID,LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd);
	
	/************************************************************************************************
	*函数名：SetImageConfiguration
	*功  能：设置图片的信息
	*参  数：
		winID						窗口编号
		fBrightness					亮度
		fColorSaturation			饱和度
		fContrast					对比度
		fSharpness					锐度
	*返回值：
		BSTR						得到你设置的图像参数信息
	*备  注：
	*************************************************************************************************/
	BSTR SetImageConfiguration(LONG winID,LPCTSTR fBrightness,LPCTSTR fColorSaturation,LPCTSTR fContrast,LPCTSTR fSharpness);
	
	/************************************************************************************************
	*函数名：TransferKeyCommand
	*功  能：键盘事件处理函数
	*参  数：
		winID							窗口编号
		keyCode							按键码
		keyParam1						参数1
		keyParam2						参数2

	*返回值：
		int							成功/失败
	*备  注：
	*************************************************************************************************/
	LONG TransferKeyCommand(LONG winID,LONG keyCode, LONG keyParam1, LONG keyParam2);
	/////////////////////////////// 以上为公开的调用级接口 //////////////////////////////////////////
	
	//afx_msg void OnWindowPosChanging(WINDOWPOS* lpwndpos);
	afx_msg void OnSize(UINT nType, int cx, int cy);
public:
	void vms_webplayerCtrl::NotifyBasicData(ST_MediaBasicData *pBasicData);

	//LONG SaveBmpPicture(CWnd * RiCnd, std::string save_path);
	void FireWinSelected(long id);

	std::string IntToString(long num);
	float StringToFloat(std::string str);
	std::string FloatToString(float flnum);
protected:

	void OnWinSelected(LONG id)
	{
		FireEvent(eventidOnWinSelected, EVENT_PARAM(VTS_I4), id);
	}
};

