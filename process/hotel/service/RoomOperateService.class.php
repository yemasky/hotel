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
        $extra_bed_price = $objRequest -> extra_bed_price;
        $arrayExtraBed = $objRequest->extra_bed;
        $extraBed = false;
        if(!empty($arrayExtraBed) && is_array($arrayExtraBed)) {
            $extraBed = true;
        }
        //只允许2年内的价格
        if(($arrayTimeBegin['0'] - $thisYear) > 1 || ($arrayTimeEnd[0] - $thisYear) > 1 || $arrayTimeBegin['0'] < $thisYear
            || $arrayTimeEnd[0] < $thisYear || $arrayTimeBegin['0'] > $arrayTimeEnd[0]) {
            return array(0, '选择的年份不对！');
        }
        if(empty($room_layout_id) || empty($room_layout_price_system_id)) {
            return array(0, '传输数据有误！');
        }
        //
        $beginWeek = date("N", strtotime($arrayPostValue['time_begin']));
        $beginT = date("t", strtotime($arrayPostValue['time_begin']));
        $arrarMonthData = array();
        $arrarMonthExtraBedData = array();
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
            if(trim($arrayPostValue['week_' . $beginWeek]) != '')
                $arrarMonthData[$day . '_day'] = $arrayPostValue['week_' . $beginWeek];
            if(!empty($extra_bed_price)) {
                $arrarMonthExtraBedData[$day . '_day'] = $extra_bed_price;
            }
            if($extraBed) {
                if(trim($arrayExtraBed['week_' . $beginWeek]) != '')
                    $arrarMonthExtraBedData[$day . '_day'] = $arrayExtraBed['week_' . $beginWeek];
            }
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
        if(!empty($arrarMonthExtraBedData)) {//加床
            $arrarMonthExtraBedData['room_layout_id'] = $room_layout_id;
            $arrarMonthExtraBedData['room_layout_price_system_id'] = $room_layout_price_system_id;
            $arrarMonthExtraBedData['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
            $arrarMonthExtraBedData['room_layout_date_year'] = $arrayTimeBegin['0'];
            $arrarMonthExtraBedData['room_layout_date_month'] = $arrayTimeBegin['1'];
            $arrayExtenBed = RoomService::instance()->getRoomLayoutExtenBedPrice($conditions);
            if(!empty($arrayExtenBed)) {//update
                RoomService::instance()->updateRoomLayoutExtenBedPrice($conditions['where'], $arrarMonthExtraBedData);
            } else {
                $arrarMonthExtraBedData['room_layout_price_add_date'] = getDay();
                $arrarMonthExtraBedData['room_layout_price_add_time'] = getTime();
                RoomService::instance()->saveRoomLayoutExtenBedPrice($arrarMonthExtraBedData);
            }
        }
        if($isTheSameYear == true && $isTheSameMonth == false) {//相同的年不同的月
            $beginMonth = $arrayTimeBegin[1] + 1;
            for($i = $beginMonth; $i <= $arrayTimeEnd[1]; $i++) {
                $arrarMonthData = array();
                $arrarMonthExtraBedData = array();
                $endT = date("t", strtotime($arrayPostValue['time_begin']));
                if($i == $arrayTimeEnd[1]) $endT = $arrayTimeEnd[2];
                $beginWeek = date("N", strtotime($arrayTimeBegin[0] . '-' . $i . '-1'));
                for($j = 1; $j <= $endT; $j++) {
                    if($beginWeek > 7) $beginWeek = $beginWeek - 7;
                    $day = $j < 10 ? '0' . $j : $j;
                    if(trim($arrayPostValue['week_' . $beginWeek]) != '')
                        $arrarMonthData[$i][$day . '_day'] = $arrayPostValue['week_' . $beginWeek];
                    if(!empty($extra_bed_price)) {
                        $arrarMonthExtraBedData[$i][$day . '_day'] = $extra_bed_price;
                    }
                    if($extraBed) {
                        if(trim($arrayExtraBed['week_' . $beginWeek]) != '')
                            $arrarMonthExtraBedData[$i][$day . '_day'] = $arrayExtraBed['week_' . $beginWeek];
                    }
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
                if(!empty($arrarMonthExtraBedData)) {//加床
                    $arrarMonthExtraBedData[$i]['room_layout_id'] = $room_layout_id;
                    $arrarMonthExtraBedData[$i]['room_layout_price_system_id'] = $room_layout_price_system_id;
                    $arrarMonthExtraBedData[$i]['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                    $arrarMonthExtraBedData[$i]['room_layout_date_year'] = $arrayTimeBegin['0'];
                    $arrarMonthExtraBedData[$i]['room_layout_date_month'] = $i;
                    $arrayExtenBed = RoomService::instance()->getRoomLayoutExtenBedPrice($conditions);
                    if(!empty($arrayExtenBed)) {//update
                        RoomService::instance()->updateRoomLayoutExtenBedPrice($conditions['where'], $arrarMonthExtraBedData[$i]);
                    } else {
                        $arrarMonthExtraBedData[$i]['room_layout_price_add_date'] = getDay();
                        $arrarMonthExtraBedData[$i]['room_layout_price_add_time'] = getTime();
                        RoomService::instance()->saveRoomLayoutExtenBedPrice($arrarMonthExtraBedData[$i]);
                    }
                }
            }
            //print_r($arrarMonthData);
        }
        if($isTheSameYear == false) {//不相同的年
            for($i = $arrayTimeBegin[0]; $i <= $arrayTimeEnd[0]; $i++) {//year
                $beginMonth = ($i == $arrayTimeBegin[0]) ? $arrayTimeBegin[1] + 1 : 1;
                $endMonth = ($i == $arrayTimeBegin[0]) ? 12 : $arrayTimeEnd[1];
                for($j = $beginMonth; $j <= $endMonth; $j++) {
                    $arrarMonthData = array();
                    $arrarMonthExtraBedData = array();
                    $endT = date("t", strtotime($i . '-' . $j . '-1'));
                    if($i == $arrayTimeEnd[0] && $j == $arrayTimeEnd[1]) $endT = $arrayTimeEnd[2];
                    $beginWeek = date("N", strtotime($i . '-' . $j . '-1'));
                    //echo $i . '-' . $j . '-1---' . $beginWeek . '--<br>';//exit();
                    for($k = 1; $k <= $endT; $k++) {
                        if($beginWeek > 7) $beginWeek = $beginWeek - 7;
                        $day = $k < 10 ? '0' . $k : $k;
                        if(trim($arrayPostValue['week_' . $beginWeek]) != '')
                            $arrarMonthData[$i][$j][$day . '_day'] = $arrayPostValue['week_' . $beginWeek];
                        if(!empty($extra_bed_price)) {
                            $arrarMonthExtraBedData[$i][$j][$day . '_day'] = $extra_bed_price;
                        }
                        if($extraBed) {
                            if(trim($arrayExtraBed['week_' . $beginWeek]) != '')
                                $arrarMonthExtraBedData[$i][$j][$day . '_day'] = $arrayExtraBed['week_' . $beginWeek];
                        }
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
                    if(!empty($arrarMonthExtraBedData)) {//加床
                        $arrarMonthExtraBedData[$i][$j]['room_layout_id'] = $room_layout_id;
                        $arrarMonthExtraBedData[$i][$j]['room_layout_price_system_id'] = $room_layout_price_system_id;
                        $arrarMonthExtraBedData[$i][$j]['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                        $arrarMonthExtraBedData[$i][$j]['room_layout_date_year'] = $i;
                        $arrarMonthExtraBedData[$i][$j]['room_layout_date_month'] = $j;
                        $arrayExtenBed = RoomService::instance()->getRoomLayoutExtenBedPrice($conditions);
                        if(!empty($arrayExtenBed)) {//update
                            RoomService::instance()->updateRoomLayoutExtenBedPrice($conditions['where'], $arrarMonthExtraBedData[$i][$j]);
                        } else {
                            $arrarMonthExtraBedData[$i][$j]['room_layout_price_add_date'] = getDay();
                            $arrarMonthExtraBedData[$i][$j]['room_layout_price_add_time'] = getTime();
                            RoomService::instance()->saveRoomLayoutExtenBedPrice($arrarMonthExtraBedData[$i][$j]);
                        }
                    }
                }
            }
            //print_r($arrarMonthData);
        }
        RoomDao::instance()->commit();
        return array('1', '保存成功！如果价格为空，不做更改！');

    }

    public function saveRoomLayoutPriceMonth($objRequest, $objResponse) {
        $arrayPostValue= $objRequest->getPost();
        $room_layout_date_month = $arrayPostValue['room_layout_date_month'];
        $room_layout_date_year = $arrayPostValue['room_layout_date_year'];
        $room_layout_id = $objRequest -> room_layout;
        $room_layout_price_system_id = $objRequest -> system_id;
        $thisYear = getYear();
        //只允许2年内的价格
        if(($room_layout_date_year - $thisYear) > 1) {
            return array(0, '选择的年份不对！');
        }
    }

    public function rollback() {
        RoomDao::instance()->rollback();
    }


}