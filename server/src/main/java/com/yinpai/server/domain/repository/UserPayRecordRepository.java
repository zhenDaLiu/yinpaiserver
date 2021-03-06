package com.yinpai.server.domain.repository;

import com.yinpai.server.domain.entity.UserPayRecord;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * @author weilai
 * @email 352342845@qq.com
 * @date 2020/10/21 6:26 下午
 */
public interface UserPayRecordRepository extends JpaRepository<UserPayRecord, Integer>, JpaSpecificationExecutor<UserPayRecord> {

    Page<UserPayRecord> findAllByUserId(Integer userId, Pageable pageable);
}
