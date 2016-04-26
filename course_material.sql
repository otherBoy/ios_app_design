-- phpMyAdmin SQL Dump
-- version 2.11.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 16, 2016 at 16:00 PM
-- Server version: 5.0.51
-- PHP Version: 5.2.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `course_material`
--

-- --------------------------------------------------------

--
-- Table structure for table `USER`
--

CREATE TABLE IF NOT EXISTS `USER` (
  `USER_ID` int(11) unsigned NOT NULL auto_increment,
  `EMAIL` varchar(60) NOT NULL,
  `PASSWORD` varchar(20) NOT NULL,
  `FIRST_NAME` varchar(50) NOT NULL,
  `LAST_NAME` varchar(50) NOT NULL,
  `UNIVERSITY` varchar(50) NOT NULL,
  `FACULTY` varchar(50) NOT NULL,
  `PHONE_NUMBER` varchar(50) NOT NULL,
  `WHATSAPP` varchar(60) default NULL,
  `WECHAT` varchar(60) default NULL,
  PRIMARY KEY  (`USER_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `USER`
--

INSERT INTO `USER` (`USER_ID`, `EMAIL`, `PASSWORD`, `FIRST_NAME`, `LAST_NAME`, `UNIVERSITY`, `FACULTY`, `PHONE_NUMBER`, `WHATSAPP`, `WECHAT`) VALUES
(1, 'robert@gmail.com', '12345', 'robert', 'wei',  'HKU', 'engineering', '61520001', NULL, NULL),
(2, 'mirko@gmail.com',  '54321', 'mirko',  'zhao', 'HKU', 'engineering', '61520002', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `RESOURCE`
--

CREATE TABLE IF NOT EXISTS `RESOURCE` (
  `RESOURCE_ID` int(11) unsigned NOT NULL auto_increment,
  `TITLE` varchar(40) NOT NULL,
  `DESCRIPTION` varchar(300) NOT NULL,
  `TYPE` varchar(12) NOT NULL,
  `COURSE_CODE` varchar(12) NOT NULL,
  `PREFER_CONTACT` int(4) unsigned default '0',
  `PRICE` decimal(11) unsigned default '0.0',
  `USER_ID` int(11) references USER(USER_ID),
  PRIMARY KEY  (`RESOURCE_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `RESOURCE`
--

-- --------------------------------------------------------

--
-- Table structure for table `PICTURE`
--

CREATE TABLE IF NOT EXISTS `PICTURE` (
  `PICTURE_ID` int(11) unsigned NOT NULL auto_increment,
  `PICTURE_URL` varchar(200) NOT NULL,
  `USER_ID` int(11) references USER(USER_ID),
  `RESOURCE_ID` int(11) references RESOURCE(RESOURCE_ID),
  PRIMARY KEY  (`PICTURE_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `PICTURE`
--

-- --------------------------------------------------------