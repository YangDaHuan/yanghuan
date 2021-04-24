package com.solidextend.core.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

/**
 * 用户session存储
 * @author songjunjie
 * @version 2014-3-12 下午2:10:32
 */
public class UserSessionStorage {
	private static Map<String,HttpSession > onLineUserMap = new HashMap<String,HttpSession >();
	
	public static void add(String username,HttpSession  sid){
		onLineUserMap.put(username, sid);
	}
	
	public static HttpSession  get(String username){
		return onLineUserMap.get(username);
	}
	
	public static void remove(String username){
		onLineUserMap.remove(username);
	}
}
