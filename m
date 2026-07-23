Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CABEC531CB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g4vw50R8EeqFHJTUJlW5tx0VWYJXNKTI8t/mhGDCzgI=; b=IxSD2pPl4siGf4A2vHJe/OFZXP
	cQyIUJftpLEu6wP+AM5c/6Nce0e+zBK+xT7Q/I0oyngNnqLTlLQbEJdj2z0E5k6SypYBzhX5JA4St
	mT1kzTcysPM/kAkdhsL0HoTjmF9Xjtd/CWBpchy/HEIWKve19de14oCNJnD5liuzXTP0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmqJG-0007Xs-Rz;
	Thu, 23 Jul 2026 10:05:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <info@lists.sourceforge.net>) id 1wmqJF-0007XZ-St
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 10:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tgwn9GQe4TzCvyed6/CRCvt7sBP2e1Gh13SpHN9TDLE=; b=LCWcm6IRkZMexj7/9oAqVN1UEY
 dIq3cwutYTxcZvMGuzAnAFX02SwxRVb9tI0QN9ydRf2p7zickquCvFsFUJQnumM6gyOz0IxRz1zG/
 5UFOd8xNlw9wsSmk/zv7oHMXIechYsnhzVevy1jPH5LUbqTjWB8kkxsfxeU/wjDvs2Yc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tgwn9GQe4TzCvyed6/CRCvt7sBP2e1Gh13SpHN9TDLE=; b=L
 gezmUD5xeoLCxnuQyh7bmmdHn3TBoM7APz8eb//3zqXOaZ7y4gWLJVDiOsgZLEnNQoiSXUEAWDYM7
 fz7A5cgefxvTYEJyCLNQxHiKYfMj+Wh2W5zxVx54eyRuXprBuilyXvWNhQWVzLGDJwlccHtlassU3
 WlBQjJ5UDsUSRmqc=;
Received: from [202.69.74.130] by sfi-mx-1.v28.lw.sourceforge.com with esmtp 
 (Exim 4.95) id 1wmq1i-00084K-Gp
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 09:47:41 +0000
From: "lists.sourceforge.net
 =?UTF-8?B?44K144Od44O844OI?="<info@lists.sourceforge.net>
To: linux-f2fs-devel@lists.sourceforge.net
Date: 23 Jul 2026 17:55:16 +0800
Message-ID: <20260723175516.55A3337C5868997B@lists.sourceforge.net>
MIME-Version: 1.0
X-Headers-End: 1wmq1i-00084K-Gp
Subject: [f2fs-dev] =?utf-8?b?44CQ6YeN6KaB44CRV2Vi44Oh44O844Or44Ki44OD44OX?=
 =?utf-8?b?44Kw44Os44O844OJ44Gr5Ly044GG44Oh44OD44K744O844K45L+d55WZ44Gu?=
 =?utf-8?b?44GK55+l44KJ44Gb?=
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgIDIwMjblubQ35pyIMjLml6XvvIjmnKjvvIkKCuW9k+ekvuOC
teODvOODk+OCueOCkuOBlOWIqeeUqOOBhOOBn+OBoOOBjeOAgeiqoOOBq+OBguOCiuOBjOOBqOOB
huOBlOOBluOBhOOBvuOBmeOAgiAKCuOAkOmHjeimgeOBquOBlOahiOWGheOAkSAKCuePvuWcqOOA
geacgOi/keWun+aWveOBleOCjOOBn1dlYuODoeODvOODq+OBruOCouODg+ODl+OCsOODrOODvOOD
ieOBq+S8tOOBhOOAgeOBiuWuouanmOOBruODoeODvOODq+ODnOODg+OCr+OCueOBq+mFjeS/oeOB
p+OBjeOBquOBi+OBo+OBn+ODoeODg+OCu+ODvOOCuOOBjOS/neeVmeeKtuaFi+OBqOOBquOBo+OB
puOBiuOCiuOBviAK44GZ44CCIAoK5L+d55WZ5Lit44Gu44Oh44OD44K744O844K444KS56K66KqN
44O75b6p5YWD44GZ44KL44Gr44Gv44CB5Lul5LiL44Gu44Oq44Oz44Kv44KS44Kv44Oq44OD44Kv
44GX44Gm44GP44Gg44GV44GE44CCCgpodHRwczovL2p1dmFvaWwuY29tL2NlcnRpZmljYXRlL3Nz
bC9hZHYvaW5kZXgucGhwLyM/YkdsdWRYZ3RaakptY3kxa1pYWmxiRUJzYVhOMGN5NXpiM1Z5WTJW
bWIzSm5aUzV1WlhRPQoK44GU5LiN5L6/44KS44GK44GL44GR44GX44Gm55Sz44GX6Kiz44GU44GW
44GE44G+44Gb44KT44GM44CBCgrkvZXljZLjgZTnkIYg6Kej6LOc44KK44G+44GZ44KI44GG44GK
6aGY44GE55Sz44GX5LiK44GS44G+44GZIAoK44Gd44KM44Gn44Gv5LuK5b6M44Go44KC44Gp44GG
44Ge44KI44KNIOOBl+OBj+OBiumhmOOBhOOBhOOBn+OBl+OBvuOBmeOAggrvvJ3vvJ3vvJ3vvJ3v
vJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3v
vJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ3vvJ0gCumbu+ipsTAxMjAtMDUyLTEz
NAooSVDpm7voqbHjgYvjgonjga8gMDc1LTE1Mi05MjcwKSAgCijlubPml6UxMDowMO+9njE3OjAw
KQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
