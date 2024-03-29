package com.wisein.wiselab.service;

import com.wisein.wiselab.dto.LikeBoardDTO;


public interface LikeService {

    /* like 여부 조회 */
    public String TipLikeYN(LikeBoardDTO dto) throws Exception;

    /* like 여부 조회 */
    public String QaLikeYN(LikeBoardDTO dto) throws Exception;

    /* like 등록 */
    public void insertLike(LikeBoardDTO dto) throws Exception;

    /* like 재등록 */
    public void doLike(LikeBoardDTO dto) throws Exception;

    /* like 해제 */
    public void undoLike(LikeBoardDTO dto) throws Exception;

    /* like 등록시 게시글 likeCount 증가 */
    public void addTipLikeCount(int num) throws Exception;

    /* like 해제시 게시글 likeCount 감소 */
    public void delTipLikeCount(int num) throws Exception;

    /* like 등록시 게시글 likeCount 증가 */
    public void addQaLikeCount(int num) throws Exception;

    /* like 해제시 게시글 likeCount 감소 */
    public void delQaLikeCount(int num) throws Exception;
    
    /* like 등록 시 원본 게시글 count 증가를 위한 parentNum 조회 */
    public int getQaParentNum(int num) throws Exception;
}
