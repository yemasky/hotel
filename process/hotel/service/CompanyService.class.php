<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class CompanyService extends \BaseService {
    public static function getCompany($company_id, $hashKey = null) {
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('company_id'=>$company_id);
        return CompanyDao::instance('\hotel\CompanyDao')->getCompany($conditions, $hashKey);
    }


}