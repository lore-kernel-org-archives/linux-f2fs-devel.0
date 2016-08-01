From: Rask Ingemann Lambertsen <ccc94453@mail.jubii.dk>
Subject: Re: Out of memory mounting 8 TB volume with 3.5 GiB of
 memory - solved
Date: Mon, 1 Aug 2016 20:33:57 +0200
Message-ID: <20160801183356.GG4159@vip.cybercity.dk>
References: <20160724194630.GF4159@vip.cybercity.dk>
	<20160725180140.GA56718@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ccc94453@mail.jubii.dk>) id 1bUI2X-0002zV-7H
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 01 Aug 2016 18:34:13 +0000
Received: from smtpout03.dkbal.mailcore.com ([85.235.243.176]
	helo=SMTPOUT02.DKBAL.mailcore.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bUI2V-0004b3-FC for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 01 Aug 2016 18:34:13 +0000
Received: from vip.cybercity.dk (x1-6-00-0f-9f-c6-3e-90.cpe.webspeed.dk
	[188.181.80.54])
	by SMTPOUT02.DKBAL.mailcore.com (Postfix) with ESMTPSA id 1E767450F8
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon,  1 Aug 2016 20:34:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160725180140.GA56718@jaegeuk>
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

On Mon, Jul 25, 2016 at 11:01:40AM -0700, Jaegeuk Kim wrote:
> Hi,
> 
> Yes, I've double-checked that f2fs needs about 100 MB/TB to manage some data
> structures for space management in main memory.

   OK, so with a 3G/1G user/kernel memory split, it becomes too tight. I
recompiled the kernel with a 2G/2G memory split instead, and then it works.

Not mounted:
# free
              total        used        free      shared  buff/cache   available
Mem:        3627916       21616     3551088        8576       55212     3514812
Swap:             0           0           0

Mounted:
# free
              total        used        free      shared  buff/cache   available
Mem:        3627916      829840     2465744        8576      332332     2706456
Swap:             0           0           0

# df --block-size=G /home
Filesystem     1G-blocks  Used Available Use% Mounted on
/dev/sda2          7448G  124G     7309G   2% /home

That comes out to 108.515 kiB/GiB, or 108.515 MiB/TiB, confirming your
estimate above.

-- 
Rask Ingemann Lambertsen

------------------------------------------------------------------------------
