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
        $conditions['where'] = array('hotel_id'=>$hotel_id, 'book_night_audit_date'=>$thisDay);
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
        $conditions['where'] = array('IN'=>array('hotel_id'=>array($hotel_id,0)), 'hotel_service_setting_type'=>'night_audit');
        $nightAuditTime = HotelService::instance()->getHotelServiceSetting($conditions);
        $nightAuditTime = $nightAuditTime[0]['hotel_service_setting_value'];//夜审开始和截止时间

        //判断是否到时间开始夜审
        $isArriveTime = false;
        if(strtotime(getDateTime()) >= strtotime($nowDay . ' ' . $nightAuditTime)) {
            $isArriveTime = true;
            $nightAuditDate = getDateTime();
        }
        $objResponse-> isArriveTime = $isArriveTime;
        $arrayBookInfo = '';
        if($isArriveTime) {
            $conditions['where'] = array('hotel_id'=>$hotel_id,
                                         '>='=>array('book_order_number_status'=>0,'book_check_out'=>$nightAuditDate),
                                         '<='=>array('book_check_in'=>$nightAuditDate),
                                         '<>'=>array('book_night_audit_date'=>$nowDay));
            $field = 'book_id, room_id, room_sell_layout_id, room_layout_id,book_room_extra_bed,book_order_number,book_order_number_status,book_check_in,book_check_out,'
                .'book_order_retention_time,book_contact_name,book_contact_mobile,book_comments';
            $arrayBookInfo = BookService::instance()->getBook($conditions, $field, 'book_order_number', true);
            if(!empty($arrayBookInfo)) {
                /*foreach($arrayBookInfo as $i => $arrayBook) {
                    $arrayBookInfo[$i]['is_correct'] = 0;
                    if($arrayBookInfo[$i]['book_order_number_status'] != '0') {
                        $arrayBookInfo[$i]['is_correct'] = 1;
                    }
                }*/
            }
        }
        //房子
        $conditions['where'] = array('hotel_id'=>$hotel_id, 'room_type'=>1);
        $conditions['order'] = 'room_mansion, room_floor, room_number, room_id';
        $arrayRoom = RoomService::instance()->getRoom($conditions, '*', 'room_id');
        $conditions['order'] = '';

        //核对价格
        $conditions['where'] = array('hotel_id'=>$hotel_id,
                                     'IN'=>array('book_order_number'=>''));


        $objResponse -> arrayDataInfo = $arrayBookInfo;
        $objResponse -> arrayRoom = $arrayRoom;


    }

}