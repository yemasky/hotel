<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 10:58
 */
abstract class BaseService{
    public static $objBaseService = null;
    public static function instance($objClass = ''){
        if(empty($objClass)) throw new Exception('objClass is null');
        if(isset(self::$objBaseService[$objClass]) && is_object(self::$objBaseService[$objClass])) {
            return self::$objBaseService[$objClass];
        }
        self::$objBaseService[$objClass] = new $objClass();
        return self::$objBaseService[$objClass];
    }

    public function __call($name, $args){
        $objCallName = new $name($args);
        $objCallName->setCallObj($this, $args);
        return $objCallName;
    }
}