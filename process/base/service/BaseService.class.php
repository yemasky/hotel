<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 10:58
 */
abstract class BaseService{
    private static $objBase = null;

    public function __call($name, $args){
        $objCallName = new $name($args);
        $objCallName->setCallObj($this, $args);
        return $objCallName;
    }

    public static function instance($objClass = ''){
        if(empty($objClass)) $objClass = 'BaseService';
        if(isset(self::$objBase[$objClass]) && is_object(self::$objBase[$objClass])) {
            return self::$objBase[$objClass];
        }
        self::$objBase[$objClass] = new $objClass();
        return self::$objBase[$objClass];
    }
}