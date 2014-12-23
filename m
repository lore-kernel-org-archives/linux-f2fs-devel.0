From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: conduct f2fs_gc as explicit gc_type
Date: Tue, 23 Dec 2014 18:04:54 +0900
Message-ID: <20141223090454.GF3335@lcm>
References: <1419291459-7731-1-git-send-email-cm224.lee@samsung.com>
 <20141223080037.GA10999@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20141223080037.GA10999@jaegeuk-mac02.hsd1.ca.comcast.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On Tue, Dec 23, 2014 at 12:00:37AM -0800, Jaegeuk Kim wrote:
> Hi Changman,
> 
> On Tue, Dec 23, 2014 at 08:37:38AM +0900, Changman Lee wrote:
> > f2fs has 2 gc_type; foreground gc and background gc.
> > In the case of foreground gc, f2fs will select victim as greedy.
> > Otherwise, as cost-benefit. And also it runs as greedy in SSR mode.
> > Until now, f2fs_gc conducted with BG_GC as default. So we couldn't
> > expect how it runs; BG_GC or FG_GC and GREEDY or COST_BENEFIT.
> 
> What does this mean?
> In f2fs_gc, the gc_type will be changed accoring to the number of free
> sections.

Right, but when I turn on trace I saw 3 cases.
1. BG_GC and COST_BENEFIT
2. BG_GC and GREEDY
3. FG_GC and GREEDY

I expected that case 1 is likely to operate only by gc_thread.
But it was not.

> 
> > Therefore sometimes it runs as BG_GC/COST_BENEFIT although gc_thread
> > don't put f2fs_gc to work.
> 
> You mean f2fs_balance_fs?
> In this case, again, the gc_type will be assigned FG_GC.
> 
> Why do you want to set FG_GC/GREEDY for the SSR victims?

We should alloate a block as soon as possible.
In the case of FG_GC, it also uses invalid blocks dirtied by background gc.
In another case, if (BG_GC && test_bit(victim_secmap)), it will be
skipped.
I intended that SSR operates fastly like FG_GC.

Regards,
Changman

> 
> Thanks,
> 
> > 
> > Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> > ---
> >  fs/f2fs/f2fs.h    | 2 +-
> >  fs/f2fs/gc.c      | 5 ++---
> >  fs/f2fs/segment.c | 6 +++---
> >  3 files changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index ae6dfb6..c956535 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1476,7 +1476,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
> >  int start_gc_thread(struct f2fs_sb_info *);
> >  void stop_gc_thread(struct f2fs_sb_info *);
> >  block_t start_bidx_of_node(unsigned int, struct f2fs_inode_info *);
> > -int f2fs_gc(struct f2fs_sb_info *);
> > +int f2fs_gc(struct f2fs_sb_info *, int);
> >  void build_gc_manager(struct f2fs_sb_info *);
> >  int __init create_gc_caches(void);
> >  void destroy_gc_caches(void);
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index eec0933..e1fa53a 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -80,7 +80,7 @@ static int gc_thread_func(void *data)
> >  		stat_inc_bggc_count(sbi);
> >  
> >  		/* if return value is not zero, no victim was selected */
> > -		if (f2fs_gc(sbi))
> > +		if (f2fs_gc(sbi, BG_GC))
> >  			wait_ms = gc_th->no_gc_sleep_time;
> >  
> >  		/* balancing f2fs's metadata periodically */
> > @@ -691,10 +691,9 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
> >  	f2fs_put_page(sum_page, 1);
> >  }
> >  
> > -int f2fs_gc(struct f2fs_sb_info *sbi)
> > +int f2fs_gc(struct f2fs_sb_info *sbi, int gc_type)
> >  {
> >  	unsigned int segno, i;
> > -	int gc_type = BG_GC;
> >  	int nfree = 0;
> >  	int ret = -1;
> >  	struct cp_control cpc;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index fd9bc96..3b32404 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -281,7 +281,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi)
> >  	 */
> >  	if (has_not_enough_free_secs(sbi, 0)) {
> >  		mutex_lock(&sbi->gc_mutex);
> > -		f2fs_gc(sbi);
> > +		f2fs_gc(sbi, FG_GC);
> >  	}
> >  }
> >  
> > @@ -994,12 +994,12 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
> >  
> >  	if (IS_NODESEG(type) || !has_not_enough_free_secs(sbi, 0))
> >  		return v_ops->get_victim(sbi,
> > -				&(curseg)->next_segno, BG_GC, type, SSR);
> > +				&(curseg)->next_segno, FG_GC, type, SSR);
> >  
> >  	/* For data segments, let's do SSR more intensively */
> >  	for (; type >= CURSEG_HOT_DATA; type--)
> >  		if (v_ops->get_victim(sbi, &(curseg)->next_segno,
> > -						BG_GC, type, SSR))
> > +						FG_GC, type, SSR))
> >  			return 1;
> >  	return 0;
> >  }
> > -- 
> > 1.9.1
> > 
> > 
> > ------------------------------------------------------------------------------
> > Dive into the World of Parallel Programming! The Go Parallel Website,
> > sponsored by Intel and developed in partnership with Slashdot Media, is your
> > hub for all things parallel software development, from weekly thought
> > leadership blogs to news, videos, case studies, tutorials and more. Take a
> > look and join the conversation now. http://goparallel.sourceforge.net
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
