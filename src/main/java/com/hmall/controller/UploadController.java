package com.hmall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hmall.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\upload\\tmp";
		
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("====================================");
			log.info("파일명: " + multipartFile.getOriginalFilename());
			log.info("파일크기: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				e.printStackTrace();	
			}
		
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
		
	}
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody // restcontroller -> @controller + @ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		// 업로드되는 파일을 파일명 중복처리후 날짜별 폴더명으로 저장한다
		// 파일이 이미지파일인지 일반파일인지 구분후 썸네일 이미지 생성작업을 한다
		// 첨부된 파일들의 정보를 List<AttachFileDTO>컬렉션에 저장하여 db정보로 사용한다
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		String uploadFolder = "C:\\upload\\tmp";
		
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		// uploadFolderPath 폴더명이 존재하지 않으면
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 2021/03/30
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE(익스플로러): c:\temp\abc.txt  chrome(크롬) : abc.txt
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("파일명: " + uploadFileName);
			attachDTO.setFileName(uploadFileName); // 클라이언트의 실제 파일명
			
			// 저장하는 업로드 파일명 중복방지 처리
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				// 원본파일 저장
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString()); // 중복되지않는 이름
				attachDTO.setUploadPath(uploadFolderPath); // 날짜별 폴더명
				
				// 썸네일 이미지 생성작업(Thumbnail) : 크기가 큰 이미지파일을 디스플레이할때 성능문제로 인하여 작은크기로 작업을 한 결과물
				// 1)첨부된 파일이 이미지인지 일반파일인지 체크
				if(CheckImageType(saveFile)) {
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					// 썸네일 이미지 생성
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
				list.add(attachDTO);
				
			}catch(Exception e) {
				e.printStackTrace();	
			}
		
		}
		
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}

	private boolean CheckImageType(File file) {
		
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

	// 날짜별로 폴더를 생성하여 파일관리
	// 운영체제마다 폴더에 관리되는 파일의 개수 or 성능저하(하나의 폴더에 많은 파일들이 존재할 경우)
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		// 반환값으로 년월일에 해당하는 폴더를 계층적으로 생성하는 목적때문에 운영체제에서 관리하는 경로구분자로 바꿔야한다
		return str.replace("-", File.separator); // "2021-03-30" -> 
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		log.info("fileName: " + fileName);
		
		File file = new File("c:\\upload\\tmp\\" + fileName); // 이미지파일을 대상으로 File객체생성
		
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
	
	
	// 브라우저의 종류 및 버전등의 정보를 확인해서 선택적인 작업을 해야한다
	// 다운로드시 클라이언트쪽에서 사용한 파일을 전송
	// 브라우저에서 서버로부터 이미지를 받으면 화면에 보여주고 아니면 다운로드 대화상자를 통하여 진행시킨다
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		
		Resource resource = new FileSystemResource("c:\\upload\\tmp\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		
		// uuid 문자열제거(클라이언트가 업로드한 실제파일명)
		String resourceOriginName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			boolean checkIE = (userAgent.indexOf("MSIE") > - 1 || userAgent.indexOf("Trident") > - 1);
			
			String downloadName = null;
			
			// 보통 크롬, 엣지는 한글또는 특수문자 등에 대하여 인코딩을 지원한다
			// ms의 엣지 이전버전의 IE는 인코딩이 지원이 안된다
			// URLEncoder.encode() 메서드를 이용하여 인코딩작업을 처리함
			// 브라우저의 종류 또는 버전에 따라 인코딩작업이 다르므로 참조하여 처리를한다
			// 한글파일명
			if(checkIE) {
				downloadName = URLEncoder.encode(resourceOriginName, "UTF-8").replaceAll("\\+", " ");
			}else {
				downloadName = new String(resourceOriginName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
				
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	// 파일 삭제 작업
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		
		log.info("delete file: " + fileName);
		
		File file;
		
		try {
			file = new File("c:\\\\upload\\\\tmp\\\\" + URLDecoder.decode(fileName));
			file.delete(); // 썸네일 이미지 삭제
			
			// 원본 이미지 삭제
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		}catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("delete", HttpStatus.OK);
	}
	
	
	
}
