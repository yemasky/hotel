<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class RoomsStatusAction extends \BaseAction {
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
        $thisDay = $objRequest -> time_begin;
        $toDay = $objRequest -> time_end;
        $thisDay = empty($thisDay) ? getDay() : $thisDay;
        $toDay = empty($toDay) ? getDay() : $toDay;

        $hotel_id = $objResponse -> arrayLoginEmployeeInfo['hotel_id'];
        $conditions = DbConfig::$db_query_conditions;
        //房子
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $conditions['order'] = 'room_mansion, room_floor, room_number';
        $arrayRoom = RoomService::instance()->getRoom($conditions, '*', 'room_mansion', true, '', 'room_floor');
        $conditions['order'] = '';
        print_r($arrayRoom);
        //赋值
        $objResponse -> arrayRoom = $arrayRoom;
        $objResponse -> thisYear = getYear();
        $objResponse -> thisMonth = getMonth();
        $objResponse -> thisDay = $thisDay;
        $objResponse -> toDay = $toDay;
        $objResponse -> module = $objRequest->module;

        $objResponse -> search_url =
            \BaseUrlUtil::Url('');
        //设置类别
    }
}