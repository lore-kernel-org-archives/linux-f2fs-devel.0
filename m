From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: 100% system time hang with git f2fs
Date: Fri, 2 Oct 2015 10:53:40 +0200
Message-ID: <20151002085340.GA3105@schmorp.de>
References: <01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
	<20150929110204.GA7608@schmorp.de>
	<20150929231310.GA6010@jaegeuk-mac02.mot.com>
	<20151001121120.GA7340@schmorp.de>
	<20151001185124.GA9803@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zhw68-0001Eg-AY
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Oct 2015 08:53:48 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zhw66-00022W-Se
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Oct 2015 08:53:48 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zhw60-0000ix-JR
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Oct 2015 08:53:40 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zhw60-0002gJ-Eh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Oct 2015 08:53:40 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zhw60-0000oh-E5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Oct 2015 10:53:40 +0200
Content-Disposition: inline
In-Reply-To: <20151001185124.GA9803@schmorp.de>
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

On Thu, Oct 01, 2015 at 08:51:24PM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> Ok, for completeness, here is the full log and a description of what was
> going on.

Ok, so I did a fsck, which took one hour, which is not very good, but I
don't use fsck very often. It didn't find any problems (everything Ok).

However, I have a freeze. When I mount the volume, start a du on it, and after
a while do:

   echo 3 >/proc/sys/vm/drop_caches

Then this process hangs with 100% sys time. /proc/../stack gives no usable
backtrace.

umount on the f2fs volume also hangs:

   [<ffffffff8139ba03>] call_rwsem_down_write_failed+0x13/0x20
   [<ffffffff8118086d>] unregister_shrinker+0x1d/0x70
   [<ffffffff811e7911>] deactivate_locked_super+0x41/0x60
   [<ffffffff811e7eee>] deactivate_super+0x4e/0x70
   [<ffffffff81204733>] cleanup_mnt+0x43/0x90
   [<ffffffff812047d2>] __cleanup_mnt+0x12/0x20
   [<ffffffff8108e8a4>] task_work_run+0xc4/0xe0
   [<ffffffff81012fa7>] do_notify_resume+0x97/0xb0
   [<ffffffff8178896f>] int_signal+0x12/0x17
   [<ffffffffffffffff>] 0xffffffffffffffff

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
