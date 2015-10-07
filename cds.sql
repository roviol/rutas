-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-03-2015 a las 02:29:13
-- Versión del servidor: 5.6.16
-- Versión de PHP: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `cds`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can add permission', 2, 'add_permission'),
(5, 'Can change permission', 2, 'change_permission'),
(6, 'Can delete permission', 2, 'delete_permission'),
(7, 'Can add group', 3, 'add_group'),
(8, 'Can change group', 3, 'change_group'),
(9, 'Can delete group', 3, 'delete_group'),
(10, 'Can add user', 4, 'add_user'),
(11, 'Can change user', 4, 'change_user'),
(12, 'Can delete user', 4, 'delete_user'),
(13, 'Can add content type', 5, 'add_contenttype'),
(14, 'Can change content type', 5, 'change_contenttype'),
(15, 'Can delete content type', 5, 'delete_contenttype'),
(16, 'Can add session', 6, 'add_session'),
(17, 'Can change session', 6, 'change_session'),
(18, 'Can delete session', 6, 'delete_session'),
(19, 'Can add punto', 7, 'add_punto'),
(20, 'Can change punto', 7, 'change_punto'),
(21, 'Can delete punto', 7, 'delete_punto'),
(22, 'Can add ruta', 8, 'add_ruta'),
(23, 'Can change ruta', 8, 'change_ruta'),
(24, 'Can delete ruta', 8, 'delete_ruta'),
(25, 'Can add punto ruta', 9, 'add_puntoruta'),
(26, 'Can change punto ruta', 9, 'change_puntoruta'),
(27, 'Can delete punto ruta', 9, 'delete_puntoruta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$12000$HsTzTEnINmhr$dwcomd+AW/NO58qLGvlcpkGPxVhWCuQpdp6nwRCcntM=', '2015-03-07 23:20:14', 1, 'admin', '', '', 'rolandoviol@gmail.com', 1, 1, '2015-03-07 15:54:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=69 ;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `user_id`, `content_type_id`, `object_id`, `object_repr`, `action_flag`, `change_message`) VALUES
(1, '2015-03-07 16:09:34', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 1, ''),
(2, '2015-03-07 16:09:42', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(3, '2015-03-07 16:09:57', 1, 8, '2', 'Ruta Azul/Verde Expreso AM/PM', 1, ''),
(4, '2015-03-07 16:10:19', 1, 8, '3', 'Ruta Roja Almuerzo en la Plaza', 1, ''),
(5, '2015-03-07 16:10:32', 1, 8, '4', 'Ruta Azul/Verde Almuerzo en la Plaza', 1, ''),
(6, '2015-03-07 16:15:15', 1, 7, '1', 'Terminal Ciudad del Saber', 1, ''),
(7, '2015-03-07 16:15:41', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Añadido/a "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber" punto ruta.'),
(8, '2015-03-07 16:17:20', 1, 7, '2', 'Senacyt', 1, ''),
(9, '2015-03-07 16:17:36', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Añadido/a "Ruta Roja Expreso AM/PM: Senacyt" punto ruta.'),
(10, '2015-03-07 16:20:52', 1, 7, '3', 'Edificio 220', 1, ''),
(11, '2015-03-07 16:22:12', 1, 7, '4', 'Edificio 224', 1, ''),
(12, '2015-03-07 16:23:16', 1, 7, '5', 'Florida State University', 1, ''),
(13, '2015-03-07 16:24:19', 1, 7, '6', 'Edificio 233', 1, ''),
(14, '2015-03-07 16:25:15', 1, 7, '7', 'Edificio 237', 1, ''),
(15, '2015-03-07 16:26:08', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Añadido/a "Ruta Roja Expreso AM/PM: Edificio 220" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Edificio 224" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Edificio 233" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Edificio 237" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber" punto ruta.'),
(16, '2015-03-07 17:03:23', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Modificados polyline para "Ruta Roja Expreso AM/PM: Senacyt" punto ruta.'),
(17, '2015-03-07 21:23:01', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(18, '2015-03-07 21:23:25', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(19, '2015-03-07 21:31:31', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Modificados polyline y tipo para "Ruta Roja Expreso AM/PM: Senacyt" punto ruta.'),
(20, '2015-03-07 21:33:32', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Modificados polyline para "Ruta Roja Expreso AM/PM: Senacyt" punto ruta.'),
(21, '2015-03-07 23:22:09', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(22, '2015-03-07 23:22:54', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(23, '2015-03-07 23:24:32', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(24, '2015-03-07 23:24:57', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(25, '2015-03-07 23:27:06', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(26, '2015-03-07 23:27:53', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(27, '2015-03-07 23:28:10', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(28, '2015-03-07 23:35:43', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Modificados tipo para "Ruta Roja Expreso AM/PM: Senacyt" punto ruta.'),
(29, '2015-03-07 23:37:06', 1, 7, '1', 'Terminal Ciudad del Saber', 2, 'No ha cambiado ningún campo.'),
(30, '2015-03-07 23:37:24', 1, 7, '8', 'Terminal Ciudad del Saber (C1)', 1, ''),
(31, '2015-03-07 23:38:43', 1, 7, '9', 'Terminal Ciudad del Saber (C2)', 1, ''),
(32, '2015-03-07 23:39:04', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Añadido/a "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C1)" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C2)" punto ruta.'),
(33, '2015-03-07 23:39:21', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Modificados orden para "Ruta Roja Expreso AM/PM: Senacyt" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Edificio 220" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Edificio 224" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Edificio 233" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Edificio 237" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C1)" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C2)" punto ruta.'),
(34, '2015-03-07 23:44:15', 1, 7, '7', 'Edificio 237', 2, 'No ha cambiado ningún campo.'),
(35, '2015-03-07 23:44:38', 1, 7, '10', 'Edificio 237 (C1)', 1, ''),
(36, '2015-03-07 23:45:34', 1, 7, '11', 'Calle Winthrop', 1, ''),
(37, '2015-03-07 23:46:06', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Añadido/a "Ruta Roja Expreso AM/PM: Edificio 237 (C1)" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Calle Winthrop" punto ruta.'),
(38, '2015-03-07 23:46:21', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Modificados orden para "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Edificio 237 (C1)" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Calle Winthrop" punto ruta.'),
(39, '2015-03-07 23:49:43', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(40, '2015-03-07 23:55:27', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(41, '2015-03-07 23:56:28', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(42, '2015-03-08 00:02:20', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(43, '2015-03-08 00:05:36', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(44, '2015-03-08 00:06:38', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(45, '2015-03-08 00:10:59', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(46, '2015-03-08 00:13:25', 1, 7, '10', 'Edificio 237 (C1) ', 2, 'Modificado/a nombre, lat y lon.'),
(47, '2015-03-08 00:13:32', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(48, '2015-03-08 00:14:34', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(49, '2015-03-08 00:15:16', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'No ha cambiado ningún campo.'),
(50, '2015-03-08 01:01:51', 1, 7, '12', 'Calle Luis Bonilla Cruce (C1)', 1, ''),
(51, '2015-03-08 01:02:29', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Añadido/a "Ruta Roja Expreso AM/PM: Calle Luis Bonilla Cruce (C1)" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C2)" punto ruta. Añadido/a "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C1)" punto ruta.'),
(52, '2015-03-08 01:03:26', 1, 8, '1', 'Ruta Roja Expreso AM/PM', 2, 'Modificados orden para "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Calle Luis Bonilla Cruce (C1)" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C2)" punto ruta. Modificados orden para "Ruta Roja Expreso AM/PM: Terminal Ciudad del Saber (C1)" punto ruta.'),
(53, '2015-03-08 01:08:04', 1, 7, '13', 'Calle Alberto Tejada', 1, ''),
(54, '2015-03-08 01:10:30', 1, 7, '14', 'Edificio 346', 1, ''),
(55, '2015-03-08 01:11:41', 1, 7, '15', 'Clayton Tower', 1, ''),
(56, '2015-03-08 01:12:35', 1, 7, '16', 'Calle Arnoldo Cano Arosemena', 1, ''),
(57, '2015-03-08 01:13:27', 1, 7, '17', 'Calle Carlos Lara', 1, ''),
(58, '2015-03-08 01:14:10', 1, 7, '18', 'Calle Gonzalo Crance', 1, ''),
(59, '2015-03-08 01:15:10', 1, 7, '19', 'Edificio 129', 1, ''),
(60, '2015-03-08 01:16:08', 1, 7, '20', 'Edificio 120', 1, ''),
(61, '2015-03-08 01:17:10', 1, 7, '21', 'Fundación Ciudad del Saber', 1, ''),
(62, '2015-03-08 01:22:43', 1, 7, '21', 'F. Ciudad del Saber', 2, 'Modificado/a nombre.'),
(63, '2015-03-08 01:22:57', 1, 8, '2', 'Ruta Azul/Verde Expreso AM/PM', 2, 'Añadido/a "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber (C1)" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber (C2)" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Calle Alberto Tejada" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Edificio 346" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Clayton Tower" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Calle Arnoldo Cano Arosemena" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Calle Carlos Lara" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Calle Gonzalo Crance" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Edificio 129" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Edificio 120" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: F. Ciudad del Saber" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber (C2)" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber (C1)" punto ruta. Añadido/a "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber" punto ruta.'),
(64, '2015-03-08 01:24:32', 1, 7, '22', 'F. Ciudad del Saber (C1)', 1, ''),
(65, '2015-03-08 01:24:44', 1, 8, '2', 'Ruta Azul/Verde Expreso AM/PM', 2, 'Añadido/a "Ruta Azul/Verde Expreso AM/PM: F. Ciudad del Saber (C1)" punto ruta.'),
(66, '2015-03-08 01:25:07', 1, 8, '2', 'Ruta Azul/Verde Expreso AM/PM', 2, 'Modificados orden para "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber (C2)" punto ruta. Modificados orden para "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber (C1)" punto ruta. Modificados orden para "Ruta Azul/Verde Expreso AM/PM: Terminal Ciudad del Saber" punto ruta. Modificados orden para "Ruta Azul/Verde Expreso AM/PM: F. Ciudad del Saber (C1)" punto ruta.'),
(67, '2015-03-08 01:26:46', 1, 7, '22', 'F. Ciudad del Saber (C1)', 2, 'Modificado/a lat y lon.'),
(68, '2015-03-08 01:26:51', 1, 8, '2', 'Ruta Azul/Verde Expreso AM/PM', 2, 'No ha cambiado ningún campo.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `name`, `app_label`, `model`) VALUES
(1, 'log entry', 'admin', 'logentry'),
(2, 'permission', 'auth', 'permission'),
(3, 'group', 'auth', 'group'),
(4, 'user', 'auth', 'user'),
(5, 'content type', 'contenttypes', 'contenttype'),
(6, 'session', 'sessions', 'session'),
(7, 'punto', 'transporte', 'punto'),
(8, 'ruta', 'transporte', 'ruta'),
(9, 'punto ruta', 'transporte', 'puntoruta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('3n90iirvftsbenzga5nfbwt6f3lyl1v4', 'ZjRjODllMTFhNzVkZWVhNDQ3ZGEwNTJiMzk4Nzc4ZTQ0YzM2NDM5Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=', '2015-03-21 19:54:38'),
('pzf89n3xm9qs43lvoq1d556zkgc8e8xp', 'ZjRjODllMTFhNzVkZWVhNDQ3ZGEwNTJiMzk4Nzc4ZTQ0YzM2NDM5Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=', '2015-03-21 16:13:37'),
('wr7mfenj8v7u62lpn25hwcx20k8d1qzs', 'ZjRjODllMTFhNzVkZWVhNDQ3ZGEwNTJiMzk4Nzc4ZTQ0YzM2NDM5Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=', '2015-03-21 23:20:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte_punto`
--

CREATE TABLE IF NOT EXISTS `transporte_punto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `lat` double NOT NULL,
  `lon` double NOT NULL,
  `tipo` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Volcado de datos para la tabla `transporte_punto`
--

INSERT INTO `transporte_punto` (`id`, `nombre`, `lat`, `lon`, `tipo`) VALUES
(1, 'Terminal Ciudad del Saber', 8.999607, -79.585321, 'P'),
(2, 'Senacyt', 9.00283, -79.584729, 'P'),
(3, 'Edificio 220', 9.004509, -79.585218, 'P'),
(4, 'Edificio 224', 9.00553, -79.587349, 'P'),
(5, 'Florida State University', 9.004952, -79.5895, 'P'),
(6, 'Edificio 233', 9.003691, -79.588079, 'P'),
(7, 'Edificio 237', 9.002491, -79.586603, 'P'),
(8, 'Terminal Ciudad del Saber (C1)', 8.999607, -79.585321, 'C'),
(9, 'Terminal Ciudad del Saber (C2)', 8.999869, -79.585098, 'C'),
(10, 'Edificio 237 (C1) ', 9.00254, -79.58657, 'C'),
(11, 'Calle Winthrop', 9.002129, -79.586113, 'C'),
(12, 'Calle Luis Bonilla Cruce (C1)', 9.001674, -79.586419, 'C'),
(13, 'Calle Alberto Tejada', 9.001984, -79.582137, 'P'),
(14, 'Edificio 346', 9.003918, -79.580093, 'P'),
(15, 'Clayton Tower', 9.003672, -79.578026, 'P'),
(16, 'Calle Arnoldo Cano Arosemena', 9.00102, -79.576421, 'P'),
(17, 'Calle Carlos Lara', 8.997222, -79.580862, 'P'),
(18, 'Calle Gonzalo Crance', 8.997839, -79.579857, 'P'),
(19, 'Edificio 129', 8.995874, -79.5807, 'P'),
(20, 'Edificio 120', 8.996182, -79.58242, 'P'),
(21, 'F. Ciudad del Saber', 8.999279, -79.584609, 'P'),
(22, 'F. Ciudad del Saber (C1)', 8.99924, -79.58467, 'C');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte_puntoruta`
--

CREATE TABLE IF NOT EXISTS `transporte_puntoruta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruta_id` int(11) NOT NULL,
  `punto_id` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  `polyline` varchar(1000) NOT NULL,
  `tipo` varchar(1) DEFAULT NULL,
  `latlon` varchar(40000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transporte_puntoruta_1613e788` (`ruta_id`),
  KEY `transporte_puntoruta_b2bfdc59` (`punto_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Volcado de datos para la tabla `transporte_puntoruta`
--

INSERT INTO `transporte_puntoruta` (`id`, `ruta_id`, `punto_id`, `orden`, `polyline`, `tipo`, `latlon`) VALUES
(1, 1, 1, 0, '', 'A', NULL),
(2, 1, 2, 3, 'ov|u@f_wdNs@m@A@@B{FrD_Al@s@qAw@gAk@o@eCwA', 'A', '[(-79.585321, 8.999607), (-79.585098, 8.999869), (-79.5851, 8.99987), (-79.58512, 8.99986), (-79.58602, 9.00112), (-79.58625, 9.00144), (-79.58584, 9.0017), (-79.58548, 9.00199), (-79.58524, 9.0022), (-79.5848, 9.00288)]'),
(3, 1, 3, 4, '}j}u@~{vdNyA{@{@_@gAfB_@n@w@l@', 'A', '[(-79.5848, 9.00288), (-79.58451, 9.00332), (-79.58434, 9.00363), (-79.58486, 9.00398), (-79.5851, 9.00415), (-79.58533, 9.00442)]'),
(4, 1, 4, 5, 'st}u@h_wdNo@ZWNQT[~@iAxFG\\', 'A', '[(-79.58533, 9.00442), (-79.58547, 9.00466), (-79.58555, 9.00478), (-79.58567, 9.00487), (-79.58598, 9.00501), (-79.58724, 9.00538), (-79.58738, 9.00542)]'),
(5, 1, 6, 6, '{z}u@blwdNa@fCCf@FXhDfGZQT]bCmGJO', 'A', '[(-79.58738, 9.00542), (-79.58806, 9.0056), (-79.58827, 9.00561), (-79.58839, 9.00557), (-79.58971, 9.00472), (-79.58962, 9.00458), (-79.58948, 9.00447), (-79.58812, 9.00381), (-79.58804, 9.00375)]'),
(6, 1, 7, 7, 'mp}u@fpwdNpBkDRYZCnA}A', 'A', '[(-79.58804, 9.00375), (-79.58718, 9.00318), (-79.58706, 9.00308), (-79.58703, 9.00294), (-79.58657, 9.00254)]'),
(7, 1, 1, 13, '{h}u@~fwdNrAyAxAz@hJgGr@l@YR', 'A', '[(-79.58657, 9.00254), (-79.586113, 9.002129), (-79.586419, 9.001674), (-79.585098, 8.999869), (-79.585321, 8.999607), (-79.58542, 8.99973)]'),
(8, 1, 8, 1, '', 'A', NULL),
(9, 1, 9, 2, '', 'A', NULL),
(10, 1, 10, 8, '', 'A', NULL),
(11, 1, 11, 9, '', 'A', NULL),
(12, 1, 12, 10, '', 'A', ''),
(13, 1, 9, 11, '', 'A', ''),
(14, 1, 8, 12, '', 'A', ''),
(45, 2, 1, 0, '', 'A', ''),
(46, 2, 8, 1, '', 'A', ''),
(47, 2, 9, 2, '', 'A', ''),
(48, 2, 13, 3, 'ov|u@f_wdNs@m@A@@Bt@e@Y_@kFoIyAoB[QeBw@', 'A', '[(-79.585321, 8.999607), (-79.585098, 8.999869), (-79.5851, 8.99987), (-79.58512, 8.99986), (-79.58493, 8.9996), (-79.58477, 8.99972), (-79.58309, 9.00091), (-79.58254, 9.00135), (-79.58244, 9.00149), (-79.58216, 9.002)]'),
(49, 2, 14, 4, 'oe}u@nkvdNKC{@Oa@Ue@IQMkAaA[MO[oAsB_@wB', 'A', '[(-79.58216, 9.002), (-79.58214, 9.00206), (-79.58206, 9.00236), (-79.58196, 9.00253), (-79.58191, 9.00272), (-79.58183, 9.00281), (-79.58151, 9.00319), (-79.58143, 9.00333), (-79.58129, 9.00341), (-79.58071, 9.00382), (-79.58011, 9.00397)]'),
(50, 2, 15, 5, 'yq}u@t~udNWeEGu@GYAYbAqA\\a@', 'A', '[(-79.58011, 9.00397), (-79.57912, 9.0041), (-79.57885, 9.00413), (-79.57872, 9.00417), (-79.57859, 9.00418), (-79.57818, 9.00384), (-79.57801, 9.00369)]'),
(51, 2, 16, 6, 'ap}u@pqudNh@i@`Ay@jAq@|AcArBgAz@W|@IPA', 'A', '[(-79.57801, 9.00369), (-79.5778, 9.00349), (-79.57751, 9.00316), (-79.57726, 9.00277), (-79.57692, 9.0023), (-79.57656, 9.00172), (-79.57645, 9.00142), (-79.57639, 9.00111), (-79.57638, 9.00102)]'),
(52, 2, 17, 7, 'k_}u@jgudNx@?nBJp@Xn@ZhD`CjElCtA|@`Av@xA~Bb@~@XP\\n@DJkEvCUJ', 'A', '[(-79.57638, 9.00102), (-79.57638, 9.00073), (-79.57645, 9.00017), (-79.57657, 8.99992), (-79.57672, 8.99968), (-79.57736, 8.99883), (-79.57807, 8.99781), (-79.57838, 8.99738), (-79.57866, 8.99706), (-79.5793, 8.9966), (-79.57962, 8.99642), (-79.57971, 8.99629), (-79.57995, 8.99614), (-79.58001, 8.99611), (-79.58077, 8.99713), (-79.58084, 8.99724)]'),
(53, 2, 18, 8, 'wg|u@dcvdNyDbCg@Xu@oAG}@Dk@Le@V]ZYbBcA', 'A', '[(-79.58084, 8.99724), (-79.58149, 8.99817), (-79.58162, 8.99837), (-79.58122, 8.99864), (-79.58091, 8.99868), (-79.58069, 8.99866), (-79.5805, 8.99858), (-79.58035, 8.99847), (-79.58022, 8.99832), (-79.57988, 8.99782)]'),
(54, 2, 19, 9, 'kk|u@f}udNxA}@n@U`@Cr@Fv@ZXPNVRb@v@rBBP', 'A', '[(-79.57988, 8.99782), (-79.57957, 8.99737), (-79.57946, 8.99713), (-79.57945, 8.99697), (-79.57948, 8.9967), (-79.57962, 8.99642), (-79.57971, 8.99629), (-79.57983, 8.99621), (-79.58001, 8.99611), (-79.58059, 8.99584), (-79.58068, 8.99581)]'),
(55, 2, 20, 10, 'y~{u@fbvdNd@lBh@dC[PyBxA', 'A', '[(-79.58068, 8.99581), (-79.58124, 8.99562), (-79.5819, 8.99542), (-79.582, 8.99555), (-79.58245, 8.99616)]'),
(56, 2, 21, 11, '_a|u@fmvdNgR|L', 'A', '[(-79.58245, 8.99616), (-79.58467, 8.99924)]'),
(57, 2, 9, 13, '', 'A', ''),
(58, 2, 8, 14, '', 'A', ''),
(59, 2, 1, 15, 'gt|u@d{vdN{BrAr@l@YR', 'A', '[(-79.58467, 8.99924), (-79.585098, 8.999869), (-79.585321, 8.999607), (-79.58542, 8.99973)]'),
(60, 2, 22, 12, '', 'A', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte_ruta`
--

CREATE TABLE IF NOT EXISTS `transporte_ruta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  `tipo` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `transporte_ruta`
--

INSERT INTO `transporte_ruta` (`id`, `nombre`, `tipo`) VALUES
(1, 'Ruta Roja Expreso AM/PM', 'B'),
(2, 'Ruta Azul/Verde Expreso AM/PM', 'B'),
(3, 'Ruta Roja Almuerzo en la Plaza', 'B'),
(4, 'Ruta Azul/Verde Almuerzo en la Plaza', 'B');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `transporte_puntoruta`
--
ALTER TABLE `transporte_puntoruta`
  ADD CONSTRAINT `punto_id_refs_id_825fabfb` FOREIGN KEY (`punto_id`) REFERENCES `transporte_punto` (`id`),
  ADD CONSTRAINT `ruta_id_refs_id_7edf1738` FOREIGN KEY (`ruta_id`) REFERENCES `transporte_ruta` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
