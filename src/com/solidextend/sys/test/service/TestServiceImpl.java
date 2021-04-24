package com.solidextend.sys.test.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.solidextend.sys.test.dao.RepresentativeInfoMapper;
import com.solidextend.sys.test.vo.RepresentativeInfo;

@Service
public class TestServiceImpl implements TestService {
	@Resource
	private RepresentativeInfoMapper representativeInfoMapper;
	@Override
	public void saveRepresentativeInfo(RepresentativeInfo obj) {
		// TODO Auto-generated method stub
		this.representativeInfoMapper.saveRepresentativeInfo(obj);

	}

	@Override
	public int deleteRepresentativeInfoById(String id) {
		// TODO Auto-generated method stub
		return this.representativeInfoMapper.deleteRepresentativeInfo(id);
	}

	@Override
	public void updateRepresentativeInfoById(RepresentativeInfo obj) {
		// TODO Auto-generated method stub
		this.representativeInfoMapper.updateRepresentativeInfo(obj);

	}

	@Override
	public RepresentativeInfo getRepresentativeInfoById(String id) {
		// TODO Auto-generated method stub
		return this.representativeInfoMapper.getRepresentativeInfoById(id);
	}

	@Override
	public List<RepresentativeInfo> getRepresentativeInfoList(RepresentativeInfo obj) {
		// TODO Auto-generated method stub
		return this.representativeInfoMapper.findAllRepresentativeInfo(obj);
	}

}
