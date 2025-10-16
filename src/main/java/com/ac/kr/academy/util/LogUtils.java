package com.ac.kr.academy.util;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.*;
import java.nio.file.*;
import java.util.List;
import java.util.stream.Collectors;

public class LogUtils {

    private static final String LOG_FILE_PATH = "./logs/app.log";

    //WARN, ERROR 만 출력 — 깨진 문자 무시
    public static List<String> tail(int lines) throws IOException {
        Path path = Paths.get(LOG_FILE_PATH);

        // 파일이 없을 경우 빈 리스트 반환
        if (!Files.exists(path)) {
            return List.of("WARN - 로그 파일이 존재하지 않습니다: " + LOG_FILE_PATH);
        }

        //UTF-8 디코더 설정 (깨진 문자 무시)
        CharsetDecoder decoder = StandardCharsets.UTF_8
                .newDecoder()
                .onMalformedInput(CodingErrorAction.IGNORE)
                .onUnmappableCharacter(CodingErrorAction.IGNORE);

        // 파일 전체를 바이트로 읽고, 디코딩
        byte[] bytes = Files.readAllBytes(path);
        CharBuffer decoded = decoder.decode(ByteBuffer.wrap(bytes));
        String content = decoded.toString();

        // 줄 단위 분리
        List<String> all = List.of(content.split("\\R"));

        //뒤에서 N줄만, WARN/ERROR만 필터
        return all.stream()
                .skip(Math.max(0, all.size() - lines))
                .filter(line -> line.contains("ERROR") || line.contains("WARN"))
                .collect(Collectors.toList());
    }






//프론트에서 filter 파라미터 입력 시 DEBUG 또는 INFO 로그도 출력 가능

//    public static List<String> tail(int lines, String filter){
//        List<String> result = new ArrayList<>();
//
//        Path path = Paths.get(LOG_FILE_PATH);
//        if(!Files.exists(path)){
//            result.add("로그 파일이 존재하지 않습니다: " + LOG_FILE_PATH);
//            return result;
//        }
//        try{
//            List<String> allLines = Files.readAllLines(path);   //전체 라인 다 읽기
//            int start = Math.max(allLines.size() - lines, 0);   //뒤에서부터 N줄 가져오기
//            List<String> recentLines = allLines.subList(start, allLines.size());
//
//            //필터가 없거나 비어있거나 있으면 해당 키워드 포함된 line만 출력
//            for(String line : recentLines){
//                if(filter == null || filter.isEmpty() || line.contains(filter)){
//                    result.add(line);
//                }
//            }
//        } catch (IOException e){
//            result.add("로그 읽기 실패" + e.getMessage());
//        }
//        if(result.isEmpty()){
//            result.add(("최근" ) + lines + "줄에서 '" + filter + "' 로그가 없습니다.");
//        }
//        return result;
//    }
}