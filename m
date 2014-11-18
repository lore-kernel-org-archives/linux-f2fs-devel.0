From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: add cleancache support
Date: Tue, 18 Nov 2014 11:30:50 +0800
Message-ID: <006901d002e0$2505c790$6f1156b0$@samsung.com>
References: <1415856890-2455-1-git-send-email-cm224.lee@samsung.com>
 <000901cfffb8$556213b0$00263b10$@samsung.com> <20141114053951.GC16657@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20141114053951.GC16657@lcm>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@samsung.com]
> Sent: Friday, November 14, 2014 1:40 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: add cleancache support
> 
> On Fri, Nov 14, 2014 at 11:08:15AM +0800, Chao Yu wrote:
> > Hi Changman,
> >
> > > -----Original Message-----
> > > From: Changman Lee [mailto:cm224.lee@samsung.com]
> > > Sent: Thursday, November 13, 2014 1:35 PM
> > > To: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > > Subject: [f2fs-dev] [PATCH] f2fs: add cleancache support
> > >
> > > To use cleancache, fs must explicitly enable cleancache by calling
> > > cleancache_init_fs.
> >
> > Good catch!
> >
> > AFAIK, cleancache will work only if we init its backend and register related ops,
> > but since we merged the commit 962564604873 "staging: zcache: delete it", we
> > have lost the zcache one. Is there other backends?
> >
> > Regards,
> > Yu
> >
> 
> Hi Yu,
> 
> AFAIK, Hypervisor like xen uses cleancache and frontswap positively.

I'm not very clear, is that mean if we want to use cleancache in fs,
we should make fs run in vm like xen now?

> And GCMA (Guaranteed CMA) is newly submitting, which has plan to be used
> by cleancache.

Ah, it's good news to hear about this! Thank you for letting me know.

> I think it's not bad we prepare to accept them.

Yeah. Also I agree with Jaegeuk, showing some performance numbers will be better.

Thanks,
Yu

> 
> Thansk,
> 
> > >
> > > Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> > > ---
> > >  fs/f2fs/super.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 512ffd8..2ebb960 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/blkdev.h>
> > >  #include <linux/f2fs_fs.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/cleancache.h>
> > >
> > >  #include "f2fs.h"
> > >  #include "node.h"
> > > @@ -1144,6 +1145,8 @@ try_onemore:
> > >  		if (err)
> > >  			goto free_kobj;
> > >  	}
> > > +
> > > +	cleancache_init_fs(sb);
> > >  	return 0;
> > >
> > >  free_kobj:
> > > --
> > > 1.9.1
> > >
> > >
> > > ------------------------------------------------------------------------------
> > > Comprehensive Server Monitoring with Site24x7.
> > > Monitor 10 servers for $9/Month.
> > > Get alerted through email, SMS, voice calls or mobile push notifications.
> > > Take corrective actions from your mobile device.
> > > http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

