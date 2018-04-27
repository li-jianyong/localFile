#pragma once
#include <objsafe.h>
#include "vms_webplayerPropPage.h"
#include "vms_clientrt.h"
#include "VMS_ComHeader.h"
#include "DMS_SWSInterface.h"

// vms_webplayerCtrl.h : vms_webplayerCtrl ActiveX �ؼ����������
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
// vms_webplayerCtrl : �й�ʵ�ֵ���Ϣ������� vms_webplayerCtrl.cpp��

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
// ���캯��
public:
	vms_webplayerCtrl();

// ��д
public:
	virtual void OnDraw(CDC* pdc, const CRect& rcBounds, const CRect& rcInvalid);
	virtual void DoPropExchange(CPropExchange* pPX);
	virtual void OnResetState();
	virtual void OnClose(DWORD dwSaveOption);
	//virtual BOOL OnSetObjectRects(LPCRECT lpRectPos, LPCRECT lpRectClip); // �����˸

// ʵ��
protected:
	~vms_webplayerCtrl();

	DECLARE_OLECREATE_EX(vms_webplayerCtrl)    // �๤���� guid
	DECLARE_OLETYPELIB(vms_webplayerCtrl)      // GetTypeInfo
	DECLARE_PROPPAGEIDS(vms_webplayerCtrl)     // ����ҳ ID
	DECLARE_OLECTLTYPE(vms_webplayerCtrl)		// �������ƺ�����״̬

// ��Ϣӳ��
	DECLARE_MESSAGE_MAP()

// ����ӳ��
	DECLARE_DISPATCH_MAP()

	afx_msg void AboutBox();

// �¼�ӳ��
	DECLARE_EVENT_MAP()

// ���Ⱥ��¼� ID
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

	int m_nmode;	// 0:ʵʱ��ģʽ(Ĭ��);1:VODģʽ
	int m_runmode;	// 0:������ת��ģʽ(Ĭ��);1:�ͻ���ֱ��ģʽ
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
	//BYTE *image_buffer; //ָ��λͼbuffer��ȫ��ָ�룬window�����ظ�ʽ: BGRA(4���ֽ�)

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
	*��������Ptz_Control
	*��  �ܣ���̨����
	*��  ����
		winID						���ڱ��
		serverUuid					uuid
		dwDeviceID					�豸Id
		dwCameraID					����ͷid
		dChannelID					ͨ��id
		strIP						�豸ip
		ptzCotlCommand				��������
		ptzComSpeed					�����ٶ�
		bState						״̬
	*����ֵ��
		int					�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG Ptz_Control(LONG winID,LPCTSTR serverUuid,LONG dwDeviceID,LONG dwCameraID,LONG dChannelID,LPCTSTR strIP,LONG ptzCotlCommand,LONG ptzComSpeed,LONG bState);


	/************************************************************************************************
	*��������VodSeek
	*��  �ܣ���DVR��Ƶ¼����ϲ����ƶ���VOD��Ƶ�ļ�
	*��  ����
		winID						����ID
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
		playID						����ID
		vodMode						VOD�㲥���� 0���ļ� 1:ʱ��
		startTime					VOD�㲥��ʼʱ��
		endTime						VOD�㲥����ʱ��
	*����ֵ��
		LONG						���ҽ�������ֹͣ�����ã�
	*��  ע��
	*************************************************************************************************/
	LONG VodSeek(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG playID, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime, LONG seekTime);

	/////////////////////////////// ���Ϸǵ��ü��ӿ� //////////////////////////////////////////
	

	/////////////////////////////// ����Ϊ�����ĵ��ü��ӿ� //////////////////////////////////////////
	/************************************************************************************************
	*��������Play
	*��  �ܣ�����ʵʱ��
	*��  ����
		winID						���ڱ��
		streamType					��������
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG Play(LONG winID, LONG streamType,LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd);
	
	/************************************************************************************************
	*��������Stop
	*��  �ܣ�ֹͣ����ʵʱ��
	*��  ����
		winID						���ڱ��
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG Stop(LONG winID);

	/************************************************************************************************
	*��������InitCtrl
	*��  �ܣ����ӷ�����
	*��  ����
		split						��������
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע�����ſؼ����ڻ�
	*************************************************************************************************/
	LONG InitCtrl(LONG split);
	/************************************************************************************************
	*��������InitWindow
	*��  �ܣ����ڻ���ǰ����
	*��  ����
		winID					    ����ID
		serverUuid					uuid
		server						������ip
		port						�������˿�
		runMode						ģʽ 0��ʵʱ��ģʽ  1��VODģʽ
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע������Play����ǰ��Ҫ���øú���
	*************************************************************************************************/
	LONG InitWindow(LONG winID, LPCTSTR serverUuid,LPCTSTR server, LONG port, LONG runMode);

	/************************************************************************************************
	*��������StopAll
	*��  �ܣ�ֹͣȫ����Ƶ��
	*��  ����
	*����ֵ��
		
	*��  ע���ر�IE����ʱ��Ҫ����
	*************************************************************************************************/
	void StopAll(void);

	/************************************************************************************************
	*��������GetSelWin
	*��  �ܣ�ȡ�ñ�ѡ�񴰿�ID
	*��  ����
	*����ֵ��
		��ѡ�񴰿�ID
	*��  ע��
	*************************************************************************************************/
	LONG GetSelWin(void);

	/************************************************************************************************
	*��������SelectFolder
	*��  �ܣ�ѡ��ͼƬ/��Ƶ�ļ�������ļ���
	*��  ����
	*			winID		����ID
	*			type		���� 0����Ƶ����ͼƬ�����ļ��� 1����ȡ����Ƶ�ļ������ļ���
	*����ֵ��
		1/0     �ɹ�/ʧ��
	*��  ע��  �ڵ��ý�ȡ����ǰ���øú�������Ҫ�жϸú����ķ���ֵ���������ֵΪ0�����ɵ��ý�ȡ����
	*************************************************************************************************/
	LONG SelectFolder(LONG winID, LONG type);

	/************************************************************************************************
	*��������GetWinState
	*��  �ܣ�ȡ�ô���״̬
	*��  ����
	*			winID		����ID
	*����ֵ��
		1/0     ����/δ����
	*��  ע��  
	*************************************************************************************************/
	LONG GetWinState(LONG winId);
