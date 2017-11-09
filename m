From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: add bug_on when f2fs_gc even fails
 to get one victim
Date: Thu, 9 Nov 2017 09:59:15 -0800
Message-ID: <20171109175915.GC55844@jaegeuk-macbookpro.roam.corp.google.com>
References: <1507901500-162168-1-git-send-email-yunlong.song@huawei.com>
 <20171103034402.GC11335@jaegeuk-macbookpro.roam.corp.google.com>
 <3b26badb-c34e-3c2d-74a2-26ecef1f64ff@huawei.com>
 <20171107023835.GG88544@jaegeuk-macbookpro.roam.corp.google.com>
 <20171107024058.GH88544@jaegeuk-macbookpro.roam.corp.google.com>
 <cafd59c4-1a39-f54b-095e-24430a79437e@huawei.com>
 <20171107032636.GB92599@jaegeuk-macbookpro.roam.corp.google.com>
 <7433d584-b1e0-76e9-a6e4-8da1218dd71d@huawei.com>
 <d036e6c2-af73-3781-242d-5d56a0933e8a@huawei.com>
 <19eec8fd-e941-770a-9477-6ad2d266d475@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eCr6q-0003Hd-Qb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 17:59:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eCr6p-00066I-Lu
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 17:59:24 +0000
Content-Disposition: inline
In-Reply-To: <19eec8fd-e941-770a-9477-6ad2d266d475@huawei.com>
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

On 11/08, Yunlong Song wrote:
> So we should use f2fs_bug_on(sbi, !total_freed && !sync && gc_type ==
> FG_GC);

f2fs_bug_on(sbi, !total_freed && has_not_enough_free_secs(sbi, 0, 0)); ?

> 
> On 2017/11/7 14:56, Chao Yu wrote:
> > On 2017/11/7 12:01, Yunlong Song wrote:
> > > Sorry, misunderstanding, because I think when sync == true, FG_GC does not
> > > check has_not_enough_free_secs, so maybe it does not have to do any gc
> > > at all.
> > > For example, if there are 100 segments for f2fs, and 20 segments are full or
> > > valid blocks over fggc_threshold, then it is correct to fail in get victim.
> > > 
> > > 
> > > On 2017/11/7 11:26, Jaegeuk Kim wrote:
> > > > On 11/07, Yunlong Song wrote:
> > > > > Because I find that some out-of-free problem is caused by the failure
> > > > > of get victim target. For example, chao has pointed out that he has
> > > > > found out a bug when adding this bug_on last week.
> > > > That's NOT what I asked. Why not checking FG_GC all the time like this?
> > > > 
> > > > f2fs_bug_on(sbi, !total_freed && gc_type == FG_GC);
> > ioctl(F2FS_IOC_GARBAGE_COLLECT, &1) will simply trigger this bug_on, so we
> > have to check the conditon only when we run out-of-free-space?
> > 
> > Thanks,
> > 
> > > > > On 2017/11/7 10:40, Jaegeuk Kim wrote:
> > > > > > On 11/06, Jaegeuk Kim wrote:
> > > > > > > On 11/06, Yunlong Song wrote:
> > > > > > > > Agree.
> > > > > > > > 
> > > > > > > > On 2017/11/3 11:44, Jaegeuk Kim wrote:
> > > > > > > > > On 10/13, Yunlong Song wrote:
> > > > > > > > > > This can help us to debug on some corner case.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> > > > > > > > > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > > > > > > > > ---
> > > > > > > > > >      fs/f2fs/gc.c | 6 +++++-
> > > > > > > > > >      1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > > > > > > > > index 197ebf4..2b03202 100644
> > > > > > > > > > --- a/fs/f2fs/gc.c
> > > > > > > > > > +++ b/fs/f2fs/gc.c
> > > > > > > > > > @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > > > > > > > > >      		.ilist = LIST_HEAD_INIT(gc_list.ilist),
> > > > > > > > > >      		.iroot = RADIX_TREE_INIT(GFP_NOFS),
> > > > > > > > > >      	};
> > > > > > > > > > +	bool need_fggc = false;
> > > > > > > > > >      	trace_f2fs_gc_begin(sbi->sb, sync, background,
> > > > > > > > > >      				get_pages(sbi, F2FS_DIRTY_NODES),
> > > > > > > > > > @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > > > > > > > > >      			if (ret)
> > > > > > > > > >      				goto stop;
> > > > > > > > > >      		}
> > > > > > > > > > -		if (has_not_enough_free_secs(sbi, 0, 0))
> > > > > > > > > > +		if (has_not_enough_free_secs(sbi, 0, 0)) {
> > > > > > > > > >      			gc_type = FG_GC;
> > > > > > > > > > +			need_fggc = true;
> > > > > > > > > > +		}
> > > > > > > > > >      	}
> > > > > > > > > >      	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> > > > > > > > > > @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > > > > > > > > >      		goto stop;
> > > > > > > > > >      	}
> > > > > > > > > >      	if (!__get_victim(sbi, &segno, gc_type)) {
> > > > > > > > > > +		f2fs_bug_on(sbi, !total_freed && need_fggc);
> > > > > > > > > Just like this?
> > > > > > > > That's OK.
> > > > > > > I'm not quite sure whether this is really a bug_on case.
> > > > > > > Let me make it WARN_ON() for debugging purpose first.
> > > > > > BTW, why is this the special case where BG_GC detects FG_GC?
> > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > > > 		f2fs_bug_on(sbi, !total_freed && !sync && gc_type == FG_GC);
> > > > > > > > > 
> > > > > > > > > >      		ret = -ENODATA;
> > > > > > > > > >      		goto stop;
> > > > > > > > > >      	}
> > > > > > > > > > -- 
> > > > > > > > > > 1.8.5.2
> > > > > > > > > .
> > > > > > > > > 
> > > > > > > > -- 
> > > > > > > > Thanks,
> > > > > > > > Yunlong Song
> > > > > > > > 
> > > > > > .
> > > > > > 
> > > > > -- 
> > > > > Thanks,
> > > > > Yunlong Song
> > > > > 
> > > > .
> > > > 
> > 
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
