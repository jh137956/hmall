package com.hmall.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.hmall.domain.BoardAttachVO;
import com.hmall.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component // bean생성이름 : fileCheckTask
public class FileCheckTask {
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attackMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	

	@Scheduled(cron = "0 * * * * *") // 예약설정 : 1분단위로 메서드가 실행
	public void checkFiles() throws Exception {
			
		log.warn("File check Task run.........");
		
		log.warn("=============================");
		
		// 오늘 날짜를 기준으로 하루 이전날짜 : 파일정보
		// 파일정보와 업로드폴더의 비교를 하여 일치되지 않는 데이터를 찾음
		// 그 대상파일들을 삭제한다
		
		// 스트림(stream)을 이용한 람다식 문법구문
		
		// 1) 배열, 컬렉션 -> 2) Stream생성 -> 3) 가공작업(중개연산)-Filtering, Mapping, Sorting, Iterating
		// map()메서드 : 스트림 내 요소들을 하나씩 특정값을 변환해준다
		
		// 1) 배열, 컬렉션 : 오늘 날짜를 기준으로 하루 이전날짜 : 파일정보
		List<BoardAttachVO> fileList = attackMapper.getOldFiles();
		// 파일정보와 업로드폴더의 비교를 하여 일치되지 않는 데이터를 찾음
		// Paths 클래스 : 경로작업을 위한 기능 제공
		// db에서 가져온 정보를 이용하여 path객체생성(썸네일정보의 path객체가 제외된 상태)
		List<Path> fileListPaths =  fileList.stream()			// 2021\04\01		uuid_파일명
						// map() : Path객체 리턴
						.map(vo -> Paths.get("C:\\upload\\tmp", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
						// Path객체 -> List<Path> 구성
						.collect(Collectors.toList());
		
		// db에서 기본이미지에 따른 썸네일 정보의 path객체 생성
		fileList.stream().filter(vo -> vo.isFileType() == true) 
						.map(vo -> Paths.get("C:\\upload\\tmp", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
						.forEach(p -> fileListPaths.add(p));
		
		
		log.warn("=============================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		// File 클래스 : 파일, 폴더 관련 기능을 제공 (C:\\upload\\tmp\\2021\\04\\01)
		File targetDir = Paths.get("C:\\upload\\tmp", getFolderYesterDay()).toFile();
		
		// fileListPaths : db에서 존재하는 파일정보를 기반한 path객체(썸네일 포함)
		// targetDir.listFiles() : 서버 업로드폴더에 존재하는 파일배열 객체(쓰레기파일 포함)
		
		// targetDir.listFiles() 파일안에 fileListPaths 파일정보가 존재하는지 체크작업
		// 일치하지 않으면 쓰레기 파일
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		
		log.warn("=============================");
		
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
	}
	
	// 아래 1), 4)번 작업을 람다식을 지원하는 Stream의 map()메서드를 통하영 간략히 구문작업이 가능해짐
	// 1)메서드
	Path testMethodA(BoardAttachVO vo) {
		return Paths.get("C:\\upload\\tmp", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName());
	}
	
	// 2)db에서 가져온 파일정보 컬렉션
	List<BoardAttachVO> voList = new ArrayList<BoardAttachVO>();
	
	// 3)파일정보를 이용한 List<Path>컬렉션
	List<Path> tempFiles = null;
	
	// 4)실행
	void testMethodB() {
		for(BoardAttachVO vo : voList) {
			tempFiles.add(testMethodA(vo));
		}
	}
	
	
}