<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;

class BookOperateService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new BookOperateService();
        return self::$objService;
    }

    public function rollback() {
        BookDao::instance()->rollback();
    }

    public function saveBookInfo($objRequest, $objResponse) {
        $arrayPostValue = $objRequest->getPost();
        $payment = $arrayPostValue['payment'];//支付 类型
        $payment_type = $arrayPostValue['payment_type'];//支付方式  微信支付宝等
        $is_pay = $arrayPostValue['is_pay'];//付款已到账
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $arrayThenRoomPrice = json_decode(stripslashes($objRequest->thenRoomPrice), true);
        //联系信息 <!-- -->
        $arrayBill['book_contact_name']             = $arrayPostValue['book_contact_name'];//联系人
        $arrayBill['book_contact_mobile']           = $arrayPostValue['book_contact_mobile'];//联系人移动电话
        $arrayBill['user_id']                       = '';////
        $arrayBill['hotel_id']                      = $hotel_id;
        //来源 <!-- -->
        $arrayBill['book_type_id']                  = $arrayPostValue['book_type_id'];
        $arrayBill['book_order_number_ourter']      = $objRequest -> book_order_number_ourter;//如果是OTA 有外部订单号
        //折扣 <!-- -->
        $arrayBill['book_discount']                 = $arrayPostValue['book_discount'];//实际折扣
        if(isset($arrayPostValue['book_discount_id']))
            $arrayBill['book_discount_id']          = $arrayPostValue['book_discount_id'];//折扣ID
        $arrayBill['book_discount_describe']        = $arrayPostValue['book_discount_describe'];//折扣描述
        //半天房费计算时间 <!-- -->
        $arrayBill['book_half_price']                    = $arrayPostValue['half_price'];
        //入住日期 <!-- -->
        $arrayBill['book_check_in']                 = $arrayPostValue['book_check_in'];//入住时间
        $arrayBill['book_check_out']                = $arrayPostValue['book_check_out'];//退房时间
        $arrayBill['book_order_retention_time']     = $arrayPostValue['book_order_retention_time'];//订单保留时间
        //主订单 <!-- -->
        $arrayBill['book_order_number_main']        = '0';//主订单号
        $arrayBill['book_order_number']             = 1;//订单号
        //订单状态 <!-- -->
        $arrayBill['book_order_number_status']      = '0';//订单状态 -1 失效 0预定成功 1入住 2退房完成

        //支付
            //预付
        $arrayBill['book_prepayment_price']         = $arrayPostValue['book_prepayment_price'];//预付费
        if($payment == 1) {
            $arrayBill['book_is_prepayment']        = $is_pay;//是否已支付预付费
            if($is_pay == 1) {//支付是否到账
                $arrayBill['book_prepayment_date']  = getDateTime();//预付费支付时间
            }
            $arrayBill['prepayment_type_id']        = $payment_type;//预付 支付方式  微信支付宝等
            $arrayBill['book_prepayment_account']       = '';//预付支付帐号
        }
            //全额支付 余额
        if($payment == 3 || $payment == 2) {
            $arrayBill['book_is_pay']               = '1';//是否已经全额支付房费
            $arrayBill['book_is_payment']           = $is_pay;//是否已到帐
            $arrayBill['payment_type_id']           = $payment_type;//预付 支付方式  微信支付宝等
            if($is_pay == 1) {//支付是否到账
                $arrayBill['book_pay_date']  = getDateTime();//支付时间
            }
        }
        if($payment == 2) {//余额支付时间
            $arrayBill['book_balance_payment_date'] = getDateTime();
        }
        $arrayBill['book_payment_voucher']          = $arrayPostValue['book_payment_voucher'];//付款凭证

        //计算价格
        //总房费
        $arrayBill['book_total_room_rate']          = $arrayPostValue['total_room_rate'];//总房费
        //总押金
        $arrayBill['book_total_cash_pledge']        = $arrayPostValue['book_total_cash_pledge'];//总房费
        //需要服务的费用
        $arrayBill['book_need_service_price']       = $arrayPostValue['need_service_price'];//需要服务的费用
        //服务费
        $arrayBill['book_service_charge']           = $arrayPostValue['book_service_charge'];//服务费
        //总费用
        $arrayBill['book_total_price']              = $arrayPostValue['book_total_price'];//计算支付总价

        //备注
        $arrayBill['book_comments']              = $arrayPostValue['comments'];//计算支付总价
        //时间
        $arrayBill['book_add_date']                 = getDay();
        $arrayBill['book_add_time']                 = getTime();
        /******************************************************/
        //
        //$arrayLayoutPrice   = $arrayPostValue['layout_price'];
        //$arrayExtraBedPrice = $arrayPostValue['extra_bed_price'];
        //加房
        $arrayExtraBed = isset($arrayPostValue['extra_bed']) ? $arrayPostValue['extra_bed'] : null;
        //根据房间插入不同的房间
        $arraybatchInsert = array();
        $arraybatchInsertValue = array();
        $arrayRoomLayoutRoomHash = array();
        $first = true;
        $i = 0;
        //room_layout_id[6-19-1][18] [sell_id-room_layout-system_id][room]
        foreach($arrayPostValue['room_layout_id'] as $roomLayoutSystem => $arrayRoom) {
            $arrayLayoutSystem = explode('-', $roomLayoutSystem);
            $sell_id = $arrayLayoutSystem[0];
            $room_layout_id = $arrayLayoutSystem[1];
            $system_id = $arrayLayoutSystem[2];
            foreach($arrayRoom as $k => $room_id) {
                //$room_id = $arrayRoom[0];
                $arrayRoomLayoutRoomHash[$room_id] = $room_layout_id;
                //第一个个设为主订单
                if($first) {
                    $arrayBill['book_order_number_main'] = '1';//主订单号
                    $arrayBill['room_sell_layout_id'] = $sell_id;
                    $arrayBill['room_layout_id'] = $room_layout_id;
                    $arrayBill['room_id'] = $room_id;
                    $arrayBill['room_layout_price_system_id'] = $system_id;
                    $arrayBill['book_room_extra_bed']    = '';
                    if(isset($arrayExtraBed[$sell_id.'-'.$room_layout_id.'-'.$system_id][$room_id])) {
                        $arrayBill['book_room_extra_bed'] = $arrayExtraBed[$sell_id.'-'.$room_layout_id.'-'.$system_id][$room_id];
                    }
                    $arrayBill['book_cash_pledge'] = 0;
                    if(isset($arrayThenRoomPrice['pledge'][$sell_id.'-'.$room_layout_id.'-'.$system_id])) {
                        $arrayBill['book_cash_pledge'] = $arrayThenRoomPrice['pledge'][$sell_id.'-'.$room_layout_id.'-'.$system_id];
                    }
                    $first = false;
                } else {
                    $arraybatchInsertValue[$i - 1]['book_order_number_main'] = '0';//主订单号
                    $arraybatchInsertValue[$i - 1]['room_sell_layout_id'] = $sell_id;
                    $arraybatchInsertValue[$i - 1]['room_layout_id'] = $room_layout_id;
                    $arraybatchInsertValue[$i - 1]['room_id'] = $room_id;
                    $arraybatchInsertValue[$i - 1]['room_layout_price_system_id'] = $system_id;
                    $arraybatchInsertValue[$i - 1]['book_room_extra_bed'] = '';
                    //$arraybatchInsertValue['book_room_sell_layout_price'] = '';//check-in ~ check-out房间总价
                    if(isset($arrayExtraBed[$sell_id.'-'.$room_layout_id.'-'.$system_id][$room_id])) {
                        $arraybatchInsertValue[$i - 1]['book_room_extra_bed'] = $arrayExtraBed[$sell_id.'-'.$room_layout_id.'-'.$system_id][$room_id];
                    }
                    $arraybatchInsertValue[$i - 1]['book_cash_pledge'] = '0';
                    if(isset($arrayThenRoomPrice['pledge'][$sell_id.'-'.$room_layout_id.'-'.$system_id])) {
                        $arraybatchInsertValue[$i - 1]['book_cash_pledge'] = $arrayThenRoomPrice['pledge'][$sell_id.'-'.$room_layout_id.'-'.$system_id];
                    }
                }
                $i++;
            }
            //foreach($arrayRoom as $layout_system => $room_id) {
            //}
        }

        //事务开启
        BookDao::instance()->startTransaction();
        $book_id = BookService::instance()->saveBook($arrayBill);
        $book_order_number = \Utilities::getOrderNumber($book_id);
        BookService::instance()->updateBook(array('book_id'=>$book_id), array('book_order_number'=>$book_order_number));
        if(!empty($arraybatchInsertValue)) {
            foreach($arraybatchInsertValue as $k => $v) {
                $arraybatchInsert[$k] = $arrayBill;
                $arraybatchInsert[$k]['book_order_number']   = $book_order_number;
                $arraybatchInsert[$k]['room_sell_layout_id'] = $v['room_sell_layout_id'];
                $arraybatchInsert[$k]['room_layout_id']      = $v['room_layout_id'];
                $arraybatchInsert[$k]['room_id']             = $v['room_id'];
                $arraybatchInsert[$k]['room_layout_price_system_id'] = $v['room_layout_price_system_id'];
                //$arraybatchInsert[$k]['book_room_sell_layout_price'] = $v['book_room_sell_layout_price'];//check-in ~ check-out房间总价
                $arraybatchInsert[$k]['book_room_extra_bed'] = $v['book_room_extra_bed'];
                $arraybatchInsert[$k]['book_cash_pledge']    = $v['book_cash_pledge'];
            }
        }
        if(!empty($arraybatchInsert)) BookDao::instance()->setTable('book')->batchInsert($arraybatchInsert);

        //添加住客
        $arrayBookUserData = array();
        foreach($arrayPostValue['user_name'] as $i => $bookUser) {
            if(!empty($bookUser) && !empty($arrayPostValue['user_id_card'][$i])) {
                $arrayBookUserData[$i]['book_id'] = $book_id;
                $arrayBookUserData[$i]['hotel_id'] = $hotel_id;
                $arrayBookUserData[$i]['book_user_name'] = $bookUser;
                $arrayBookUserData[$i]['book_order_number'] = $book_order_number;
                $arrayBookUserData[$i]['book_user_id_card'] = $arrayPostValue['user_id_card'][$i];
                $arrayBookUserData[$i]['book_user_id_card_type'] = $arrayPostValue['user_id_card_type'][$i];
                $arrayBookUserData[$i]['room_layout_id'] = '';//$arrayRoomLayoutRoomHash[$arrayPostValue['book_user_room'][$i]];
                $arrayBookUserData[$i]['room_id'] = $arrayPostValue['user_room'][$i];
                $arrayBookUserData[$i]['book_user_sex'] = $arrayPostValue['user_sex'][$i];
                $arrayBookUserData[$i]['book_user_comments'] = $arrayPostValue['user_comments'][$i];
                $arrayBookUserData[$i]['book_check_in'] = $arrayPostValue['book_check_in'];
                $arrayBookUserData[$i]['book_check_out'] = $arrayPostValue['book_check_out'];
                $arrayBookUserData[$i]['book_add_date'] = getDay();
                $arrayBookUserData[$i]['book_add_time'] =getTime();
            }
        }
        if(!empty($arrayBookUserData)) BookDao::instance()->setTable('book_user')->batchInsert($arrayBookUserData);

        //房价数据
        $arraySameYearAndMonth = '';
        foreach($arrayThenRoomPrice['room'] as $roomLayoutSystem => $arrayDatePrice) {
            $arrayLayoutSystem = explode('-', $roomLayoutSystem);
            $sell_id = $arrayLayoutSystem[0];
            $room_layout_id = $arrayLayoutSystem[1];
            $system_id = $arrayLayoutSystem[2];
            foreach($arrayDatePrice as $date => $roomPrice) {
                $arrayDate = explode('-', $date);
                $year = $arrayDate[0]; $month = trim($arrayDate[1] - 0); $day = $arrayDate[2];
                if(isset($arraySameYearAndMonth[$year . '-' . $month])) {
                    $arraySameYearAndMonth[$year . '-' . $month][$day . '_day'] = $roomPrice;
                } else {
                    for($i = 1; $i <= 31; $i++) {
                        $i_day = $i < 10 ? '0' . $i : $i;
                        $arraySameYearAndMonth[$year . '-' . $month][$i_day . '_day'] = '0';
                    }
                    $arraySameYearAndMonth[$year . '-' . $month][$day . '_day'] = $roomPrice;
                    $arraySameYearAndMonth[$year . '-' . $month]['book_order_number'] = $book_order_number;
                    $arraySameYearAndMonth[$year . '-' . $month]['book_id'] = $book_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_sell_layout_id'] = $sell_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_id'] = $room_layout_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['hotel_id'] = $hotel_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_price_system_id'] = $system_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_date_year'] = $year;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_date_month'] = $month;
                }
            }
        }
        if(!empty($arraySameYearAndMonth)) BookDao::instance()->setTable('book_room_price')->batchInsert($arraySameYearAndMonth);
        //加床价格数据
        $arraySameYearAndMonth = '';
        foreach($arrayThenRoomPrice['bed'] as $roomLayoutSystem => $arrayDatePrice) {
            $arrayLayoutSystem = explode('-', $roomLayoutSystem);
            $sell_id = $arrayLayoutSystem[0];
            $room_layout_id = $arrayLayoutSystem[1];
            $system_id = $arrayLayoutSystem[2];
            foreach($arrayDatePrice as $date => $bedPrice) {
                $arrayDate = explode('-', $date);
                $year = $arrayDate[0]; $month = trim($arrayDate[1] - 0); $day = $arrayDate[2];
                if(isset($arraySameYearAndMonth[$year . '-' . $month])) {
                    $arraySameYearAndMonth[$year . '-' . $month][$day . '_day'] = $bedPrice;
                } else {
                    for($i = 1; $i <= 31; $i++) {
                        $i_day = $i < 10 ? '0' . $i : $i;
                        $arraySameYearAndMonth[$year . '-' . $month][$i_day . '_day'] = '0';
                    }
                    $arraySameYearAndMonth[$year . '-' . $month][$day . '_day'] = $bedPrice;
                    $arraySameYearAndMonth[$year . '-' . $month]['book_order_number'] = $book_order_number;
                    $arraySameYearAndMonth[$year . '-' . $month]['book_id'] = $book_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_sell_layout_id'] = $sell_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_id'] = $room_layout_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['hotel_id'] = $hotel_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_price_system_id'] = $system_id;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_date_year'] = $year;
                    $arraySameYearAndMonth[$year . '-' . $month]['room_layout_date_month'] = $month;
                }
            }
        }
        if(!empty($arraySameYearAndMonth)) BookDao::instance()->setTable('book_room_extra_bed_price')->batchInsert($arraySameYearAndMonth);
        //服务 service
        $arrayServiceData = '';
        foreach($arrayThenRoomPrice['service'] as $service_id => $price) {
            $arrayService = explode('-', $price);
            $arrayServiceData[$service_id]['book_order_number'] = $book_order_number;
            $arrayServiceData[$service_id]['book_id'] = $book_id;
            $arrayServiceData[$service_id]['hotel_id'] = $hotel_id;
            $arrayServiceData[$service_id]['hotel_service_id'] = $service_id;
            $arrayServiceData[$service_id]['hotel_service_price'] = $arrayService[0];
            $arrayServiceData[$service_id]['book_hotel_service_num'] = $arrayService[1];
            $arrayServiceData[$service_id]['book_hotel_service_discount'] = $arrayService[2];
        }
        if(!empty($arrayThenRoomPrice)) BookDao::instance()->setTable('book_hotel_service')->batchInsert($arrayServiceData);
        BookDao::instance()->commit();
        return $book_order_number;
    }

    public function getBookInfo($objRequest, $objResponse) {
        $thisDay = $objRequest -> time_begin;
        $toDay = $objRequest -> time_end;
        $thisDay = empty($thisDay) ? getDay() : $thisDay;
        $toDay = empty($toDay) ? getDay(7*24) : $toDay;
        $user_name = $objRequest -> user_name;

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
            '>='=>array('book_check_in'=>$thisDay));//'<='=>array('book_check_out'=>$toDay)
        if(!empty($user_name)) {
            $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                '>='=>array('book_check_in'=>$thisDay),
                'LIKE'=>array('book_contact_name'=>$user_name));//'<='=>array('book_check_out'=>$toDay)
        }
        $conditions['order'] = 'book_check_in ASC, book_order_number ASC, book_order_number_main DESC';
        $arrayBookInfo = BookService::instance()->getBook($conditions);
        $arrayBookList = array();
        if(!empty($arrayBookInfo)) {
            foreach($arrayBookInfo as $i => $arrayBook) {
                $arrayBook['edit_url'] =
                    \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['edit']),'order_number'=>encode($arrayBook['book_order_number'])));
                if($arrayBook['book_order_number_main'] == '1') {
                    $arrayBookList[$arrayBook['book_order_number']]['number_main'] = $arrayBook;
                    $arrayBookList[$arrayBook['book_order_number']]['child'][] = $arrayBook;
                } else {
                    $arrayBookList[$arrayBook['book_order_number']]['child'][] = $arrayBook;

                }
                if(isset($arrayBookList[$arrayBook['book_order_number']]['room_num'])) {
                    $arrayBookList[$arrayBook['book_order_number']]['room_num'] = $arrayBookList[$arrayBook['book_order_number']]['room_num'] + 1;
                } else {
                    $arrayBookList[$arrayBook['book_order_number']]['room_num'] = 1;
                }
            }
        }
        sort($arrayBookList);
        //
        $objResponse -> arrayBookList = $arrayBookList;
        $objResponse -> thisYear = getYear();
        $objResponse -> thisMonth = getMonth();
        $objResponse -> thisDay = $thisDay;
        $objResponse -> toDay = $toDay;
        $objResponse -> user_name = $user_name;
    }

    public function getHaveCheckInRoom($conditions, $hotel_id, $book_check_in, $book_check_out) {
        //step1 {begin} 取得已住房间
        //$hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions['where'] = "hotel_id = '".$hotel_id."' AND book_order_number_status >= 0 AND "
            ."(book_check_in <= '".$book_check_in."' AND '".$book_check_in."' < book_check_out) "
            ."OR ('".$book_check_in."' <= book_check_in AND book_check_in < '".$book_check_out."')";
        $arrayISBookRoomLayout = BookService::instance()->getBook($conditions, 'room_id, room_layout_id');
        /************************************************************************************************/
        $arrayRoomId = array();
        if(!empty($arrayISBookRoomLayout)) {
            foreach($arrayISBookRoomLayout as $k => $v) {
                $arrayRoomId[] = $v['room_id'];
            }
        }
        //step1 {end} 取得已住房间
        return $arrayRoomId;
    }

    public function searchISBookRoomLayout($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        $book_check_in = $objRequest -> book_check_in;
        $book_check_out = $objRequest -> book_check_out;
        $max_check_out = $objRequest -> max_check_out;
        $arrayBookCheckIn = explode('-', $book_check_in);
        $arrayBookCheckOut = explode('-', $book_check_out);
        $arrayBookMaxCheckOut = explode('-', $max_check_out);
        $hotel_service = $objRequest -> hotel_service;
        $hotel_service = trim($hotel_service, ',');
        if(empty($hotel_service)) {
            return '';
        }
        //step1 {begin} 取得已住房间
        /*$hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions['where'] = "hotel_id = '".$hotel_id."' AND book_order_number_status >= 0 AND "
                                          ."(book_check_in <= '".$book_check_in."' AND '".$book_check_in."' < book_check_out) "
                                          ."OR ('".$book_check_in."' <= book_check_in AND book_check_in < '".$book_check_out."')";
        $arrayISBookRoomLayout = BookService::instance()->getBook($conditions, 'room_id, room_layout_id');

        $arrayRoomId = array();
        if(!empty($arrayISBookRoomLayout)) {
            foreach($arrayISBookRoomLayout as $k => $v) {
                $arrayRoomId[] = $v['room_id'];
            }
        }*/
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $arrayRoomId = $this->getHaveCheckInRoom($conditions, $hotel_id, $book_check_in, $book_check_out);
        //step1 {end} 取得已住房间

        //{begin} 取得未住的房间和房型
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        if(!empty($arrayRoomId))
            $conditions['where'] = array('hotel_id'=>$hotel_id,
                                         'NOT IN'=>array('room_id'=>$arrayRoomId));
        $arrayRoomLayoutRoom = RoomService::instance()->getRoomLayoutRoom($conditions,
            'room_layout_id,room_id,room_layout_room_extra_bed,room_layout_room_max_people max_people,room_layout_room_max_children max_children','room_layout_id',true);
        /************************************************************************************************/
        //$arrayRoomLayoutId[0] = 0;
        $arrayRoomLayoutId = $arrayRoomSellLayoutId = $arrayRoomSellLayout = $arraySellLayout = '';
        $roomLayoutPriceSystem = $arrayLayoutPrice = $arrayLayoutExtraBedPrice = '';
        $arrayBookPriceSystem['room'] = $arrayRoomLayoutRoom;
        if(!empty($arrayRoomLayoutRoom)) {
            //查找售卖房型
            $conditions['where'] = array('hotel_id'=>$hotel_id,'room_sell_layout_valid'=>1);
            $arrayRoomSellLayout = RoomService::instance()->getRoomSellLayout($conditions,
                'room_sell_layout_id, room_layout_id, room_sell_layout_name', 'room_layout_id', true);
            /************************************************************************************************/
            foreach($arrayRoomLayoutRoom as $room_layout_id => $value) {
                if(isset($arrayRoomSellLayout[$room_layout_id])) {
                    $arrayRoomLayoutId[$room_layout_id] = $room_layout_id;//这个房型正在售卖才算数
                    foreach($arrayRoomSellLayout[$room_layout_id] as $i => $arraySellLayout) {
                        $arrayRoomSellLayoutId[$arraySellLayout['room_sell_layout_id']] = $arraySellLayout['room_sell_layout_id'];
                        //$arraySellLayout[$arraySellLayout['room_sell_layout_id']] = $arraySellLayout;
                    }
                }
            }
            foreach($arrayRoomSellLayout as $room_layout_id => $arrayValues) {
                foreach($arrayValues as $i => $arrayItem) {
                    $arraySellLayout[$arrayItem['room_sell_layout_id']] = $arrayItem;
                }
            }
            //{begin} 根据hotel_server_id查找价格体系
            $arrayRoomLayoutPriceSystemId = '';
            $base_price_system = 0;
            if(strpos($hotel_service, '-1') !== false) {//单是基本房价
                $base_price_system = 1;
                $hotel_service = str_replace('-1','',$hotel_service);
                $hotel_service = str_replace(',,',',',$hotel_service);
                $hotel_service = trim($hotel_service, ',');
            }
            $hotel_service = str_replace(',',"','",$hotel_service);

            if(!empty($hotel_service)) {
                $conditions['where'] = array('rsf.hotel_id'=>$hotel_id, 'rs.`room_layout_price_system_valid`'=>1,
                                             'IN'=>array('rsf.hotel_service_id'=>$hotel_service));

                $table = '`room_layout_price_system_filter` rsf LEFT JOIN `room_layout_price_system` rs ON rs.`room_layout_price_system_id` = rsf.`room_layout_price_system_id`';
                $field = 'DISTINCT(rs.`room_layout_price_system_id`),rs.`room_layout_price_system_name`';
                $conditions['order'] = 'rs.`room_sell_layout_id`';
                $roomLayoutPriceSystem = RoomDao::instance()->setTable($table)->getList($conditions, $field, 'room_layout_price_system_id');
                /************************************************************************************************/
                $conditions['order'] = '';
            }
            if($base_price_system == 1) {
                $roomLayoutPriceSystem[1]['room_layout_price_system_id'] = 1;
                $roomLayoutPriceSystem[1]['room_layout_price_system_name'] = $objResponse->arrayLaguage['base_room_price']['page_laguage_value'];
            }
            if(!empty($roomLayoutPriceSystem)) {
                foreach($roomLayoutPriceSystem as $room_layout_price_system_id => $arrayValue) {
                    $arrayRoomLayoutPriceSystemId[] = $room_layout_price_system_id;
                }
            }

            //{end}
            //{begin} 查找房型房价
            $conditions['where'] = array('hotel_id'=>$hotel_id,
                '>='=>array('room_layout_price_begin_datetime'=>$arrayBookCheckIn[0] . '-' . $arrayBookCheckIn[1] . '-01'),
                '<='=>array('room_layout_price_begin_datetime'=>$arrayBookMaxCheckOut[0] . '-' . $arrayBookMaxCheckOut[1] . '-28'),
                'IN'=>array('room_sell_layout_id'=>$arrayRoomSellLayoutId,'room_layout_price_system_id'=>$arrayRoomLayoutPriceSystemId));
            $fieid = 'room_layout_price_id, room_sell_layout_id sell_layout_id, room_layout_price_system_id,room_layout_price_begin_datetime,'
                    .'room_layout_date_year this_year,room_layout_date_month this_month,';
            for($i = 1; $i <= 31; $i++) {
                $day = $i < 10 ? '0' . $i . '_day,' : $i . '_day,';
                $fieid .= $day;
            }
            $fieid = trim($fieid, ',');
            $conditions['order'] = 'room_layout_id ASC, room_layout_price_system_id ASC';
            $arrayLayoutPrice = RoomService::instance()->getRoomLayoutPrice($conditions, $fieid);
            /************************************************************************************************/
            //{end} 查找房型房价
            //加床房价
            $fieid = 'room_sell_layout_id sell_layout_id, room_layout_id, room_layout_price_system_id,room_layout_price_begin_datetime,room_layout_date_year this_year,room_layout_date_month this_month,';
            for($i = 1; $i <= 31; $i++) {
                $day = $i < 10 ? '0' . $i . '_day,' : $i . '_day,';
                $fieid .= $day;
            }
            $fieid = trim($fieid, ',');
            $arrayLayoutExtraBedPrice = RoomService::instance()->getRoomLayoutExtraBedPrice($conditions, $fieid);
            /************************************************************************************************/
            $conditions['order'] = '';

        }
        //$conditions['where'] = array('hotel_id'=>$hotel_id,'room_layout_valid'=>1);
        //$fieid = 'room_layout_id,room_layout_name,room_layout_max_people max_people,room_layout_max_children max_children,room_layout_orientations';
        //$arrayRoomLayout = RoomService::instance()->getRoomLayout($conditions, $fieid, 'room_layout_id');
        $arrayBookPriceSystem['layoutPrice'] = $arrayLayoutPrice;
        $arrayBookPriceSystem['priceSystem'] = $roomLayoutPriceSystem;
        $arrayBookPriceSystem['roomSellLayout'] = $arraySellLayout;
        $arrayBookPriceSystem['extraBedPrice'] = $arrayLayoutExtraBedPrice;
        return $arrayBookPriceSystem;


        /*$conditions['where'] = array('rl.hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
            'NOT IN'=>array('rlr.room_id'=>$arrayRoomId));
        $conditions['group'] = 'rlp.`room_layout_id`';
        $table = "`room_layout_room` rlr LEFT JOIN `room_layout` rl ON rlr.`room_layout_id` = rl.room_layout_id "
            ."LEFT JOIN `room_layout_price` rlp ON rlp.`room_layout_id` = rlr.`room_layout_id` AND rlp.`room_layout_price_is_active` = '1'";
        $fieid = 'COUNT(rlp.`room_layout_id`) room_layout_num, rlp.`room_layout_price`, rlp.room_layout_extra_bed_price, rl.*';//rlr.`room_id`*/
        //return BookDao::instance()->setTable($table)->getList($conditions, $fieid);
    }

    public function searchISBookRoom($objRequest, $objResponse) {

    }

}