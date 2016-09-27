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
        $pn = empty($objRequest->pn) ? 1 : $objRequest->pn;
        $pn_rows = $objRequest->pn_rows;

        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']);
        $parameters['module'] = encode(decode($objRequest->module));

        $arrayPageHotelId = EmployeeService::pageEmployeeHotel($conditions, $pn, $pn_rows, $parameters);

        $arrayHotel = null;
        if(!empty($arrayPageHotelId['list_data'])) {
            $stringHotelId = '';
            foreach($arrayPageHotelId['list_data'] as $k => $v) {
                $stringHotelId .= $v['hotel_id'] . ',';
            }
            $stringHotelId = trim($stringHotelId, ',');
            $conditions['where'] = array('IN'=>array('hotel_id'=>$stringHotelId));
            $arrayHotel = HotelService::getHotel($conditions);
            foreach ($arrayHotel as $k => $v) {
                //\BaseUrlUtil::Url(array('module'=>encode($arrayHotelModules[$i]['modules_id'])));
                $arrayHotel[$k]['edit_url'] = \BaseUrlUtil::Url(array('module'=>encode(22), 'hotel_id'=>encode($arrayHotel[$k]['hotel_id'])));
                $arrayHotel[$k]['delete_url'] = \BaseUrlUtil::Url(array('module'=>encode(33), 'hotel_id'=>encode($arrayHotel[$k]['hotel_id'])));;
            }
        }

        //赋值
        $objResponse -> setTplValue("arrayHotel", $arrayHotel);
        $objResponse -> setTplValue("page", $arrayPageHotelId['page']);
        $objResponse -> setTplValue("pn", $pn);
        //设置类别

        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }
}