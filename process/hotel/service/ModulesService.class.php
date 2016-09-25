<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class ModulesService extends \BaseService {
    public static function getModules($module_id = null) {
        $arrayModules = ModulesDao::instance('\hotel\ModulesDao')->getModules(\DbConfig::$db_query_conditions);
        if(!empty($module_id)) {
            return $arrayModules[$module_id];
        }
        return $arrayModules;
    }


}