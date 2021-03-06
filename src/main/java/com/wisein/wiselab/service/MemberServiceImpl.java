package com.wisein.wiselab.service;

import com.wisein.wiselab.common.FileUtils;
import com.wisein.wiselab.dao.MemberDAO;
import com.wisein.wiselab.dto.FileDTO;
import com.wisein.wiselab.dto.MemberDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.util.Iterator;
import java.util.List;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

    @Autowired
    private FileUtils fileUtils;

    @Autowired
    private MemberDAO dao;

    @Override
    public void register(MemberDTO dto) throws Exception {
        dao.register(dto);
    }

    @Override
    public int idDupChk(String userId) throws Exception {
        return dao.idDupChk(userId);
    }

    @Override
    public MemberDTO login(MemberDTO dto) throws Exception {
        return dao.login(dto);
    }

    @Override
    public String findTempKey(String id) throws Exception {
        return dao.findTempKey(id);
    }

    @Override
    public void logout(HttpSession session) throws Exception {
        session.invalidate();
    }

    @Override
    public void authStateUpdate(String id) throws Exception {
        dao.authStateUpdate(id);
    }

    @Override
    public int authIdExist(String id) throws Exception {
        return dao.authIdExist(id);
    }

    @Override
    public void modify(MemberDTO dto, MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {

        if(ObjectUtils.isEmpty(multipartHttpServletRequest) == false) {

            Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
            String name;
            while(iterator.hasNext()) {
                name = iterator.next();
                System.out.println("file tag name : " + name);
                List<MultipartFile> list = multipartHttpServletRequest.getFiles(name);
                for(MultipartFile multipartFile : list) {

                    String contType =  multipartFile.getContentType();
                    String[] contArr = contType.split("/");
                    String extension = contArr[1];

                    System.out.println("start file information");
                    System.out.println("ORG_FILE_NAME: " + multipartFile.getOriginalFilename());
                    System.out.println("FILE_EXTENSION : " + extension);
                    System.out.println("end file information.\n");
                }

            }
        }

        dao.modify(dto);
        String brdRef =  "mem||" + dto.getId();
        List<FileDTO> list = fileUtils.parseFileInfo(brdRef, "image", multipartHttpServletRequest);
        if(CollectionUtils.isEmpty(list) == false) {
            dao.insertMemFileList(list);
        }
    }

    @Override
    public void delUserImg(String fileNm) throws Exception {
        dao.delUserImg(fileNm);
    }

    @Override
    public List<FileDTO> memImgList(String id) throws Exception {
        String brdRef =  "mem||" + id;
        List<FileDTO> list = dao.selectMemFileList(brdRef);
        return list;
    }

    @Override
    public void withdraw(MemberDTO dto, HttpSession session) throws Exception {
        dao.withdraw(dto);
        session.invalidate();
    }


}