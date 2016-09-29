<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class CompanyService extends \BaseService {
    public static function getCompany($conditions, $hashKey = null) {
        return CompanyDao::instance('\hotel\CompanyDao')->getCompany($conditions, $hashKey);
    }

    public static function saveCompany($arrayData) {
        return CompanyDao::instance('\hotel\CompanyDao')->insert($arrayData);
    }

    public static function updateCompany($where, $row) {
        return CompanyDao::instance('\hotel\CompanyDao')->update($where, $row);
    }

}