//VOD

	/************************************************************************************************
	*��������VodPlay
	*��  �ܣ�����VOD�㲥��
	*��  ����
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
		vodMode						VOD�㲥���� 0���ļ� 1:ʱ��
		startTime					VOD�㲥��ʼʱ��
		endTime						VOD�㲥����ʱ��
	*����ֵ��
		1/0							�ɹ�/ʧ��
	*��  ע�����Ŵ���Ϊ��ǰ��ѡ�񴰿�
	*************************************************************************************************/
	LONG VodPlay(LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*��������VodStopByWin
	*��  �ܣ�ֹͣVOD�㲥��
	*��  ����
		winID						����ID		
	*����ֵ��
		1/0							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG VodStopByWin(LONG winID);

	/************************************************************************************************
	*��������VodPlayByWin
	*��  �ܣ�����VOD�㲥��
	*��  ����
		winID						����ID
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
		vodMode						VOD�㲥���� 0���ļ� 1:ʱ��
		startTime					VOD�㲥��ʼʱ��
		endTime						VOD�㲥����ʱ��
	*����ֵ��
		1/0							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG VodPlayByWin(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*��������VodDownload
	*��  �ܣ�VOD��Ƶ����
	*��  ����
		winID						����ID
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
		vodMode						VOD�㲥���� 0���ļ� 1:ʱ��
		startTime					VOD�㲥��ʼʱ��
		endTime						VOD�㲥����ʱ��
	*����ֵ��
		BSTR						�ļ������ؾ����ֹͣ�����ã�
	*��  ע��
	*************************************************************************************************/
	BSTR VodDownload(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);
	//LONG VodDownload(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);
	

	/************************************************************************************************
	*��������VodDownload
	*��  �ܣ�ֹͣVOD��Ƶ������
	*��  ����
		BSTR						�ļ������ؾ��
	*����ֵ��
		1/0							�ɹ�/ʧ��
	*��  ע������ΪVodDownload�����ķ���ֵ
	*************************************************************************************************/
	LONG StopVodDownload(LPCTSTR downloadFile);
	
	//LPCTSTR VodSplitPicture(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime, LONG splitTime);

	/************************************************************************************************
	*��������VodSplitPicture
	*��  �ܣ���DVR��Ƶ¼����ϲ����ƶ���VOD��Ƶ�ļ�
	*��  ����
		winID						����ID
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
		playID						����ID
		vodMode						VOD�㲥���� 0���ļ� 1:ʱ��
		startTime					VOD�㲥��ʼʱ��
		endTime						VOD�㲥����ʱ��
		splitCnt					VOD��������
		splitTime					VOD������ʱ��
	*����ֵ��
		BSTR						�ļ�����λ��
	*��  ע��
	*************************************************************************************************/
	BSTR VodSplitPicture(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime, LONG splitCnt, LONG splitTime);

	/************************************************************************************************
	*��������GetVodFileList
	*��  �ܣ�ȡ��VOD���ҽ�����ļ��б�
	*��  ����
		winID						����ID
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
		playID						����ID
		vodMode						VOD�㲥���� 0���ļ� 1:ʱ��
		startTime					VOD�㲥��ʼʱ��
		endTime						VOD�㲥����ʱ��
	*����ֵ��
		BSTR						���ҽ���ļ��б� 
	*��  ע������ֵJSON�к��в��ҽ�������ֹͣ�����ã�
	*************************************************************************************************/
	BSTR GetVodFileList(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*��������StopVodFileList
	*��  �ܣ�ֹͣVOD����
	*��  ����
		winID						����ID
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
		getFileListID				���ҽ�����������GetVodFileList�ķ���ֵ�к��У�
		vodMode						VOD�㲥���� 0���ļ� 1:ʱ��
		startTime					VOD�㲥��ʼʱ��
		endTime						VOD�㲥����ʱ��
	*����ֵ��
		BSTR						���ҽ���ļ��б�
	*��  ע��
	*************************************************************************************************/
	LONG StopVodFileList(LONG winID, LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd, LONG getFileListID, LONG vodMode, LPCTSTR startTime, LPCTSTR endTime);

	/************************************************************************************************
	*��������VodCommand
	*��  �ܣ�¼��طſ���
	*��  ����
		serverUuid					uuid	
		pplay_session				ʵʱ�����
		strVodUuid					
		vodCommand					��������	
		uParam		
	*����ֵ��
		int					�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG VodCommand(LPCTSTR serverUuid,BSTR pplay_session,BSTR strVodUuid,LONG vodCommand,BSTR uParam);
	
	/************************************************************************************************
	*��������Screen_Shot
	*��  �ܣ�ʵʱ������
	*��  ����
		winID						���ڱ��
		serverUuid					uuid
		picture_path				����ͼƬ·��
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG Screen_Shot(LONG winID,LPCTSTR serverUuid,LPCTSTR picture_path);
	
	/************************************************************************************************
	*��������FindFile
	*��  �ܣ�����¼��
	*��  ����
		winID						���ڱ��
		serverUuid					uuid
		devicePort					�豸�˿ں�
		strIP						�豸ip
		deviceUser					�豸�û���
		devicePwd					�豸����
		dwDeviceID					�豸Id
		dwReserved
		DeviceCnts					���豸��
		DeviceType					�豸����
		dwCameraID					����ͷid
		dChannelID					ͨ��id
		vodMode						����ģʽ
		enumFileType				�ļ�����
		startTime					��ʼʱ��
		endTime						����ʱ��
	*����ֵ��
		BSTR						���
	*��  ע��
	*************************************************************************************************/
	BSTR FindFile(LONG winID,LPCTSTR serverUuid,LONG devicePort,LPCTSTR strIP,LPCTSTR deviceUser, LPCTSTR devicePwd,LONG dwDeviceID,LONG dwReserved,LONG DeviceCnts,LONG DeviceType,LONG dwCameraID,LONG dChannelID,LONG vodMode,LONG enumFileType,LONG startTime,LONG endTime);

	/************************************************************************************************
	*��������find_next_file
	*��  �ܣ�����¼����Ϣ
	*��  ����
		serverUuid					uuid
		BSTR						��	FindFile ���صľ��
	*����ֵ��
		BSTR						¼����Ϣ
	*��  ע��
	*************************************************************************************************/
	BSTR find_next_file(LPCTSTR serverUuid,BSTR llFindHandle);
	
	/************************************************************************************************
	*��������FindStopFile
	*��  �ܣ�ֹͣ¼���ѯ
	*��  ����
		serverUuid					uuid
		BSTR						��	FindFile ���صľ��
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/	
	LONG FindStopFile(LPCTSTR serverUuid,BSTR llFindHandle);
	
	/************************************************************************************************
	*��������StartVodStream
	*��  �ܣ���ʼ¼�񲥷�
	*��  ����
		winID						���ڱ��
		devicePort					�豸�˿ں�
		strIP						�豸ip
		deviceUser					�豸�û���
		devicePwd					�豸����
		dwDeviceID					�豸Id
		dwReserved
		DeviceCnts					���豸��
		DeviceType					�豸����
		dwCameraID					����ͷid
		dChannelID					ͨ��id
		startTime					��ʼʱ��
		endTime						����ʱ��
		dold_sessionid
		serveruuid					uuid
		dReserved
	*����ֵ��
		BSTR						���ž��
	*��  ע��
	*************************************************************************************************/
	BSTR StartVodStream(LONG winID,LONG devicePort,BSTR strIP,BSTR deviceUser, BSTR devicePwd,LONG dwDeviceID,LONG dwReserved,LONG DeviceCnts,LONG DeviceType,LONG dwCameraID,LONG dChannelID,LONG startTime,LONG endTime,LONG dold_sessionid,LPCTSTR serveruuid, LONG dReserved);
	
	/************************************************************************************************
	*��������StopVodStream
	*��  �ܣ�ֹͣ¼�񲥷�
	*��  ����
		serverUuid					uuid
		play_session				�� StartVodStream ���صľ��
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/		
	LONG StopVodStream(LPCTSTR serverUuid,BSTR play_session);

	/************************************************************************************************
	*��������Recorde_Screen_Shot
	*��  �ܣ�����¼��ʱ����
	*��  ����
		winID						���ڱ��
		serverUuid					uuid
		picture_path				����ͷ���ƣ��豸��+����ͷ��Ż�ͨ���ţ�
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG Recorde_Screen_Shot(LONG winID,LPCTSTR serverUuid,LPCTSTR picture_path);

	/************************************************************************************************
	*��������StartRecorde
	*��  �ܣ���ʼ¼��
	*��  ����
		winID						���ڱ��
		serverUuid					uuid
		video_path					����¼���·��
	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG StartRecorde(LONG winID,LPCTSTR serverUuid,LPCTSTR video_path);

	/************************************************************************************************
	*��������GetImageConfiguration
	*��  �ܣ��õ�ͼ���������Ϣ
	*��  ����
		winID						���ڱ��
		serverUuid					uuid
		deviceName					�豸����
		DeviceType					�豸����
		deviceHost					�豸ip
		devicePort					�豸�˿ں�
		dwDeviceID					�豸Id
		dChannelID					ͨ��id
		deviceUser					�豸�û���
		devicePwd					�豸����
	*����ֵ��
		BSTR						ͼ����Ϣ
	*��  ע��
	*************************************************************************************************/
	BSTR GetImageConfiguration(LONG winID,LPCTSTR serverUuid, LPCTSTR deviceName, LONG deviceType, LPCTSTR deviceHost, LONG devicePort, LONG deviceId, LONG deviceChanel, LPCTSTR deviceUser, LPCTSTR devicePwd);
	
	/************************************************************************************************
	*��������SetImageConfiguration
	*��  �ܣ�����ͼƬ����Ϣ
	*��  ����
		winID						���ڱ��
		fBrightness					����
		fColorSaturation			���Ͷ�
		fContrast					�Աȶ�
		fSharpness					���
	*����ֵ��
		BSTR						�õ������õ�ͼ�������Ϣ
	*��  ע��
	*************************************************************************************************/
	BSTR SetImageConfiguration(LONG winID,LPCTSTR fBrightness,LPCTSTR fColorSaturation,LPCTSTR fContrast,LPCTSTR fSharpness);
	
	/************************************************************************************************
	*��������TransferKeyCommand
	*��  �ܣ������¼�������
	*��  ����
		winID							���ڱ��
		keyCode							������
		keyParam1						����1
		keyParam2						����2

	*����ֵ��
		int							�ɹ�/ʧ��
	*��  ע��
	*************************************************************************************************/
	LONG TransferKeyCommand(LONG winID,LONG keyCode, LONG keyParam1, LONG keyParam2);
	/////////////////////////////// ����Ϊ�����ĵ��ü��ӿ� //////////////////////////////////////////
	
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

