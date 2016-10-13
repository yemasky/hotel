<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class EmployeeService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new EmployeeService();
        return self::$objService;
    }

    public function getEmployeeCompany($conditions, $hashKey = null) {
        return EmployeeDao::instance()->getEmployeeDepartment($conditions, 'DISTINCT company_id', $hashKey);
    }

    public function pageEmployeeCompany($conditions, $pn, $pn_rows, $parameters) {
        $pn_rows = empty($pn_rows) ? DbConfig::page_rows : $pn_rows;
        $count = EmployeeDao::instance()->getEmployeeDepartmentCount($conditions['where'], 'DISTINCT company_id');
        $all_page_num = ceil($count/$pn_rows);
        $pn = $pn > $all_page_num ? $all_page_num : $pn;
        $conditions['limit'] = ($pn - 1) * $pn_rows . ',' . $pn_rows;
        $conditions['order'] = 'company_id DESC';
        $arrayEmployeeCompany = self::getEmployeeCompany($conditions);
        return page($pn, $all_page_num, $arrayEmployeeCompany, $parameters);
    }

    public function getEmployeeHotel($conditions, $hashKey = null) {
        return EmployeeDao::instance()->getEmployeeDepartment($conditions, 'DISTINCT hotel_id', $hashKey);
    }

    public function pageEmployeeHotel($conditions, $pn, $pn_rows, $parameters) {
        $pn_rows = empty($pn_rows) ? DbConfig::page_rows : $pn_rows;
        $count = EmployeeDao::instance()->getEmployeeDepartmentCount($conditions['where'], 'DISTINCT hotel_id');
        $all_page_num = ceil($count/$pn_rows);
        $pn = $pn > $all_page_num ? $all_page_num : $pn;
        $conditions['limit'] = ($pn - 1) * $pn_rows . ',' . $pn_rows;
        $conditions['order'] = 'hotel_id DESC';
        $arrayEmployeeHotel = $this->getEmployeeHotel($conditions);
        return page($pn, $all_page_num, $arrayEmployeeHotel, $parameters);
    }
    
    public function saveEmployeeDepartment($arrayData) {
        return EmployeeDao::instance()->saveEmployeeDepartment($arrayData);
    }
}