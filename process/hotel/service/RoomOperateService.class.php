<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;

class RoomOperateService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new RoomOperateService();
        return self::$objService;
    }

    public function saveRoomLayoutPriceWeek($objRequest, $objResponse) {
        $arrayPostValue= $objRequest->getPost();
        $arrayTimeBegin = explode('-', $arrayPostValue['time_begin']);
        $arrayTimeEnd = explode('-', $arrayPostValue['time_end']);
        $room_layout_id = $objRequest -> room_layout;
        $room_layout_price_system_id = $objRequest -> system_id;
        $thisYear = getYear();
        //只允许2年内的价格
        if(($arrayTimeBegin['0'] - $thisYear) > 1 || ($arrayTimeEnd[0] - $thisYear) > 1 || $arrayTimeBegin['0'] < $thisYear
            || $arrayTimeEnd[0] < $thisYear || $arrayTimeBegin['0'] > $arrayTimeEnd[0]) {
            return array(0, '选择的年份不对！');
        }
        //
        $beginWeek = date("w", strtotime($arrayPostValue['time_begin']));
        $beginT = date("t", strtotime($arrayPostValue['time_begin']));
        $arrarMonthData = array();
        $isTheSameYear = false;
        $isTheSameMonth = false;
        if($arrayTimeBegin[0] == $arrayTimeEnd[0]) {
            $isTheSameYear = true;
        }
        if($isTheSameYear == true && $arrayTimeBegin[1] == $arrayTimeEnd[1]) {
            $isTheSameMonth = true;//相同的年月
            $beginT = $arrayTimeEnd[2];
        }
        $i = $arrayTimeBegin[2] + 0;
        for($i; $i <= $beginT; $i++) {
            if($beginWeek > 7) $beginWeek = $beginWeek - 7;
            $day = $i < 10 ? '0' . $i : $i;
            $arrarMonthData[$day . '_day'] = $arrayPostValue['week_' . $beginWeek];
            $beginWeek++;
        }
        $arrarMonthData['room_layout_id'] = $room_layout_id;
        $arrarMonthData['room_layout_price_system_id'] = $room_layout_price_system_id;
        $arrarMonthData['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $arrarMonthData['room_layout_date_year'] = $arrayTimeBegin['0'];
        $arrarMonthData['room_layout_date_month'] = $arrayTimeBegin['1'];
        //print_r($arrarMonthData);
        //
        $conditions = DbConfig::$db_query_conditions;
        //售卖房型
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
            'room_layout_date_year'=>$arrayTimeBegin['0'],'room_layout_date_month'=>$arrayTimeBegin['1'],
            'room_layout_id'=>$room_layout_id, 'room_layout_price_system_id'=>$room_layout_price_system_id);
        $arrayBeginYear = RoomService::instance()->getRoomLayoutPrice($conditions);
        //
        RoomDao::instance()->startTransaction();
        if(!empty($arrayBeginYear)) {//update
            RoomService::instance()->updateRoomLayoutPrice($conditions['where'], $arrarMonthData);
        } else {
            $arrarMonthData['room_layout_price_add_date'] = getDay();
            $arrarMonthData['room_layout_price_add_time'] = getTime();
            RoomService::instance()->saveRoomLayoutPrice($arrarMonthData);
        }
        if($isTheSameYear == true && $isTheSameMonth == false) {//相同的年不同的月
            $arrarMonthData = array();
            $beginMonth = $arrayTimeBegin[1] + 1;
            for($i = $beginMonth; $i <= $arrayTimeEnd[1]; $i++) {
                $endT = date("t", strtotime($arrayPostValue['time_begin']));
                if($i == $arrayTimeEnd[1]) $endT = $arrayTimeEnd[2];
                $beginWeek = date("w", strtotime($arrayTimeBegin[0] . '-' . $i . '-1'));
                for($j = 1; $j <= $endT; $j++) {
                    if($beginWeek > 7) $beginWeek = $beginWeek - 7;
                    $day = $j < 10 ? '0' . $j : $j;
                    $arrarMonthData[$i][$day . '_day'] = $arrayPostValue['week_' . $beginWeek];
                    $beginWeek++;
                }
                //售卖房型
                $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                    'room_layout_date_year'=>$arrayTimeBegin['0'],'room_layout_date_month'=>$i,
                    'room_layout_id'=>$room_layout_id, 'room_layout_price_system_id'=>$room_layout_price_system_id);
                $arrayBeginYear = RoomService::instance()->getRoomLayoutPrice($conditions);
                //
                $arrarMonthData[$i]['room_layout_id'] = $room_layout_id;
                $arrarMonthData[$i]['room_layout_price_system_id'] = $room_layout_price_system_id;
                $arrarMonthData[$i]['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                $arrarMonthData[$i]['room_layout_date_year'] = $arrayTimeBegin['0'];
                $arrarMonthData[$i]['room_layout_date_month'] = $i;
                if(!empty($arrayBeginYear)) {//update
                    RoomService::instance()->updateRoomLayoutPrice($conditions['where'], $arrarMonthData[$i]);
                } else {
                    $arrarMonthData[$i]['room_layout_price_add_date'] = getDay();
                    $arrarMonthData[$i]['room_layout_price_add_time'] = getTime();
                    RoomService::instance()->saveRoomLayoutPrice($arrarMonthData[$i]);
                }
            }
            //print_r($arrarMonthData);
        }
        if($isTheSameYear == false) {//不相同的年
            $arrarMonthData = array();
            for($i = $arrayTimeBegin[0]; $i <= $arrayTimeEnd[0]; $i++) {//year
                $beginMonth = ($i == $arrayTimeBegin[0]) ? $arrayTimeBegin[1] + 1 : 1;
                $endMonth = ($i == $arrayTimeBegin[0]) ? 12 : $arrayTimeEnd[1];
                for($j = $beginMonth; $j <= $endMonth; $j++) {
                    $endT = date("t", strtotime($i . '-' . $j . '-01'));
                    if($i == $arrayTimeEnd[0] && $j == $arrayTimeEnd[1]) $endT = $arrayTimeEnd[2];
                    $beginWeek = date("w", strtotime($arrayTimeBegin[0] . '-' . $i . '-1'));
                    for($k = 1; $k <= $endT; $k++) {
                        if($beginWeek > 7) $beginWeek = $beginWeek - 7;
                        $day = $k < 10 ? '0' . $k : $k;
                        $arrarMonthData[$i][$j][$day . '_day'] = $arrayPostValue['week_' . $beginWeek];
                        $beginWeek++;
                    }
                    //售卖房型
                    $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                        'room_layout_date_year'=>$i,'room_layout_date_month'=>$j,
                        'room_layout_id'=>$room_layout_id, 'room_layout_price_system_id'=>$room_layout_price_system_id);
                    $arrayBeginYear = RoomService::instance()->getRoomLayoutPrice($conditions);
                    //
                    $arrarMonthData[$i][$j]['room_layout_id'] = $room_layout_id;
                    $arrarMonthData[$i][$j]['room_layout_price_system_id'] = $room_layout_price_system_id;
                    $arrarMonthData[$i][$j]['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                    $arrarMonthData[$i][$j]['room_layout_date_year'] = $i;
                    $arrarMonthData[$i][$j]['room_layout_date_month'] = $j;
                    if(!empty($arrayBeginYear)) {//update
                        RoomService::instance()->updateRoomLayoutPrice($conditions['where'], $arrarMonthData[$i][$j]);
                    } else {
                        $arrarMonthData[$i][$j]['room_layout_price_add_date'] = getDay();
                        $arrarMonthData[$i][$j]['room_layout_price_add_time'] = getTime();
                        RoomService::instance()->saveRoomLayoutPrice($arrarMonthData[$i][$j]);
                    }
                }

            }
            //print_r($arrarMonthData);
        }
        RoomDao::instance()->commit();
        return array('1', '保存成功！');

    }

    public function rollback() {
        RoomDao::instance()->rollback();
    }


}