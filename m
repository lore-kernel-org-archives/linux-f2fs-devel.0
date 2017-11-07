From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: add bug_on when f2fs_gc even fails to get one
 victim
Date: Mon, 6 Nov 2017 18:40:58 -0800
Message-ID: <20171107024058.GH88544@jaegeuk-macbookpro.roam.corp.google.com>
References: <1507729864-118702-1-git-send-email-yunlong.song@huawei.com>
 <1507901500-162168-1-git-send-email-yunlong.song@huawei.com>
 <20171103034402.GC11335@jaegeuk-macbookpro.roam.corp.google.com>
 <3b26badb-c34e-3c2d-74a2-26ecef1f64ff@huawei.com>
 <20171107023835.GG88544@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171107023835.GG88544@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 11/06, Jaegeuk Kim wrote:
> On 11/06, Yunlong Song wrote:
> > Agree.
> > 
> > On 2017/11/3 11:44, Jaegeuk Kim wrote:
> > > On 10/13, Yunlong Song wrote:
> > > > This can help us to debug on some corner case.
> > > > 
> > > > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> > > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > > ---
> > > >   fs/f2fs/gc.c | 6 +++++-
> > > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > > index 197ebf4..2b03202 100644
> > > > --- a/fs/f2fs/gc.c
> > > > +++ b/fs/f2fs/gc.c
> > > > @@ -986,6 +986,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > > >   		.ilist = LIST_HEAD_INIT(gc_list.ilist),
> > > >   		.iroot = RADIX_TREE_INIT(GFP_NOFS),
> > > >   	};
> > > > +	bool need_fggc = false;
> > > >   	trace_f2fs_gc_begin(sbi->sb, sync, background,
> > > >   				get_pages(sbi, F2FS_DIRTY_NODES),
> > > > @@ -1018,8 +1019,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > > >   			if (ret)
> > > >   				goto stop;
> > > >   		}
> > > > -		if (has_not_enough_free_secs(sbi, 0, 0))
> > > > +		if (has_not_enough_free_secs(sbi, 0, 0)) {
> > > >   			gc_type = FG_GC;
> > > > +			need_fggc = true;
> > > > +		}
> > > >   	}
> > > >   	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> > > > @@ -1028,6 +1031,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> > > >   		goto stop;
> > > >   	}
> > > >   	if (!__get_victim(sbi, &segno, gc_type)) {
> > > > +		f2fs_bug_on(sbi, !total_freed && need_fggc);
> > > Just like this?
> > That's OK.
> 
> I'm not quite sure whether this is really a bug_on case.
> Let me make it WARN_ON() for debugging purpose first.

BTW, why is this the special case where BG_GC detects FG_GC?

> 
> Thanks,
> 
> > 
> > > 
> > > 		f2fs_bug_on(sbi, !total_freed && !sync && gc_type == FG_GC);
> > > 
> > > >   		ret = -ENODATA;
> > > >   		goto stop;
> > > >   	}
> > > > -- 
> > > > 1.8.5.2
> > > .
> > > 
> > 
> > -- 
> > Thanks,
> > Yunlong Song
> > 
