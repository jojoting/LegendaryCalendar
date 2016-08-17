//
//  NSDate+LCCalendar.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/11.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#define ChineseMonths           @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays             @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二",@"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

#define ChineseFestival         @{@"1-1":@"春节",@"1-15":@"元宵",@"5-5":@"端午",@"7-7":@"七夕",@"7-15":@"中元",@"8-15":@"中秋",@"9-9":@"重阳",@"12-8":@"腊八",@"12-24":@"小年"}
#define InternationalFestival   @{@"6-1":@"儿童节",@"5-1":@"劳动节",@"10-1":@"国庆节",@"12-25":@"圣诞节"}
#define ChineseWeatherFestival  @[@"小寒",@"大寒",@"立春",@"雨水",@"惊蛰",@"春分",@"清明",@"谷雨",@"立夏",@"小满",@"芒种",@"夏至",@"小暑",@"大暑",@"立秋",@"处暑",@"白露",@"秋分",@"寒露",@"霜降",@"立冬",@"小雪",@"大雪",@"冬至"]

//24节气只有(1901 - 2050)之间为准确的节气
const  int START_YEAR =1901;
const  int END_YEAR   =2050;

static int gLunarHolDay[]=
{
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1901
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1902
    0X96,0XA5, 0X87,0X96, 0X87,0X87, 0X79,0X69, 0X69,0X69, 0X78,0X78,   //1903
    0X86,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X78,0X87,   //1904
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1905
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1906
    0X96,0XA5, 0X87,0X96, 0X87,0X87, 0X79,0X69, 0X69,0X69, 0X78,0X78,   //1907
    0X86,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1908
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1909
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1910
    0X96,0XA5, 0X87,0X96, 0X87,0X87, 0X79,0X69, 0X69,0X69, 0X78,0X78,   //1911
    0X86,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1912
    0X95,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1913
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1914
    0X96,0XA5, 0X97,0X96, 0X97,0X87, 0X79,0X79, 0X69,0X69, 0X78,0X78,   //1915
    0X96,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1916
    0X95,0XB4, 0X96,0XA6, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X87,   //1917
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X77,   //1918
    0X96,0XA5, 0X97,0X96, 0X97,0X87, 0X79,0X79, 0X69,0X69, 0X78,0X78,   //1919
    0X96,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1920
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X87,   //1921
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X77,   //1922
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X69,0X69, 0X78,0X78,   //1923
    0X96,0XA5, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1924
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X87,   //1925
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1926
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1927
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1928
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1929
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1930
    0X96,0XA4, 0X96,0X96, 0X97,0X87, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1931
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1932
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1933
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1934
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1935
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1936
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1937
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1938
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1939
    0X96,0XA5, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1940
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1941
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1942
    0X96,0XA4, 0X96,0X96, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1943
    0X96,0XA5, 0X96,0XA5, 0XA6,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1944
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1945
    0X95,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1946
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1947
    0X96,0XA5, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1948
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X79, 0X78,0X79, 0X77,0X87,   //1949
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1950
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X79,0X79, 0X79,0X69, 0X78,0X78,   //1951
    0X96,0XA5, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1952
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1953
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X68, 0X78,0X87,   //1954
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1955
    0X96,0XA5, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1956
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1957
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1958
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1959
    0X96,0XA4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1960
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1961
    0X96,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1962
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1963
    0X96,0XA4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1964
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1965
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1966
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1967
    0X96,0XA4, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1968
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1969
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1970
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X79,0X69, 0X78,0X77,   //1971
    0X96,0XA4, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1972
    0XA5,0XB5, 0X96,0XA5, 0XA6,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1973
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1974
    0X96,0XB4, 0X96,0XA6, 0X97,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1975
    0X96,0XA4, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X89, 0X88,0X78, 0X87,0X87,   //1976
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1977
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X78,0X87,   //1978
    0X96,0XB4, 0X96,0XA6, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1979
    0X96,0XA4, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1980
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X77,0X87,   //1981
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1982
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X78,0X79, 0X78,0X69, 0X78,0X77,   //1983
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //1984
    0XA5,0XB4, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //1985
    0XA5,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1986
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X79, 0X78,0X69, 0X78,0X87,   //1987
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //1988
    0XA5,0XB4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1989
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //1990
    0X95,0XB4, 0X96,0XA5, 0X86,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1991
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //1992
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1993
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1994
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X76, 0X78,0X69, 0X78,0X87,   //1995
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //1996
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //1997
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //1998
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //1999
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2000
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2001
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //2002
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //2003
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2004
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2005
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2006
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X69, 0X78,0X87,   //2007
    0X96,0XB4, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2008
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2009
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2010
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X78,0X87,   //2011
    0X96,0XB4, 0XA5,0XB5, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2012
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //2013
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2014
    0X95,0XB4, 0X96,0XA5, 0X96,0X97, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //2015
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2016
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //2017
    0XA5,0XB4, 0XA6,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2018
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //2019
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X86,   //2020
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2021
    0XA5,0XB4, 0XA5,0XA5, 0XA6,0X96, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2022
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X79, 0X77,0X87,   //2023
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2024
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2025
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2026
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //2027
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2028
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2029
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2030
    0XA5,0XB4, 0X96,0XA5, 0X96,0X96, 0X88,0X78, 0X78,0X78, 0X87,0X87,   //2031
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2032
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X86,   //2033
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X78, 0X88,0X78, 0X87,0X87,   //2034
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2035
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2036
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X86,   //2037
    0XA5,0XB3, 0XA5,0XA5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2038
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2039
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X96,   //2040
    0XA5,0XC3, 0XA5,0XB5, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2041
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X88,0X88, 0X88,0X78, 0X87,0X87,   //2042
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2043
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA6, 0X97,0X87, 0X87,0X88, 0X87,0X96,   //2044
    0XA5,0XC3, 0XA5,0XB4, 0XA5,0XA6, 0X87,0X88, 0X87,0X78, 0X87,0X86,   //2045
    0XA5,0XB3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X88,0X78, 0X87,0X87,   //2046
    0XA5,0XB4, 0X96,0XA5, 0XA6,0X96, 0X88,0X88, 0X78,0X78, 0X87,0X87,   //2047
    0X95,0XB4, 0XA5,0XB4, 0XA5,0XA5, 0X97,0X87, 0X87,0X88, 0X86,0X96,   //2048
    0XA4,0XC3, 0XA5,0XA5, 0XA5,0XA6, 0X97,0X87, 0X87,0X78, 0X87,0X86,   //2049
    0XA5,0XC3, 0XA5,0XB5, 0XA6,0XA6, 0X87,0X88, 0X78,0X78, 0X87,0X87    //2050
};

