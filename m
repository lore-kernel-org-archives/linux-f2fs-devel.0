From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
Date: Thu, 9 Aug 2018 18:46:14 -0700
Message-ID: <20180810014614.GA44979@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180730013242.15647-1-jaegeuk@kernel.org>
 <20180804222954.GB35077@jaegeuk-macbookpro.roam.corp.google.com>
 <20180805163450.GB55836@jaegeuk-macbookpro.roam.corp.google.com>
 <16d7f719-268f-99f4-c5b2-fc893b557f11@huawei.com>
 <20180809195917.GA27087@jaegeuk-macbookpro.roam.corp.google.com>
 <b09cdcf8-f8cd-98b6-54c1-82b2fb0f8b81@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b09cdcf8-f8cd-98b6-54c1-82b2fb0f8b81@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/10, Chao Yu wrote:
> On 2018/8/10 3:59, Jaegeuk Kim wrote:
> > Yup, how about this?
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index d816c328f02b..cb510fb36523 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1052,6 +1052,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
> >  	};
> >  	unsigned long long last_skipped = sbi->skipped_atomic_files[FG_GC];
> > +	unsigned long long first_skipped;
> >  	unsigned int skipped_round = 0, round = 0;
> >  
> >  	trace_f2fs_gc_begin(sbi->sb, sync, background,
> > @@ -1064,8 +1065,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  				prefree_segments(sbi));
> >  
> >  	cpc.reason = __get_cp_reason(sbi);
> > -	sbi->skipped_gc_rwsem = 0;
> >  gc_more:
> > +	sbi->skipped_gc_rwsem = 0;
> > +	first_skipped = last_skipped;
> > +
> >  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
> >  		ret = -EINVAL;
> >  		goto stop;
> > @@ -1126,8 +1129,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  			goto gc_more;
> >  		}
> >  
> > -		if (sbi->skipped_atomic_files[FG_GC] == last_skipped &&
> > -				sbi->skipped_atomic_files[FG_GC] >
> > +		if (first_skipped < last_skipped &&
> > +				(last_skipped - first_skipped) >
> 
> IMO, it would be better to judge the condition with skipped number in all round
> of FGGC instead of last round, since number in last round may not very accurate.

Yup, moved before gc_more.

> 
> Thoughts?
> 
> Thanks,
> 
> >  						sbi->skipped_gc_rwsem) {
> >  			f2fs_drop_inmem_pages_all(sbi, true);
> >  			segno = NULL_SEGNO;
> > 
> > .
> > 
