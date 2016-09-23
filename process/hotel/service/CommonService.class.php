<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class CommonService extends \BaseService {
    public static function getEmployeeModules($arrayLoginEmployeeInfo) {
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$arrayLoginEmployeeInfo['employee_id']);
        $arrayRoleModulesEmployee = RoleDao::instance('\hotel\RoleDao')->getRoleModulesEmployee($conditions);

    }


}