#import "NSDate+LCCalendar.h"

@implementation NSDate (LCCalendar)


- (NSArray<NSDate *> *)lc_currentDates{
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSUInteger daysOfMonth = [self lc_daysOfMonth];
    NSMutableArray *allDays = [NSMutableArray arrayWithCapacity:daysOfMonth];
    for (NSInteger i = 1; i <= daysOfMonth; i ++) {
        comp.day = i;
        [allDays addObject:[calendar dateFromComponents:comp]];
    }
    return [allDays copy];
}

- (NSArray<NSDate *> *)lc_preMonthDates{
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    
    //获取上个月最后一天
    if (comp.month == 1) {
        comp.year -= 1;
        comp.month = 12;
    } else {
        comp.month -= 1;
    }
    
    NSDate *lastDateOfPreMonth = [[calendar dateFromComponents:comp] lc_lastDayOfMonth];
    NSUInteger  lastDateWeekDay = [lastDateOfPreMonth lc_weekDay];
    NSUInteger  daysOfPreMonth = lastDateWeekDay;
    NSUInteger  lastDay = [[lastDateOfPreMonth lc_lastDayOfMonth] lc_day];
    
    NSMutableArray *allDays = [NSMutableArray arrayWithCapacity:daysOfPreMonth];
    for (NSInteger i = 1; i <= daysOfPreMonth; i ++) {
        comp.day = lastDay - (daysOfPreMonth - i);
        [allDays addObject:[calendar dateFromComponents:comp]];
    }
    
    return [allDays copy];
}

- (NSArray<NSDate *> *)lc_nextMonthDates{
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    
    //获取下个月第一天
    if (comp.month == 12) {
        comp.year += 1;
        comp.month = 1;
    } else {
        comp.month += 1;
    }
    comp.day = 1;
    
    NSDate *firstDateOfNextMonth = [calendar dateFromComponents:comp];
    NSUInteger  firstDateWeekDay = [firstDateOfNextMonth lc_weekDay];
    NSUInteger  daysOfNextMonth = 8 - firstDateWeekDay;
    
    NSMutableArray *allDays = [NSMutableArray arrayWithCapacity:daysOfNextMonth];
    for (NSInteger i = 1; i <= daysOfNextMonth; i ++) {
        comp.day = i;
        [allDays addObject:[calendar dateFromComponents:comp]];
    }
    
    return [allDays copy];
}


- (NSUInteger )lc_currentMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitMonth fromDate:self];
    return comp.month;

}

