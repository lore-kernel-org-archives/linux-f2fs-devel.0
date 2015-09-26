From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Sat, 26 Sep 2015 05:42:17 +0200
Message-ID: <20150926034217.GA4645@schmorp.de>
References: <20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<011201d0f5dd$c3a4f650$4aeee2f0$@samsung.com>
	<20150923233022.GD3463@schmorp.de>
	<01bc01d0f769$15c05f60$41411e20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfgNX-0007uF-7X
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 03:42:27 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfgNV-0003ft-9T
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 03:42:27 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZfgNN-0003jE-Qm
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 03:42:18 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZfgNN-00038M-Lo
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 03:42:17 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZfgNN-0001HP-LE
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:42:17 +0200
Content-Disposition: inline
In-Reply-To: <01bc01d0f769$15c05f60$41411e20$@samsung.com>
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

On Fri, Sep 25, 2015 at 04:05:48PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> Actually, we should set the value of 'count' parameter to indicate how many
> times we want to do gc in one batch, at most 16 times in a loop for each
> ioctl invoking:
>         ioctl(fd, F2FS_IOC_GC, &count);
> After ioctl retruned successfully, 'count' parameter will contain the count
> of gces we did actually.

Ah, so this way, I could even find out when to stop.

> One batch means a certain number of gces excuting serially.

Thanks for the explanation - well, I guess there is no harm in setting
count to 1 and calling it repeatedly, as GC operations should generally be
slow enough so many repeated calls will be ok.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
