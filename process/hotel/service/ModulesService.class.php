<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class ModulesService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new ModulesService();
        return self::$objService;
    }

    public function getModules($module_id = null) {
        $arrayModules = ModulesDao::instance()->getModules(\DbConfig::$db_query_conditions);
        if(!empty($module_id)) {
            return $arrayModules[$module_id];
        }
        return $arrayModules;
    }


}