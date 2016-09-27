<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class EmployeeDao extends \BaseDao {

    public function getEmployee($conditions){
        $fileid = 'employee_id, company_id, hotel_id, employee_name, employee_mobile, employee_password, employee_password_salt, employee_email, employee_add_date, employee_add_time';
        return $this->setDsnRead(\DbConfig::hotel_dsn_read)->setTable('employee')->getList($conditions, $fileid);
    }

    public function getEmployeeDepartment($conditions, $fileid = null, $hashKey = null){
        if(empty($fileid)) $fileid = 'company_id, hotel_id, employee_id, department_id';
        return $this->setDsnRead(\DbConfig::hotel_dsn_read)->setTable('employee_department')->getList($conditions, $fileid, $hashKey);
    }

    public function getEmployeeDepartmentCount($conditions_where, $fileid = 'employee_id'){
        return $this->setDsnRead(\DbConfig::hotel_dsn_read)->setTable('employee_department')->getCount($conditions_where, $fileid);
    }
}