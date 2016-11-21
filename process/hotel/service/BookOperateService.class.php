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
        //print_r($_REQUEST);exit();
        $arrayPostValue = $objRequest->getPost();
        $payment = $arrayPostValue['payment'];//支付 类型
        $payment_type = $arrayPostValue['payment_type'];//支付方式  微信支付宝等
        $is_pay = $arrayPostValue['is_pay'];//付款已到账
        //联系信息
        $arrayBill['book_contact_name']             = $arrayPostValue['book_contact_name'];//联系人
        $arrayBill['book_contact_mobile']           = $arrayPostValue['book_contact_mobile'];//联系人移动电话
        $arrayBill['user_id']                       = '';////
        $arrayBill['hotel_id']                      = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        //来源
        $arrayBill['book_type_id']                  = $arrayPostValue['book_type_id'];
        $arrayBill['book_discount']                 = $arrayPostValue['book_discount'];//实际折扣
        $arrayBill['book_discount_id']              = $arrayPostValue['book_discount_id'];//折扣ID
        $arrayBill['book_discount_describe']        = $arrayPostValue['book_discount_describe'];//折扣描述
        //入住日期
        $arrayBill['book_check_in']                = $arrayPostValue['book_check_in'];//入住时间
        $arrayBill['book_check_out']                = $arrayPostValue['book_check_out'];//退房时间
        $arrayBill['book_order_retention_time']     = $arrayPostValue['book_order_retention_time'];//订单保留时间
        //主订单
        $arrayBill['book_order_number_main']        = '0';//主订单号
        $arrayBill['book_order_number']             = 1;//订单号
        //
        $arrayBill['book_order_number_status']      = '0';//订单状态 -1 失效 0预定成功 1入住 2退房完成
        //
        $arrayBill['book_total_price']              = $arrayPostValue['book_total_price'];//计算支付总价
        //预付
        $arrayBill['book_prepayment_price']         = $arrayPostValue['book_prepayment_price'];//预付费
        if($payment == 1) {
            $arrayBill['book_is_prepayment']        = $is_pay;//是否已支付预付费
            if($is_pay == 1) {
                $arrayBill['book_prepayment_date']  = getDateTime();//预付费支付时间
            }
            $arrayBill['prepayment_type_id']        = $payment_type;//预付 支付方式  微信支付宝等
        }

        $arrayBill['book_prepayment_account']       = '';//预付支付帐号
        //全额支付
        if($payment == 3) {
            $arrayBill['book_is_pay']               = '1';//是否已经全额支付房费
            $arrayBill['payment_type_id']           = $payment_type;//预付 支付方式  微信支付宝等
        }
        $arrayBill['book_payment_voucher']          = $arrayPostValue['book_payment_voucher'];//付款凭证
        //时间
        $arrayBill['book_add_date']                 = getDay();
        $arrayBill['book_add_time']                 = getTime();
        $arrayLayoutPrice   = $arrayPostValue['layout_price'];
        $arrayExtraBedPrice = $arrayPostValue['extra_bed_price'];
        $arrayExtraBed = isset($arrayPostValue['extra_bed']) ? $arrayPostValue['extra_bed'] : null;
        //根据房间插入不同的房间
        $arraybatchInsert = array();
        $arraybatchInsertValue = array();
        $arrayRoomLayoutRoomHash = array();
        $first = true;
        $i = 0;
        foreach($arrayPostValue['room_layout_id'] as $room_layout_id => $arrayRoom) {
            foreach($arrayRoom as $layout_system => $room_id) {
                $arrayLayoutSystem = explode('-', $layout_system);
                $system_id = $arrayLayoutSystem[0];$room_id = $arrayLayoutSystem[1];
                $arrayRoomLayoutRoomHash[$room_id] = $room_layout_id;
                //第一个个设为主订单
                if($first) {
                    $arrayBill['book_order_number_main'] = '1';//主订单号
                    $arrayBill['room_layout_id'] = $room_layout_id;
                    $arrayBill['room_id'] = $room_id;
                    $arrayBill['room_layout_price_system_id'] = $system_id;
                    $arrayBill['book_room_layout_price'] = $arrayLayoutPrice[$room_layout_id];
                    $arrayBill['book_room_extra_bed']    = '';
                    $arrayBill['book_room_extra_bed_price'] = 0;
                    if(!empty($arrayExtraBed)) {
                        if(isset($arrayExtraBed[$room_layout_id][$room_id])) {
                            $arrayBill['book_room_extra_bed'] = $arrayExtraBed[$room_layout_id][$room_id];
                            $arrayBill['book_room_extra_bed_price'] = $arrayExtraBedPrice[$room_layout_id];
                        }
                    }
                    $first = false;
                } else {
                    $arraybatchInsertValue[$i - 1]['book_order_number_main'] = '0';//主订单号
                    $arraybatchInsertValue[$i - 1]['room_layout_id'] = $room_layout_id;
                    $arraybatchInsertValue[$i - 1]['room_id'] = $room_id;
                    $arraybatchInsertValue[$i - 1]['room_layout_price_system_id'] = $system_id;
                    $arraybatchInsertValue[$i - 1]['book_room_layout_price'] = $arrayLayoutPrice[$room_layout_id];
                    $arraybatchInsertValue[$i - 1]['book_room_extra_bed'] = '';
                    $arraybatchInsertValue[$i - 1]['book_room_extra_bed_price'] = 0;
                    if(isset($arrayExtraBed[$room_layout_id][$room_id])) {
                        $arraybatchInsertValue[$i - 1]['book_room_extra_bed'] = $arrayExtraBed[$room_layout_id][$room_id];
                        $arraybatchInsertValue[$i - 1]['book_room_extra_bed_price'] = $arrayExtraBedPrice[$room_layout_id];
                    }
                }
                $i++;
            }
        }

        //事务开启
        BookDao::instance()->startTransaction();
        $book_id = BookService::instance()->saveBook($arrayBill);
        $book_order_number = \Utilities::getOrderNumber($book_id);
        BookService::instance()->updateBook(array('book_id'=>$book_id), array('book_order_number'=>$book_order_number));
        if(!empty($arraybatchInsertValue)) {
            foreach($arraybatchInsertValue as $k => $v) {
                $arraybatchInsert[$k] = $arrayBill;
                $arraybatchInsert[$k]['book_order_number'] = $book_order_number;
                $arraybatchInsert[$k]['room_layout_id'] = $v['room_layout_id'];
                $arraybatchInsert[$k]['room_id'] = $v['room_id'];
                $arraybatchInsert[$k]['room_layout_price_system_id'] = $v['room_layout_price_system_id'];
                $arraybatchInsert[$k]['book_room_layout_price'] = $v['book_room_layout_price'];
                $arraybatchInsert[$k]['book_room_extra_bed'] = $v['book_room_extra_bed'];
                $arraybatchInsert[$k]['book_room_extra_bed_price'] = $v['book_room_extra_bed_price'];
            }
        }
        if(!empty($arraybatchInsert)) BookDao::instance()->setTable('book')->batchInsert($arraybatchInsert);

        //添加住客
        $arrayBookUserData = array();
        foreach($arrayPostValue['book_user_name'] as $i => $bookUser) {
            if(!empty($bookUser) && !empty($arrayPostValue['book_user_id_card'][$i])) {
                $arrayBookUserData[$i]['book_user_name'] = $bookUser;
                $arrayBookUserData[$i]['book_order_number'] = $book_order_number;
                $arrayBookUserData[$i]['book_user_id_card'] = $arrayPostValue['book_user_id_card'][$i];
                $arrayBookUserData[$i]['book_user_id_card_type'] = $arrayPostValue['book_user_id_card_type'][$i];
                $arrayBookUserData[$i]['room_layout_id'] = $arrayRoomLayoutRoomHash[$arrayPostValue['book_user_room'][$i]];
                $arrayBookUserData[$i]['room_id'] = $arrayPostValue['book_user_room'][$i];
                $arrayBookUserData[$i]['book_user_sex'] = $arrayPostValue['book_user_sex'][$i];
                $arrayBookUserData[$i]['book_check_in'] = $arrayPostValue['book_check_in'];
                $arrayBookUserData[$i]['book_check_out'] = $arrayPostValue['book_check_out'];
                $arrayBookUserData[$i]['book_add_date'] = getDay();
                $arrayBookUserData[$i]['book_add_time'] =getTime();
            }
        }
        if(!empty($arrayBookUserData)) BookDao::instance()->setTable('book_user')->batchInsert($arrayBookUserData);

        BookDao::instance()->commit();
        return $book_order_number;
    }

    public function getBookInfo($objRequest, $objResponse) {
        $thisDay = $objRequest -> time_begin;
        $toDay = $objRequest -> time_end;
        $thisDay = empty($thisDay) ? getDay() : $thisDay;
        $toDay = empty($toDay) ? getDay(7*24) : $toDay;

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
            '>='=>array('book_check_in'=>$thisDay),
            '<='=>array('book_check_out'=>$toDay));
        $conditions['order'] = 'book_check_in ASC, book_order_number ASC, book_order_number_main DESC';
        $arrayBookInfo = BookService::instance()->getBook($conditions);
        $arrayBookList = array();
        if(!empty($arrayBookInfo)) {
            foreach($arrayBookInfo as $i => $arrayBook) {
                if($arrayBook['book_order_number_main'] == '1') {
                    $arrayBookList[$arrayBook['book_order_number']] = $arrayBook;
                    $arrayBookList[$arrayBook['book_order_number']]['child'][] = $arrayBook;
                } else {
                    $arrayBookList[$arrayBook['book_order_number']]['child'][] = $arrayBook;
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
    }

    public function searchISBookRoomLayout($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        $book_check_in = $objRequest -> book_check_in;
        $book_check_out = $objRequest -> book_check_out;
        $arrayBookCheckIn = explode('-', $book_check_in);
        $arrayBookCheckOut = explode('-', $book_check_out);
        $hotel_service = $objRequest -> hotel_service;
        $hotel_service = trim($hotel_service, ',');
        if(empty($hotel_service)) {
            return ;
        }
        //step1 {begin} 取得已住房间
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions['where'] = "hotel_id = '".$hotel_id."' AND (book_check_in <= '".$book_check_in."' AND '".$book_check_in."' < book_check_out) "
                                                     ."OR ('".$book_check_in."' <= book_check_in AND book_check_in < '".$book_check_out."')";
        $arrayISBookRoomLayout = BookService::instance()->getBook($conditions, 'room_id, room_layout_id');
        $arrayRoomId = array();
        if(!empty($arrayISBookRoomLayout)) {
            foreach($arrayISBookRoomLayout as $k => $v) {
                $arrayRoomId[] = $v['room_id'];
            }
        }
        //step1 {end} 取得已住房间

        //{begin} 取得未住的房间和房型
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        if(!empty($arrayRoomId))
            $conditions['where'] = array('hotel_id'=>$hotel_id,
                                         'NOT IN'=>array('room_id'=>$arrayRoomId));
        $arrayRoomLayoutRoom = RoomService::instance()->getRoomLayoutRoom($conditions,
            'room_layout_id,room_id,room_layout_room_extra_bed, room_layout_room_max_people max_people, room_layout_room_max_children max_children', 'room_layout_id', true);
        //$arrayRoomLayoutId[0] = 0;
        $arrayRoomLayoutId = '';
        $roomLayoutPriceSystem = $arrayLayoutPrice = $arrayLayoutExtraBedPrice = '';
        $arrayBookPriceSystem['room'] = $arrayRoomLayoutRoom;
        if(!empty($arrayRoomLayoutRoom)) {
            foreach($arrayRoomLayoutRoom as $room_layout_id => $value) {
                $arrayRoomLayoutId[$room_layout_id] = $room_layout_id;
            }
            //{begin} 根据hotel_server_id查找价格体系
            $arrayRoomLayoutPriceSystemId = '';
            $base_price_system = 0;
            if(strpos($hotel_service, '-1') !== false) {//单是基本房价
                $base_price_system = 1;
                $hotel_service = str_replace('-1','',$hotel_service);
                $hotel_service = str_replace(',,',',',$hotel_service);
            }
            if(!empty($hotel_service)) {
                $conditions['where'] = array('rsf.hotel_id'=>$hotel_id, 'rs.`room_layout_price_system_valid`'=>1,
                                             'IN'=>array('rsf.hotel_service_id'=>$hotel_service));

                $table = '`room_layout_price_system_filter` rsf LEFT JOIN `room_layout_price_system` rs ON rs.`room_layout_price_system_id` = rsf.`room_layout_price_system_id`';
                $field = 'DISTINCT(rs.`room_layout_price_system_id`),rs.`room_layout_price_system_name`';
                $conditions['order'] = 'rs.`room_layout_id`';
                $roomLayoutPriceSystem = RoomDao::instance()->setTable($table)->getList($conditions, $field, 'room_layout_price_system_id');
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
                '<='=>array('room_layout_price_begin_datetime'=>$arrayBookCheckOut[0] . '-' . $arrayBookCheckOut[1] . '-28'),
                'IN'=>array('room_layout_id'=>$arrayRoomLayoutId,'room_layout_price_system_id'=>$arrayRoomLayoutPriceSystemId));
            $fieid = 'room_layout_price_id, room_layout_id, room_layout_price_system_id,room_layout_price_begin_datetime,room_layout_date_year this_year,room_layout_date_month this_month,';
            for($i = 1; $i <= 31; $i++) {
                $day = $i < 10 ? '0' . $i . '_day,' : $i . '_day,';
                $fieid .= $day;
            }
            $fieid = trim($fieid, ',');
            $conditions['order'] = 'room_layout_id ASC, room_layout_price_system_id ASC';
            $arrayLayoutPrice = RoomService::instance()->getRoomLayoutPrice($conditions, $fieid);
            //{end} 查找房型房价
            //加床房价
            $fieid = 'room_layout_id, room_layout_price_system_id,room_layout_price_begin_datetime,room_layout_date_year this_year,room_layout_date_month this_month,';
            for($i = 1; $i <= 31; $i++) {
                $day = $i < 10 ? '0' . $i . '_day,' : $i . '_day,';
                $fieid .= $day;
            }
            $fieid = trim($fieid, ',');
            $arrayLayoutExtraBedPrice = RoomService::instance()->getRoomLayoutExtraBedPrice($conditions, $fieid);
            $conditions['order'] = '';

        }
        $conditions['where'] = array('hotel_id'=>$hotel_id,'room_layout_valid'=>1);
        $fieid = 'room_layout_id,room_layout_name,room_layout_max_people max_people,room_layout_max_children max_children,room_layout_orientations';
        $arrayRoomLayout = RoomService::instance()->getRoomLayout($conditions, $fieid, 'room_layout_id');
        $arrayBookPriceSystem['layoutPrice'] = $arrayLayoutPrice;
        $arrayBookPriceSystem['priceSystem'] = $roomLayoutPriceSystem;
        $arrayBookPriceSystem['roomLayout'] = $arrayRoomLayout;
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

}