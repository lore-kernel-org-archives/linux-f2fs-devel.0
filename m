From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 1/2] f2fs: flush dirty nat entries when exceeding threshold
Date: Mon, 18 Jan 2016 11:13:08 +0800
Message-ID: <019c01d1519e$3fe1a490$bfa4edb0$@samsung.com>
References: <017d01d15041$7fad3890$7f07a9b0$@samsung.com>
 <20160116202958.GA67230@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160116202958.GA67230@jaegeuk>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, January 17, 2016 4:30 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] f2fs: flush dirty nat entries when exceeding threshold
> 
> Hi Chao,
> 
> On Sat, Jan 16, 2016 at 05:36:40PM +0800, Chao Yu wrote:
> > When testing f2fs with xfstest, generic/251 is stuck for long time,
> > the case uses below serials to obtain fresh released space in device,
> > in order to preparing for following fstrim test.
> >
> > 1. rm -rf /mnt/dir
> > 2. mkdir /mnt/dir/
> > 3. cp -axT `pwd`/ /mnt/dir/
> > 4. goto 1
> >
> > During preparing step, all nat entries will be cached in nat cache,
> > most of them are dirty entries with invalid blkaddr, which means
> > nodes related to these entries have been truncated, and they could
> > be reused after the dirty entries been checkpointed.
> >
> > However, there was no checkpoint been triggered, so nid allocators
> > (e.g. mkdir, creat) will run into long journey of iterating all NAT
> > pages, looking for free nids in alloc_nid->build_free_nids.
> >
> > Here, we give another chance to f2fs_balance_fs_bg to do checkpoint
> > to flush nat entries for reusing in free nid cache when dirty entry
> > count exceeds 10% of max count.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/node.h    | 8 ++++++++
> >  fs/f2fs/segment.c | 3 ++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> > index d4d1f63..630c62d 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -25,6 +25,8 @@
> >  /* control the memory footprint threshold (10MB per 1GB ram) */
> >  #define DEF_RAM_THRESHOLD	10
> >
> > +#define DEF_DIRTY_NAT_THRESHOLD		10	/* 10% over max nid */
> > +
> >  /* vector size for gang look-up from nat cache that consists of radix tree */
> >  #define NATVEC_SIZE	64
> >  #define SETVEC_SIZE	32
> > @@ -117,6 +119,12 @@ static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,
> >  	raw_ne->version = ni->version;
> >  }
> >
> > +static inline bool excess_dirty_nats(struct f2fs_sb_info *sbi)
> > +{
> > +	return NM_I(sbi)->dirty_nat_cnt >=
> > +			NM_I(sbi)->max_nid * DEF_DIRTY_NAT_THRESHOLD / 100;
> 
> Need to add a sysfs entry?

Agreed, let me export the sysfs entry in another patch, distinguishing with
current bug fixing patch.

Thanks,

> 
> Thanks,
> 
> > +}
> > +
> >  enum mem_type {
> >  	FREE_NIDS,	/* indicates the free nid list */
> >  	NAT_ENTRIES,	/* indicates the cached nat entry */
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 5904a41..68800e6 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -291,8 +291,9 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
> >
> >  	/* checkpoint is the only way to shrink partial cached entries */
> >  	if (!available_free_memory(sbi, NAT_ENTRIES) ||
> > -			excess_prefree_segs(sbi) ||
> >  			!available_free_memory(sbi, INO_ENTRIES) ||
> > +			excess_prefree_segs(sbi) ||
> > +			excess_dirty_nats(sbi) ||
> >  			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
> >  		if (test_opt(sbi, DATA_FLUSH))
> >  			sync_dirty_inodes(sbi, FILE_INODE);
> > --
> > 2.6.3
> >
