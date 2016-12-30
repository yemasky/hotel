<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class RoleService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new RoleService();
        return self::$objService;
    }

    public function getRoleModulesEmployee($employee_id) {
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$employee_id);
        return RoleDao::instance()->getRoleModulesEmployee($conditions);
    }

    //角色
    public function getRole($conditions, $field = '*', $hashKey = null, $multiple = false, $fatherKey = '') {
        return RoleDao::instance()->setTable('role')->getList($conditions, $field, $hashKey, $multiple, $fatherKey);
    }

    public function saveRole($arrayData) {
        return RoleDao::instance()->setTable('role')->insert($arrayData);
    }

    public function updateRole($where, $row) {
        return RoleDao::instance()->setTable('role')->update($where, $row);
    }

    public function deleteRole($where) {
        return RoleDao::instance()->setTable('role')->delete($where);
    }


}