package com.solidextend.core.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Enumeration;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;

public class FileUtils {
	public static String getParentPath(File f){
		return f.getParent();
	}
	public static void decompress(String srcPath, String dest) throws Exception {

        File file = new File(srcPath);

        if (!file.exists()) {

            throw new RuntimeException(srcPath + "所指文件不存在");

        }

        ZipFile zf = new ZipFile(file,"gbk");

        Enumeration entries = zf.getEntries();

        ZipEntry entry = null;

        while (entries.hasMoreElements()) {

            entry = (ZipEntry) entries.nextElement();

            System.out.println("解压" + entry.getName());

            if (entry.isDirectory()) {

                String dirPath = dest + File.separator + entry.getName();

                File dir = new File(dirPath);

                dir.mkdirs();

            } else {

                // 表示文件

                File f = new File(dest + File.separator + entry.getName());

                if (!f.exists()) {

                    String dirs = FileUtils.getParentPath(f);

                    File parentDir = new File(dirs);

                    parentDir.mkdirs();

 

                }

                f.createNewFile();

                // 将压缩文件内容写入到这个文件中

                InputStream is = zf.getInputStream(entry);

                FileOutputStream fos = new FileOutputStream(f);

 

                int count;

                byte[] buf = new byte[8192];

                while ((count = is.read(buf)) != -1) {

                    fos.write(buf, 0, count);

                }

                is.close();

                fos.close();

            }

        }

    }
	public static void decompress(String srcPath) throws Exception {

        File file = new File(srcPath);

        if (!file.exists()) {

            throw new RuntimeException(srcPath + "所指文件不存在");

        }else{
        	
        	String dest=srcPath.substring(0,srcPath.lastIndexOf("."));
        	decompress(srcPath,dest);
        }

        

    }
}