- (NSUInteger )lc_day{
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay fromDate:self];
    return comp.day;
}

- (NSUInteger )lc_daysOfMonth{
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSUInteger )lc_weekDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return comp.weekday;
}

- (NSUInteger )lc_lastMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitMonth fromDate:self];
    if (comp.month == 1) {
        return 12;
    }
    return comp.month - 1;
}

- (NSUInteger )lc_nextMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitMonth fromDate:self];
    if (comp.month == 12) {
        return 1;
    }
    return comp.month + 1;
}

- (NSUInteger )lc_year{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear fromDate:self];
    return comp.year;
}

- (NSInteger )lc_monthsToMonth:(NSUInteger )month year:(NSUInteger )year{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];

    NSInteger years = year - comp.year;
    NSInteger months = month - comp.month;
    
    return months + years * 12;
}

- (NSDate *)lc_firstDayOfMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    comp.day = 1;
    return [calendar dateFromComponents:comp];
}

- (NSDate *)lc_lastDayOfMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    comp.day = [self lc_daysOfMonth];
    return [calendar dateFromComponents:comp];
}

- (NSDate *)lc_dateOfMonthsToCurrentMonth:(NSInteger )monthsToCurrentMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSInteger toMonth = monthsToCurrentMonth + comp.month;
    comp.month = toMonth;
    comp.day = 1;
    
    if (toMonth > 12) {
        comp.month = toMonth % 12;
        comp.year += toMonth / 12;
    }
    if (toMonth < 0) {
        comp.month = 12 + toMonth % 12;
        comp.year += toMonth / 12;
    }
    
    return [calendar dateFromComponents:comp];
}

- (NSDate *)lc_dateOfMonth:(NSUInteger )month year:(NSUInteger )year{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    comp.day = 1;
    comp.year = year;
    comp.month = month;
    return [calendar dateFromComponents:comp];

}

- (NSString *)lc_chineseDay{
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *chineseComp = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSCalendar *greoCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *greoComp = [greoCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];

    NSString *dayStr = ChineseDays[chineseComp.day - 1];
    NSString *chineseMonthAndDayStr = [NSString stringWithFormat:@"%ld-%ld",chineseComp.month,chineseComp.day];
    NSString *greoMonthAndDayStr = [NSString stringWithFormat:@"%ld-%ld",greoComp.month,greoComp.day];

    //月初
    if (chineseComp.day == 1) {
        dayStr = ChineseMonths[chineseComp.month - 1];
    }
    
    //国际节日
    if ([InternationalFestival.allKeys containsObject:greoMonthAndDayStr]) {
        dayStr = InternationalFestival[greoMonthAndDayStr];
    }
    
    //农历节日
    if ([ChineseFestival.allKeys containsObject:chineseMonthAndDayStr]) {
        dayStr = ChineseFestival[chineseMonthAndDayStr];
    }
    
    //除夕为春节前一天，另外算
    NSTimeInterval timeInterval_day = 60*60*24;
    NSDate *nextDayDate = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:self];
    NSDateComponents *nextDateComp = [chineseCalendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextDayDate];
    if (1 == nextDateComp.month && 1 == nextDateComp.day) {
        dayStr = @"除夕";
    }
    
    //农历节气
    long array_index = (greoComp.year -START_YEAR)*12 + greoComp.month-1 ;
    int64_t flag =gLunarHolDay[array_index];
    int64_t day;
    
    if (greoComp.day < 15)
        day= 15 - ((flag >> 4) & 0x0f);
    else
        day = ((flag) & 0x0f) + 15;
    
    long index = -1;
    
    if (greoComp.day == day) {
        index = (greoComp.month-1) *2 + (greoComp.day > 15? 1: 0);
    }
    
    if (index >=0  && index < [ChineseWeatherFestival count] ) {
        dayStr = ChineseWeatherFestival[index];
    }
    
    return dayStr;
}

- (BOOL )lc_isFestival{
    NSString *dayStr = [self lc_chineseDay];
    if ([ChineseDays containsObject:dayStr]) {
        return NO;
    }
    return YES;
}

- (BOOL)lc_isCurrentMonth{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSDateComponents *currentComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if (currentComp.year == comp.year && currentComp.month == comp.month) {
        return YES;
    }
    return NO;
}
- (BOOL)lc_isMonth:(NSUInteger )month{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
//    NSDateComponents *currentComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if (comp.month == month) {
        return YES;
    }
    return NO;

}

- (BOOL)lc_isCurrentDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSDateComponents *currentComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if (currentComp.year == comp.year && currentComp.month == comp.month && currentComp.day == comp.day) {
        return YES;
    }
    return NO;
}
@end
