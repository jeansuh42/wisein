package com.wisein.wiselab.controller;

import com.wisein.wiselab.dto.TipBoardDTO;
import com.wisein.wiselab.service.TipBoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
public class tipController {

    @Autowired
    TipBoardService tipBoardService;

    //다건 조회
    @GetMapping(value="/tipList")
    public String tipList (Model model) throws Exception {

        List<TipBoardDTO> tipList = new ArrayList<>();

        tipList = (List<TipBoardDTO>) tipBoardService.selectTipList();

        model.addAttribute("tipList", tipList);

        return "cmn/tipList";
    }

    //단건 조회
    @GetMapping(value="/tipDetail")
    public String qaDetail (HttpServletRequest request, TipBoardDTO dto, Model model,  @RequestParam("num") int num) throws Exception {
        System.out.println(dto);
        System.out.println(dto.getNum());
        TipBoardDTO TipBoardDTO = null;

        if(dto.getNum() !=0){
            TipBoardDTO = tipBoardService.selectTipOne(dto);
        }else{
            TipBoardDTO.setNum(num);
            TipBoardDTO = tipBoardService.selectTipOne(dto);
        }

        model.addAttribute("tipBoardDTO", TipBoardDTO);
        model.addAttribute("content", TipBoardDTO.getContent());

        return "cmn/tipDetail";
    }

    //등록
    @GetMapping(value="/regTip")
    public String regTip () throws Exception {
        return "cmn/regTip";
    }

    @PostMapping(value="/regTip")
    public String regTip (HttpServletRequest request, TipBoardDTO dto) throws Exception {
        dto.setWriter("test2");
        tipBoardService.insertTipBoard(dto);

        return "redirect:/tipList";
    }

    //삭제
    @GetMapping(value="/delTip")
    public String delTip (@RequestParam("num") int num) throws Exception {
        tipBoardService.deleteTipBoard(num);
        return "redirect:/tipList";
    }


    //수정
    @GetMapping(value="/updTip")
    public String updTip (TipBoardDTO dto, Model model) throws Exception {
        dto = tipBoardService.selectTipOne(dto);
        model.addAttribute("TipBoardDTO", dto);

        return "cmn/updTip";
    }

    @PostMapping(value="/updTip")
    public String updTip(HttpServletRequest request, TipBoardDTO dto) throws Exception {
        tipBoardService.updateTipBoard(dto);

        return "redirect:/tipDetail?num="+dto.getNum();
    }

}