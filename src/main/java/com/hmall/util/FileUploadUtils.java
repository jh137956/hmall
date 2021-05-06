package com.hmall.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
public class FileUploadUtils {

	public static String uploadFile(String uploadPath, String originName, MultipartFile multipartFile) throws Exception{
		
		// 파일 경로 설정 ex) 날짜경로
		String savedPath = getDateFolder(uploadPath); // 날짜포맷의 폴더명 ex.\\2020\\03\\13
		
		// 파일명 설정 ex) uuid_파일명
		UUID uuid = UUID.randomUUID(); // 파일명 중복방지 목적
		String savedName = uuid.toString() + "_" + originName; // 고유한 파일명 생성
		
		// 설정한 정보로 빈 파일 생성
		File saveFile = new File(uploadPath + savedPath, savedName);
		
		multipartFile.transferTo(saveFile); // 기본파일 작업
		
		String uploadFileName = "";
		
		// 기본 첨부파일이 이미지, 일반파일에 따라서 썸네일작업 진행	
		if(CheckImageType(saveFile)) {
			// 썸네일 작업
			uploadFileName = makeThumbNail(uploadPath, savedPath, savedName, multipartFile);
		}else {
			uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		
		return uploadFileName;
	}
	
	// 날짜포맷의 폴더명 생성기능. uploadFolder -> "C:\\dev\\upload"
	private static String getDateFolder(String uploadFolder) {
			
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String osGetSepStr = str.replace("-", File.separator);
		
		makeDir(uploadFolder,osGetSepStr);
		
		// 반환값으로 년월일에 해당하는 폴더를 계층적으로 생성하는 목적때문에 운영체제에서 관리하는 경로구분자로 바꿔야한다
		return osGetSepStr; // "2021-03-30" -> 
	}

	// 업로드 폴더와 날짜포맷의 폴더명을 이용한 실제 폴더 생성
	private static void makeDir(String uploadFolder, String osGetSepStr) {
		// TODO Auto-generated method stub
		
		File uploadPath = new File(uploadFolder, osGetSepStr);
		
		// uploadFolderPath 폴더명이 존재하지 않으면
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 2021/03/30
		}
	}
	
	private static boolean CheckImageType(File file) {
			
		String contentType;
		try {
			// 해당파일의 mime을 확인하고자 할때
			contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	/*
	uploadPath: 업로드 폴더명(C:\\dev\\upload)
	savedPath : 날짜폴더명(2021\\04\\09)
	uploadFileName : UUID를 적용한 파일명
	multipartFile : 첨부된 파일을 참조
	 */
	// 썸네일 이미지
	private static String makeThumbNail(String uploadPath, String savedPath, String uploadFileName, MultipartFile multipartFile) throws Exception {
		
		String thubNailName = uploadPath + savedPath + File.separator + "s_" + uploadFileName;
		
		// uploadPath
		FileOutputStream thumbnail = new FileOutputStream(new File(thubNailName));
		
		// 썸네일 이미지 생성
		Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
		thumbnail.close();
		
		// "C:\\dev\\upload\\2021\\04\\09\\s_**"
		return thubNailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	// 일반파일 아이콘
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception{
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	/*
	 * 썸네일 파일명 -> 원래 파일명
	 * ex) /2020/03/20/s_UUID파일명 -> /2020/03/20/UUID파일명
	 */
	public static String thumbToOriginName(String thumbnailName) {
		String front = thumbnailName.substring(0, 11); 	// 날짜 경로
		String end = thumbnailName.substring(13); 		// UUID_fileName
		
		return front + end;
	}
	
	// 파일 삭제
	public static void deleteFile(String uploadPath, String fileName) {
		
		//  날짜경로+ UUID_fileName
		String front = fileName.substring(0, 11); 	// 날짜 경로
		String end = fileName.substring(13); 		// UUID_fileName
		String origin = front + end;
		
		new File(uploadPath+origin.replace('/', File.separatorChar)).delete(); 		// 원본 파일 지우기
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete(); 	// 썸네일 파일 지우기
	}
	
	// 이미지 출력 기능
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) {
			
		log.info("fileName: " + fileName);
		
		File file = new File(uploadPath + fileName); // 이미지파일을 대상으로 File객체생성
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		// 패킷의 header와 body로 구성
		// body : @ResponseBody가 이미지 소스를 가리키는 <byte[]>를 body에 저장한다
		// 브라우저에서 서버로 보내운 패킷(header + body)중 header파트에 나용을 참고하여 body파트를 해석한다
		HttpHeaders header = new HttpHeaders();
		
		// 클라이언트에게 보낼 데이터의 mime정보를 패킷의 header파트부분에 설정
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		return result;
	}


}
