<?php
    
    error_reporting(-1); 
    ini_set("display_errors", 'On');
    ini_set("max_execute_time", '600');
    date_default_timezone_set('Europe/Moscow'); 

    session_start();
    header("Content-type: text/html; charset=utf-8");
    chdir('..');
    
    require_once('api/Simpla.php');
	
    function format_by_count($count, $form1, $form2, $form3)
    {
    	$count = abs($count) % 100;
    	$lcount = $count % 10;
    	if ($count >= 11 && $count <= 19) return($form3);
    	if ($lcount >= 2 && $lcount <= 4) return($form2);
    	if ($lcount == 1) return($form1);
    	return $form3;
    }
	
    
    $simpla = new Simpla();
	
    $cache_days = 30;
	$delivery = $simpla->delivery->get_delivery(4);
	
	if(!isset($_GET['weight']))
	{
		$cart = $simpla->cart->get_cart();
		$w = 0;
		$v = 0;
		$vol = 0;
		foreach ($cart->purchases as $purchase) 
		{
			$w += $purchase->variant->weight * $purchase->amount /1000;
			$v += $purchase->variant->price * $purchase->amount;
			$vol += $purchase->variant->volume * $purchase->amount;
		}
	}
	else
	{
		$w 	 = $_GET['weight']/1000;
		$vol = $_GET['volume'];
		$v 	 = $_GET['price'];
	}

	
    if ($track = $simpla->request->get('track', 'string'))
    {
        //Авторизация. Для получения логина/пароля (в т.ч. тестового) обратитесь к разработчикам СДЭК -->
            $simpla->CDEK->setAuth('GBOHXRpAbhNefcvBetFkl1LmZStR3z5B', '3s3qbCJwzrTds5TKBjVOHfgFXt1C7pvq'); // тестовые ключи
//        $simpla->CDEK->setAuth('d3ZbF5F1wXxTLKpj9xU9wWKBkuXU1wHV', '6s4QvINnVOzr7j49iCwL7BSxHyAZz0pO'); // рабочие ключи
    	
    	if ($simpla->CDEK->track($track) === true) {
    		$res = $simpla->CDEK->getResult();
    		$res['result']['price'] = $res['result']['price']+300;
echo $res;
exit;            
    
    /*
    		echo 'Цена доставки: ' . $res['result']['price'] . 'руб.<br />';
    		echo 'Срок доставки: ' . $res['result']['deliveryPeriodMin'] . '-' . 
    								 $res['result']['deliveryPeriodMax'] . ' дн.<br />';
    		echo 'Планируемая дата доставки: c ' . $res['result']['deliveryDateMin'] . ' по ' . $res['result']['deliveryDateMax'] . '.<br />';
    		echo 'id тарифа, по которому произведён расчёт: ' . $res['result']['tariffId'] . '.<br />';
            if(array_key_exists('cashOnDelivery', $res['result'])) {
                echo 'Ограничение оплаты наличными, от (руб): ' . $res['result']['cashOnDelivery'] . '.<br />';
            }
            */
     	} else {
    		$err = $simpla->CDEK->getError();
    		if( isset($err['error']) && !empty($err) ) {
    			//var_dump($err);
    			foreach($err['error'] as $e) {
//        				echo 'Код ошибки: ' . $e['code'] . '.<br />';
    				echo 'Текст ошибки: ' . $e['text'] . '.<br />';
    			}
    		}
    	}
    }
    
	if($code = $simpla->request->get('code'))
	{
        if ((time() - $cache_days*86400) > strtotime($simpla->settings->cdek_update))
        {
            $request_size = 1000;
            $request_page = 0;
            do 
            {
                $request_url = 'http://integration.cdek.ru/v1/location/cities/json?size='.$request_size.'&page='.$request_page;
                $json_response = file_get_contents($request_url);
                $response = json_decode($json_response);
//echo '<hr />'.__FILE__.':'.__LINE__.'<pre>'; var_dump($request_url); echo '</pre>';
                foreach ($response as $resp)
                {
                    if (!empty($resp->kladr))
                    {
                        $item = array(
                            'cityName' => trim($resp->cityName),
                            'cityCode' => trim($resp->cityCode),
                            'cityUuid' => trim($resp->cityName),
                            'region' => trim($resp->region),
                            'regionCode' => trim($resp->regionCode),
                            'regionCodeExt' => trim($resp->regionCodeExt),
                            'subRegion' => trim($resp->subRegion),
                            'latitude' => isset($resp->latitude) ? trim($resp->latitude) : '',
                            'longitude' => isset($resp->longitude) ? trim($resp->longitude) : '',
                            'kladr' => trim($resp->kladr),
                            'fiasGuid' => trim($resp->fiasGuid),
                        );
                        $query = $simpla->db->placehold("INSERT INTO __cdek SET ?%", $item);
                        $simpla->db->query($query);
                    }
                }
                
                $request_page++;
                // записываем дату запроса
                $simpla->settings->cdek_update = date('c');
                
            } while (!empty($response));
        }
        
        $query = $simpla->db->placehold("SELECT cityCode FROM __cdek WHERE kladr = ?", $code);
        $simpla->db->query($query);
        
        if (!($cityCode = $simpla->db->result('cityCode')))
        {
            $cityUuid = $simpla->request->get('id');
            $region = $simpla->request->get('reg_name');
            $query = $simpla->db->placehold("SELECT cityCode FROM __cdek WHERE cityUuid = ? AND region = ?", $cityUuid, $region);
            $simpla->db->query($query);
            
            $cityCode = $simpla->db->result('cityCode');
        }
        
        if (!empty($cityCode))
        {
            //Авторизация. Для получения логина/пароля (в т.ч. тестового) обратитесь к разработчикам СДЭК -->
//            $simpla->CDEK->setAuth('GBOHXRpAbhNefcvBetFkl1LmZStR3z5B', '3s3qbCJwzrTds5TKBjVOHfgFXt1C7pvq'); // тестовые ключи
            $simpla->CDEK->setAuth('d3ZbF5F1wXxTLKpj9xU9wWKBkuXU1wHV', '6s4QvINnVOzr7j49iCwL7BSxHyAZz0pO'); // рабочие ключи
            //устанавливаем город-отправитель 250-Екатеринбург
        	$simpla->CDEK->setSenderCityId(250);
        	//устанавливаем город-получатель
        	$simpla->CDEK->setReceiverCityId($cityCode);
        	//устанавливаем дату планируемой отправки
        //	$simpla->CDEK->setDateExecute($_REQUEST['dateExecute']);
        	
        	//задаём список тарифов с приоритетами
            $simpla->CDEK->addTariffPriority(139);
            $simpla->CDEK->addTariffPriority(1);
        	
        	//устанавливаем тариф по-умолчанию 139:дверь-дверь
        	//$simpla->CDEK->setTariffId('1');
        		
        	//устанавливаем режим доставки 
        	$simpla->CDEK->setModeDeliveryId(1);
        	//добавляем места в отправление
        	$simpla->CDEK->addGoodsItemByVolume($w, $vol);
        	
        	if ($simpla->CDEK->calculate() === true) {
        		$res = $simpla->CDEK->getResult();
        		
                
                $answ ='
            <ul>
                <li class="courier_li" style="display: flex;">
                    <input type="hidden" id="cdek_price" value="'.($res['result']['price']+300).'" />
                    <label for="del_subtipeДоДвери" class="subdel" style="display: flex;">
                        <div class="del_descr">
                            До двери(';
       	$answ.=             $res['result']['deliveryPeriodMin'].'-'.$res['result']['deliveryPeriodMax'].' '.format_by_count($res['result']['deliveryPeriodMax'], 'день', 'дня', 'дней');
		$answ.=             ')
                        </div>
                        <div class="pull-right">
                            '.(isset($res['result']['price'])?round($res['result']['price']+300).' руб':'Ошибка.').'
                        </div>
                    </label>
                </li>
            </ul>
        ';
        echo $answ;
        
        /*
        		echo 'Цена доставки: ' . $res['result']['price'] . 'руб.<br />';
        		echo 'Срок доставки: ' . $res['result']['deliveryPeriodMin'] . '-' . 
        								 $res['result']['deliveryPeriodMax'] . ' дн.<br />';
        		echo 'Планируемая дата доставки: c ' . $res['result']['deliveryDateMin'] . ' по ' . $res['result']['deliveryDateMax'] . '.<br />';
        		echo 'id тарифа, по которому произведён расчёт: ' . $res['result']['tariffId'] . '.<br />';
                if(array_key_exists('cashOnDelivery', $res['result'])) {
                    echo 'Ограничение оплаты наличными, от (руб): ' . $res['result']['cashOnDelivery'] . '.<br />';
                }
                */
         	} else {
        		$err = $simpla->CDEK->getError();
        		if( isset($err['error']) && !empty($err) ) {
        			//var_dump($err);
        			foreach($err['error'] as $e) {
//        				echo 'Код ошибки: ' . $e['code'] . '.<br />';
        				echo 'Текст ошибки: ' . $e['text'] . '.<br />';
        			}
        		}
        	}
        }
        else
        {
            echo 'Доставка по этому направлению невозможна';
        }

}

	
