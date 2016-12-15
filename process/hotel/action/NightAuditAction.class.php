<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class NightAuditAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {

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
        $act = $objRequest -> act;
        $thisDay = $objRequest -> time_begin;
        $thisDay = empty($thisDay) ? getDay() : $thisDay;
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];

        //赋值
        $objResponse -> thisYear = getYear();
        $objResponse -> thisMonth = getMonth();
        $objResponse -> thisDay = $thisDay;
        $objResponse -> nextYear = $objResponse -> nextYear = $objResponse -> thisYear + 1;

        $objResponse -> module = $objRequest->module;
        $objResponse -> search_url = \BaseUrlUtil::Url('');
        $objResponse -> act = $act;

        if($act == 'night_audit') {
            $this->doNightAudit($objRequest, $objResponse);
            return;
        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id, 'book_is_check_date'=>$thisDay);
        $arrayThisDayBook = BookService::instance()->getBookNightAudit($conditions);

        //赋值
        $objResponse -> arrayData = $arrayThisDayBook;


        //设置类别
    }

    protected function doNightAudit($objRequest, $objResponse) {
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $nowDay = getDay();
        $yesterday = getDay(-24);
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id, 'hotel_service_setting_type'=>'night_audit');
        $nightAuditTime = HotelService::instance()->getHotelServiceSetting($conditions);
        $nightAuditTime = $nightAuditTime[0]['hotel_service_setting_value'];//夜审开始和截止时间

        //判断是否到时间开始夜审
        $isArriveTime = false;
        if(strtotime(getDateTime()) >= strtotime($nowDay . ' ' . $nightAuditTime)) {
            $isArriveTime = true;
        }
        $objResponse-> isArriveTime = $isArriveTime;
        $arrayBookInfo = '';
        if($isArriveTime) {
            $conditions['where'] = array('hotel_id'=>$hotel_id, 'book_is_check'=>'0',
                                         '>='=>array('book_add_date'=>$yesterday));
            $arrayBookInfo = BookService::instance()->getBook($conditions);
            if(!empty($arrayBookInfo)) {
                foreach($arrayBookInfo as $i => $arrayBook) {

                }
            }

        }
        $objResponse -> arrayBookInfo = $arrayBookInfo;


    }

}