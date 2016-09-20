<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class HotelEmployeeDao extends \BaseDao {

    public function getLoginEmployee($arrayLoginInfo){
        $fileid = 'employee_id, company_id, hotel_id, employee_name, employee_mobile, employee_password, employee_password_salt, employee_email, employee_add_date, employee_add_time';
        return \DBQuery::instance(\DbConfig::hotel_dsn_read)->setTable('employee')->getRow($arrayLoginInfo, $fileid);
    }
}