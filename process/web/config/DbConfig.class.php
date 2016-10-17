<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 17:00
 */
namespace web;

class DbConfig extends \DbConfig{
    private static $hotel_web_dsn_read = 'mysqli://root:root@127.0.0.1:3306/hotel';
    private static $hotel_web_dsn_write = 'mysqli://root:root@127.0.0.1:3306/hotel';

    public static function dsnRead() {
        return self::$hotel_web_dsn_read;
    }

    public static function dsnWrite() {
        return self::$hotel_web_dsn_write;
    }


}