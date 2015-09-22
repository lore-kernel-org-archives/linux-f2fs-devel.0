From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 1/3] f2fs: introduce __try_update_largest_extent
Date: Tue, 22 Sep 2015 21:04:42 +0800
Message-ID: <00d401d0f537$592d1ec0$0b875c40$@samsung.com>
References: <00cb01d0f1ef$8886fc90$9994f5b0$@samsung.com>
 <20150921184002.GA20551@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150921184002.GA20551@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, September 22, 2015 2:40 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] f2fs: introduce __try_update_largest_extent
> 
> Hi Chao,
> 
> On Fri, Sep 18, 2015 at 04:53:07PM +0800, Chao Yu wrote:
> > This patch adds a new helper __try_update_largest_extent for cleanup.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/extent_cache.c | 14 +++++---------
> >  fs/f2fs/f2fs.h         |  7 +++++++
> >  2 files changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index c9d1cfd..31d5b48 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -351,8 +351,7 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info
> *sbi,
> >  	}
> >
> >  	if (en) {
> > -		if (en->ei.len > et->largest.len)
> > -			et->largest = en->ei;
> > +		__try_update_largest_extent(&et->largest, &en->ei);
> >  		et->cached_en = en;
> >  	}
> >  	return en;
> > @@ -389,8 +388,7 @@ do_insert:
> >  	if (!en)
> >  		return NULL;
> >
> > -	if (en->ei.len > et->largest.len)
> > -		et->largest = en->ei;
> > +	__try_update_largest_extent(&et->largest, &en->ei);
> >  	et->cached_en = en;
> >  	return en;
> >  }
> > @@ -476,12 +474,10 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
> >  				: NULL;
> >  		}
> >
> > -		if (parts) {
> > -			if (en->ei.len > et->largest.len)
> > -				et->largest = en->ei;
> > -		} else {
> > +		if (parts)
> > +			__try_update_largest_extent(&et->largest, &en->ei);
> > +		else
> >  			__detach_extent_node(sbi, et, en);
> > -		}
> >
> >  		/*
> >  		 * if original extent is split into zero or two parts, extent
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index dbceb35..3342619 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -498,6 +498,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
> >  	return __is_extent_mergeable(cur, front);
> >  }
> >
> > +static inline void __try_update_largest_extent(struct extent_info *largest,
> > +						struct extent_info *cur)
> 
> How about __try_update_largest_extent(et, en) ?

More neat! I will change it.

Thanks,

> 
> > +{
> > +	if (cur->len > largest->len)
> > +		*largest = *cur;
> > +}
> > +
> >  struct f2fs_nm_info {
> >  	block_t nat_blkaddr;		/* base disk address of NAT */
> >  	nid_t max_nid;			/* maximum possible node ids */
> > --
> > 2.5.2
