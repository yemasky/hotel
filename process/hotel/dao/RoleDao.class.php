<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class RoleDao extends \BaseDao {

    public function getRoleModulesEmployee($conditions){
        $cacheId = md5('getRoleModulesEmployee' . json_encode($conditions));
        $fileid = 'role_id, modules_id, employee_id, role_modules_action_permissions';
        return $this->setDsnRead(\DbConfig::hotel_dsn_read)->setTable('role_modules_employee')->getList($conditions, $fileid, 'modules_id');//->DBCache($cacheId)
    }
}