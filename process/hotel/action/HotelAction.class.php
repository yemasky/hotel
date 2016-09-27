<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class HotelAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'hotelSetting';
        $objResponse -> setTplValue('navigation', 'hotelSetting');
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        //赋值
        $arrayHotelId = EmployeeService::getEmployeeHotel($objResponse->arrayLoginEmployeeInfo['employee_id']);
        $conditions = \DbConfig::$db_query_conditions;
        $arrayCompany = null;
        if(!empty($arrayHotelId)) {
            $stringHotelId = '';
            foreach($arrayHotelId as $k => $v) {
                $stringHotelId .= $v['hotel_id'] . ',';
            }
            $stringHotelId = trim($stringHotelId, ',');
            $conditions['where'] = array('IN'=>array('hotel_id'=>$stringHotelId));
            $arrayCompany = CompanyService::getCompany($conditions);
            foreach ($arrayCompany as $k => $v) {
                //\BaseUrlUtil::Url(array('module'=>encode($arrayHotelModules[$i]['modules_id'])));
                $arrayCompany[$k]['edit_url'] = \BaseUrlUtil::Url(array('module'=>encode(22), 'company_id'=>encode($arrayCompany[$k]['company_id'])));
                $arrayCompany[$k]['delete_url'] = \BaseUrlUtil::Url(array('module'=>encode(decode($objRequest->module)), 'action'=>'delete', 'company_id'=>encode($arrayCompany[$k]['company_id'])));;
            }
        }

        //设置类别

        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }
}