<%@page import="my.shop.CategoryBean2"%>
<%@page import="my.shop.CategoryDao2"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
  request.setCharacterEncoding("UTF-8");
  
  String code1 = request.getParameter("code1");
  System.out.println("code1 :"+code1);
  
  // 가져온 code1에 해당하는 mycategory2의 cname을 가져와야함.
  
  CategoryDao2 cdao2 = CategoryDao2.getinstance();
  ArrayList<CategoryBean2> list =  cdao2.getAllCategory(code1);
  
  System.out.println("code1에 해당하는 incategorySelect에서 list size  :"+list.size());
  
  
  out.print(list);
  %>  
  