From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH] f2fs: add cleancache support
Date: Fri, 14 Nov 2014 14:39:51 +0900
Message-ID: <20141114053951.GC16657@lcm>
References: <1415856890-2455-1-git-send-email-cm224.lee@samsung.com>
	<000901cfffb8$556213b0$00263b10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1Xp9dE-0003o0-5H
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 05:41:16 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Xp9dB-0006oP-Qh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 05:41:16 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NF000GZ2L4II0C0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Nov 2014 14:41:06 +0900 (KST)
Content-disposition: inline
In-reply-to: <000901cfffb8$556213b0$00263b10$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, Nov 14, 2014 at 11:08:15AM +0800, Chao Yu wrote:
> Hi Changman,
> 
> > -----Original Message-----
> > From: Changman Lee [mailto:cm224.lee@samsung.com]
> > Sent: Thursday, November 13, 2014 1:35 PM
> > To: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH] f2fs: add cleancache support
> > 
> > To use cleancache, fs must explicitly enable cleancache by calling
> > cleancache_init_fs.
> 
> Good catch!
> 
> AFAIK, cleancache will work only if we init its backend and register related ops,
> but since we merged the commit 962564604873 "staging: zcache: delete it", we
> have lost the zcache one. Is there other backends?
> 
> Regards,
> Yu
> 

Hi Yu,

AFAIK, Hypervisor like xen uses cleancache and frontswap positively.
And GCMA (Guaranteed CMA) is newly submitting, which has plan to be used
by cleancache.
I think it's not bad we prepare to accept them.

Thansk,

> > 
> > Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> > ---
> >  fs/f2fs/super.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 512ffd8..2ebb960 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/blkdev.h>
> >  #include <linux/f2fs_fs.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/cleancache.h>
> > 
> >  #include "f2fs.h"
> >  #include "node.h"
> > @@ -1144,6 +1145,8 @@ try_onemore:
> >  		if (err)
> >  			goto free_kobj;
> >  	}
> > +
> > +	cleancache_init_fs(sb);
> >  	return 0;
> > 
> >  free_kobj:
> > --
> > 1.9.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > Comprehensive Server Monitoring with Site24x7.
> > Monitor 10 servers for $9/Month.
> > Get alerted through email, SMS, voice calls or mobile push notifications.
> > Take corrective actions from your mobile device.
> > http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
