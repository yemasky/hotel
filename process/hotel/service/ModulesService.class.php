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
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('modules_open'=>1);
        $arrayModules = ModulesDao::instance()->getModules($conditions);
        if(!empty($module_id)) {
            return $arrayModules[$module_id];
        }
        return $arrayModules;
    }

    public function getModulesSort() {
        $arrayModules = $this->getModules();
        $arrarSortModules = '';
        foreach($arrayModules as $id => $arrayModule) {
            //$arrayModule['modules_id'] = encode($arrayModule['modules_id']);
            $arrarSortModules[$arrayModule['modules_father_id']][] = $arrayModule;
        }
        return $arrarSortModules;
    }

    public function saveModules($arrayData) {
        return ModulesDao::instance()->setTable('modules')->insert($arrayData);
    }

    public function updateModules($where, $row) {
        return ModulesDao::instance()->setTable('modules')->update($where, $row);
    }

    public function deleteModules($where) {
        return ModulesDao::instance()->setTable('modules')->delete($where);
    }

}