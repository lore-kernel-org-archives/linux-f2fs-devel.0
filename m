From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: handle failed bio allocation
Date: Mon, 24 Aug 2015 17:31:30 +0800
Message-ID: <001601d0de4f$c3ac5c60$4b051520$@samsung.com>
References: <1439593751-21879-1-git-send-email-jaegeuk@kernel.org>
 <01b801d0db27$e8b9e9d0$ba2dbd70$@samsung.com>
 <20150820155727.GB42028@jaegeuk-mac02.mot-mobility.com>
 <021601d0dc10$003a90d0$00afb270$@samsung.com>
 <20150824045337.GA2837@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150824045337.GA2837@jaegeuk-mac02.mot-mobility.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, August 24, 2015 12:54 PM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: handle failed bio allocation
> 
> Hi Chao,
> 
> [snip]
> 
> > > > >
> > > > > -	/* No failure on bio allocation */
> > > > > -	bio = bio_alloc(GFP_NOIO, npages);
> > > >
> > > > How about using __GFP_NOFAIL flag to avoid failing in bio_alloc instead
> > > > of adding opencode endless loop in code?
> > > >
> > > > We can see the reason in this commit 	647757197cd3
> > > > ("mm: clarify __GFP_NOFAIL deprecation status ")
> > > >
> > > > "__GFP_NOFAIL is documented as a deprecated flag since commit
> > > > 478352e789f5 ("mm: add comment about deprecation of __GFP_NOFAIL").
> > > >
> > > > This has discouraged people from using it but in some cases an opencoded
> > > > endless loop around allocator has been used instead. So the allocator
> > > > is not aware of the de facto __GFP_NOFAIL allocation because this
> > > > information was not communicated properly.
> > > >
> > > > Let's make clear that if the allocation context really cannot afford
> > > > failure because there is no good failure policy then using __GFP_NOFAIL
> > > > is preferable to opencoding the loop outside of the allocator."
> > > >
> > > > BTW, I found that f2fs_kmem_cache_alloc also could be replaced, we could
> > > > fix them together.
> > >
> > > Agreed. I think that can be another patch like this.
> > >
> > > From 1579e0d1ada96994c4ec6619fb5b5d9386e77ab3 Mon Sep 17 00:00:00 2001
> > > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Date: Thu, 20 Aug 2015 08:51:56 -0700
> > > Subject: [PATCH] f2fs: use __GFP_NOFAIL to avoid infinite loop
> > >
> > > __GFP_NOFAIL can avoid retrying the whole path of kmem_cache_alloc and
> > > bio_alloc.
> > >
> > > Suggested-by: Chao Yu <chao2.yu@samsung.com>
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/f2fs.h | 16 +++++-----------
> > >  1 file changed, 5 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 00591f7..c78b599 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1244,13 +1244,10 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
> > >  						gfp_t flags)
> > >  {
> > >  	void *entry;
> > > -retry:
> > > -	entry = kmem_cache_alloc(cachep, flags);
> > > -	if (!entry) {
> > > -		cond_resched();
> > > -		goto retry;
> > > -	}
> > >
> > > +	entry = kmem_cache_alloc(cachep, flags);
> > > +	if (!entry)
> > > +		entry = kmem_cache_alloc(cachep, flags | __GFP_NOFAIL);
> >
> > The fast + slow path model looks good to me, expect one thing:
> > In several paths of checkpoint, caller will grab slab cache with GFP_ATOMIC,
> > so in slow path, our flags will be GFP_ATOMIC | __GFP_NOFAIL, I'm not sure
> > that the two flags can be used together.
> >
> > Should we replace GFP_ATOMIC with GFP_NOFS in flags if caller passed
> > GFP_ATOMIC?
> 
> Indeed, we need to avoid GFP_ATOMIC as much as possible to mitigate memory
> pressure at this moment. Too much abused.
> 
> I wrote a patch like this.
> 
> From a9209556d024cdce490695586ecee3164efda49c Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 20 Aug 2015 08:51:56 -0700
> Subject: [PATCH] f2fs: use __GFP_NOFAIL to avoid infinite loop
> 
> __GFP_NOFAIL can avoid retrying the whole path of kmem_cache_alloc and
> bio_alloc.
> And, it also fixes the use cases of GFP_ATOMIC correctly.

Looks good to me!

> 
> Suggested-by: Chao Yu <chao2.yu@samsung.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

Thanks,
