package com.appfoodiary.foodiary.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.appfoodiary.foodiary.entity.AreaDto;
import com.appfoodiary.foodiary.entity.InterestAreaDto;
import com.appfoodiary.foodiary.vo.CntInterestAreaVO;
import com.appfoodiary.foodiary.vo.InterestAreaVO;
import com.appfoodiary.foodiary.vo.NearbyAreaVO;

@Repository
public class AreaDaoImpl implements AreaDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<AreaDto> selectList() {
		return sqlSession.selectList("area.list");
	}
	
	@Override
	public void addInterest(InterestAreaDto interestAreaDto) {
		sqlSession.insert("area.add-interest", interestAreaDto);
	}
	
	@Override
	public List<InterestAreaVO> myAreas(int memNo) {
		return sqlSession.selectList("area.list-interest", memNo);
	}
	
	@Override
	public List<InterestAreaDto> myAreasDto(int memNo) {
		return sqlSession.selectList("area.list-interest-dto", memNo);
	}
	
	@Override
	public void deleteInterest(InterestAreaDto interestAreaDto) {
		sqlSession.delete("area.delete-interest", interestAreaDto);
	}
	
	@Override
	public CntInterestAreaVO selectCnt(int memNo) {	
		return sqlSession.selectOne("area.count-interest", memNo);
	}
	
	@Override
	public List<NearbyAreaVO> nearbyAreas(List<InterestAreaVO> areas) {	
		return sqlSession.selectList("area.list-nearby", areas);
	}
}
