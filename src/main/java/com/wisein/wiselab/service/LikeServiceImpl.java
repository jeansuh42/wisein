package com.wisein.wiselab.service;

import com.wisein.wiselab.dao.LikeDAO;
import com.wisein.wiselab.dto.LikeBoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class LikeServiceImpl implements LikeService {

    @Autowired
    private LikeDAO dao;


    /* like 여부 조회 */
    @Override
    public String checkLikeTipBoard(LikeBoardDTO dto) throws Exception {
        return dao.checkLikeTipBoard(dto);
    }

    /* like 등록 */
    @Override
    public void doLike(LikeBoardDTO dto) throws Exception {
        dao.doLike(dto);
    }

    /* like 해제 */
    @Override
    public void undoLike(LikeBoardDTO dto) throws Exception {
        dao.undoLike(dto);
    }

    /* like 등록시 게시글 likeCount 증가 */
    @Override
    public void addTipLikeCount(int num) throws Exception {
        dao.addTipLikeCount(num);
    }

    /* like 해제시 게시글 likeCount 감소 */
    @Override
    public void delTipLikeCount(int num) throws Exception {
        dao.delTipLikeCount(num);
    }

}
