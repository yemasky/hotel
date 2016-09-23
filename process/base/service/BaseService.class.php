<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 10:58
 */
abstract class BaseService{

    public function __call($name, $args){
        $objCallName = new $name($args);
        $objCallName->setCallObj($this, $args);
        return $objCallName;
    }
}