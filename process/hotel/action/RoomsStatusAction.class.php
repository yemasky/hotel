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
        $conditions['where'] = array('hotel_id'=>$hotel_id, 'room_type'=>1);
        $conditions['order'] = 'room_mansion, room_floor, room_number, room_id';
        $arrayRoom = RoomService::instance()->getRoom($conditions, '*', 'room_mansion', true, '', 'room_floor');
        $conditions['order'] = '';
        //房态
        $arrayCheckInRoom = RoomsStatusService::instance()->getRoomStatus($conditions, $hotel_id, $thisDay, $toDay);
        //重新组合数据


        //赋值
        $objResponse -> arrayRoom = $arrayRoom;
        $objResponse -> arrayRoomStatus = json_encode($arrayCheckInRoom);
        $objResponse -> thisYear = getYear();
        $objResponse -> yearEnd = getYear();
        $objResponse -> nextYear = getYear();
        $objResponse -> thisMonth = getMonth();
        $objResponse -> thisDay = $thisDay;
        $objResponse -> toDay = $toDay;
        $objResponse -> nowDay = getDay();
        $objResponse -> module = $objRequest->module;

        $objResponse -> search_url =
            \BaseUrlUtil::Url('');
        //设置类别
    }
}