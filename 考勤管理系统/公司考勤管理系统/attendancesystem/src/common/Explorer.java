package common;

import java.io.File;

public class Explorer {
	/**
	 * �ļ��Ƿ����?
	 * 
	 * @param file
	 * @return
	 */
	public static boolean existsFile(String file) {
		return new File(file).exists();
	}

	/**
	 * 
	 * @param file
	 */
	public static void existsAndCreateParent(String file) {
		File aFile = new File(file).getParentFile();
		if (!aFile.exists()) {
			aFile.mkdirs();
		}
	}

	/**
	 * ��bĿ¼
	 * 
	 * @param file
	 */
	public static void existsAndCreateSelf(String file) {
		File aFile = new File(file);
		if (!aFile.exists()) {
			aFile.mkdirs();
		}
	}

	/**
	 * �޸����?
	 * 
	 * @param source
	 * @param destination
	 * @return
	 */
	public static boolean renameTo(String source, String destination) {
		File sourceFile = new File(source);
		return sourceFile.renameTo(new File(destination));
	}

	public static void main(String[] args) {
		File file = new File(
				"E:\\work\\mewoo\\uploadFile\\user\\sample\\1\\1_D8D4146C7C35319D4C74B16B39EAEFAB.jpg");
		File file1 = new File(
				"E:\\work\\mewoo\\uploadFile\\user\\sample\\1\\xiaoming.jpg");
		if(file1.exists()){
			file1.delete();
		}
		file.renameTo(file1);
	}

	/**
	 * ɾ��һ���ļ�
	 * 
	 * @param file
	 * @return
	 */
	public static boolean deleteFile(String file) {
		return new File(file).delete();
	}
}
