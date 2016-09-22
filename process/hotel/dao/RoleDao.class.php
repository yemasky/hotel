<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class RoleDao extends \BaseDao {

    public function getRoleModulesEmployee($employee_id){
        $fileid = 'modules_id, employee_id';
        return \DBQuery::instance(\DbConfig::hotel_dsn_read)->setTable('role_modules_employee')->getList(array('employee_id'=>$employee_id), $fileid);
    }
}