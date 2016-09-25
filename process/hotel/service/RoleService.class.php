<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class RoleService extends \BaseService {
    public static function getRoleModulesEmployee($employee_id) {
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$employee_id);
        return RoleDao::instance('\hotel\RoleDao')->getRoleModulesEmployee($conditions);
    }


}