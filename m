From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add bug_on when f2fs_gc even fails to
 get one victim
Date: Thu, 12 Oct 2017 19:29:31 -0700
Message-ID: <20171013022931.GA26888@jaegeuk-macbookpro.roam.corp.google.com>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
 <20171012232308.GA19689@jaegeuk-macbookpro.roam.corp.google.com>
 <702a755a-1af2-5ddb-9d2f-da5bf67c7705@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e2pjH-0005yM-4B
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 02:29:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e2pjG-0006KG-0y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 02:29:39 +0000
Content-Disposition: inline
In-Reply-To: <702a755a-1af2-5ddb-9d2f-da5bf67c7705@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>
Cc: yunlong.song@icloud.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

On 10/13, Yunlong Song wrote:
> Hi, Jay,
>     I think it should not happen when need_gc == true but total_freed ==0,
> so I add it as bug_on to let it panic at once. And even CHECK_FS is closed,
> this can also printk WARNING message for notice.

Ah, got it. Merged. :)
Thanks,

> 
> On 2017/10/13 7:23, Jaegeuk Kim wrote:
> > Hi Yunlong,
> > 
> > On 10/11, Yunlong Song wrote:
> > > This can help us to debug on some corner case.
> > > 
> > > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> > > ---
> > >   fs/f2fs/gc.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 197ebf4..960503e 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > >   		.ilist = LIST_HEAD_INIT(gc_list.ilist),
> > >   		.iroot = RADIX_TREE_INIT(GFP_NOFS),
> > >   	};
> > > +	bool need_gc = false;
> > >   	trace_f2fs_gc_begin(sbi->sb, sync, background,
> > >   				get_pages(sbi, F2FS_DIRTY_NODES),
> > > @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > >   			if (ret)
> > >   				goto stop;
> > >   		}
> > > -		if (has_not_enough_free_secs(sbi, 0, 0))
> > > +		if (has_not_enough_free_secs(sbi, 0, 0)) {
> > >   			gc_type = FG_GC;
> > > +			need_gc = true;
> > > +		}
> > >   	}
> > >   	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> > > @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > >   		goto stop;
> > >   	}
> > >   	if (!__get_victim(sbi, &segno, gc_type)) {
> > > +		f2fs_bug_on(sbi, !total_freed && need_gc);
> > How about this, if this is for debugging purpose?
> > 
> > 		if (!total_freed && need_gc)
> > 			f2fs_msg(...);
> > 
> > It's not a good way to define a value for f2fs_bug_on(), since it is only
> > activated by CHECK_FS config.
> > 
> > Thanks,
> > 
> > >   		ret = -ENODATA;
> > >   		goto stop;
> > >   	}
> > > -- 
> > > 1.8.5.2
> > .
> > 
> 
> -- 
> Thanks,
> Yunlong Song
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
