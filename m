From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Sat, 26 Sep 2015 07:57:09 +0200
Message-ID: <20150926055709.GA2387@schmorp.de>
References: <20150925182646.GB6998@jaegeuk-mac02>
	<20150925182646.GB6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfiU2-0001T6-1H
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:57:18 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfiU1-0002jU-3M
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:57:18 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZfiTu-0007em-Sk
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:57:10 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZfiTt-0008S9-Gq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:57:09 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZfiTt-0000dH-GC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:57:09 +0200
Content-Disposition: inline
In-Reply-To: <20150926052551.GA2243@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

On Sat, Sep 26, 2015 at 07:25:51AM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> Just for fun I'll start doing a -s64 run.

Same thing with -s64.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
