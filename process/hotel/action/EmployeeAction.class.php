<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class EmployeeAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'roomsManagement';
        $objResponse -> setTplValue('navigation', 'roomsManagement');
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'edit':
                $this->doEdit($objRequest, $objResponse);
                break;
            case 'add':
                $this->doAdd($objRequest, $objResponse);
                break;
            case 'delete':
                $this->doDelete($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $arrayDepartment = HotelService::instance()->getHotelDepartment($conditions, '*', 'department_id');

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        //$arrayPosition = HotelService::instance()->getHotelDepartmentPosition($conditions);
        $arrayPosition = HotelService::instance()->getHotelDepartmentPosition($conditions, '*', 'department_position_id');

        $arrayPageEmployee = $this->getPageEmployee($objRequest, $objResponse);
        //
        $objResponse -> arrayDepartment = $arrayDepartment;
        $objResponse -> arrayPosition = $arrayPosition;
        $objResponse -> arrayPageEmployee = $arrayPageEmployee;
        $objResponse -> add_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['employee']['add'])));
        $objResponse -> edit_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['employee']['edit'])));
        $objResponse -> delete_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['employee']['delete'])));
        $objResponse -> view_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['employee']['view'])));
        //设置类别
    }

    protected function doAdd($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {
        $this->setDisplay();

        return $this->errorResponse('没有保存任数据');
        //$objResponse -> add_room_attribute_url =
        //    \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['edit'])));
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();

    }

    protected function getPageEmployee($objRequest, $objResponse) {
        $pn = $objRequest -> pn;
        $pn = $pn > 0 ? $pn : 1;
        $pn_rows = $objRequest -> pn_rows;
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $parameters['module'] = encode(decode($objRequest->module));
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $arrayEmplayee = EmployeeService::instance()->pageEmployee($conditions, $pn, $pn_rows, $parameters);
        $objResponse -> pn = $pn;
        $objResponse -> page = $arrayEmplayee['page'];
        return $arrayEmplayee;
    }

}