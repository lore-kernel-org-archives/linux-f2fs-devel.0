From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: avoid multiple node page writes
 due to	inline_data
Date: Tue, 26 Jan 2016 10:31:50 -0800
Message-ID: <20160126183150.GA39704@jaegeuk.gateway>
References: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
	<000d01d15754$dca6e6d0$95f4b470$@samsung.com>
	<20160125191751.GA12233@jaegeuk.gateway>
	<009101d15807$1f3075e0$5d9161a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aO8PI-00032G-8j
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 18:32:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aO8PG-0007vs-PY for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 18:32:00 +0000
Content-Disposition: inline
In-Reply-To: <009101d15807$1f3075e0$5d9161a0$@samsung.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Jan 26, 2016 at 02:58:53PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, January 26, 2016 3:18 AM
> > To: Chao Yu
> > Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid multiple node page writes due to inline_data
> > 
> > Hi Chao,
> > 
> > On Mon, Jan 25, 2016 at 05:42:40PM +0800, Chao Yu wrote:
> > > Hi Jaegeuk,
> > >
> > > > -----Original Message-----
> > > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > > Sent: Sunday, January 24, 2016 4:16 AM
> > > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > > linux-f2fs-devel@lists.sourceforge.net
> > > > Cc: Jaegeuk Kim
> > > > Subject: [f2fs-dev] [PATCH 1/2] f2fs: avoid multiple node page writes due to inline_data
> > > >
> > > > The sceanrio is:
> > > > 1. create fully node blocks
> > > > 2. flush node blocks
> > > > 3. write inline_data for all the node blocks again
> > > > 4. flush node blocks redundantly
> > > >
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >  fs/f2fs/data.c | 14 +++++++++++---
> > > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > index 8d0d9ec..011456e 100644
> > > > --- a/fs/f2fs/data.c
> > > > +++ b/fs/f2fs/data.c
> > > > @@ -1622,14 +1622,22 @@ static int f2fs_write_end(struct file *file,
> > > >
> > > >  	trace_f2fs_write_end(inode, pos, len, copied);
> > > >
> > > > -	set_page_dirty(page);
> > > > -
> > > >  	if (pos + copied > i_size_read(inode)) {
> > > >  		i_size_write(inode, pos + copied);
> > > >  		mark_inode_dirty(inode);
> > > > -		update_inode_page(inode);
> > > >  	}
> > > >
> > > > +	if (f2fs_has_inline_data(inode) &&
> > > > +			is_inode_flag_set(F2FS_I(inode), FI_DATA_EXIST)) {
> > > > +		int err = f2fs_write_inline_data(inode, page);
> > >
> > > Oh, I'm sure this can fix that issue, but IMO:
> > > a) this implementation has side-effect, it triggers inline data copying
> > > between data page and node page whenever user write inline datas, so if
> > > user updates inline data frequently, write-through approach would cause
> > > memory copy overhead.
> > 
> > Agreed.
> > 
> > > b) inline storm should be a rare case, as we didn't get any report about
> > > problem for long time until Dave's, and write_end is a hot path, I think
> > > it's better to be cautious to change our inline data cache policy for
> > > fixing a rare issue in hot path.
> > >
> > > What about delaying the merge operation? like:
> > > 1) as I proposed before, merging inline page into inode page when
> > > detecting free_sections <= (node_secs + 2 * dent_secs + inline_secs).
> > > 2) merge inline page into inode page before writeback inode page in
> > > sync_node_pages.
> > 
> > Okay, I'm thinking more general way where we can get rid of every inlien_data
> > write when we flush node pages.
> 
> I encountered deadlock issue, could you have a look at it?

Yeah, I've been stablizing this for a while.
Please check f2fs.git/dev-test.

Thanks,

> 
> ======================================================
>  [ INFO: possible circular locking dependency detected ]
>  4.5.0-rc1 #45 Tainted: G           O
>  -------------------------------------------------------
>  fstrim/15301 is trying to acquire lock:
>   (sb_internal#2){++++..}, at: [<ffffffff81216fca>] __sb_start_write+0xda/0xf0
> 
>  but task is already holding lock:
>   (&sbi->cp_rwsem){++++..}, at: [<ffffffffa07d06d2>] block_operations+0x82/0x130 [f2fs]
> 
>  which lock already depends on the new lock.
> 
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (&sbi->cp_rwsem){++++..}:
>         [<ffffffff810bf827>] lock_acquire+0xb7/0x130
>         [<ffffffff817de829>] down_read+0x39/0x50
>         [<ffffffffa07c27af>] f2fs_evict_inode+0x26f/0x370 [f2fs]
>         [<ffffffff812326cd>] evict+0xdd/0x1d0
>         [<ffffffff8123323f>] iput+0x19f/0x250
>         [<ffffffff81224d9d>] do_unlinkat+0x20d/0x310
>         [<ffffffff81224ee2>] SyS_unlinkat+0x22/0x40
>         [<ffffffff817e0957>] entry_SYSCALL_64_fastpath+0x12/0x6f
> 
>  -> #0 (sb_internal#2){++++..}:
>         [<ffffffff810bf32b>] __lock_acquire+0x132b/0x1770
>         [<ffffffff810bf827>] lock_acquire+0xb7/0x130
>         [<ffffffff810b8fac>] percpu_down_read+0x3c/0x80
>         [<ffffffff81216fca>] __sb_start_write+0xda/0xf0
>         [<ffffffffa07c2761>] f2fs_evict_inode+0x221/0x370 [f2fs]
>         [<ffffffff812326cd>] evict+0xdd/0x1d0
>         [<ffffffff8123323f>] iput+0x19f/0x250
>         [<ffffffffa07dd4d3>] sync_node_pages+0x703/0x900 [f2fs]
>         [<ffffffffa07d075a>] block_operations+0x10a/0x130 [f2fs]
>         [<ffffffffa07d13e4>] write_checkpoint+0xc4/0xb80 [f2fs]
>         [<ffffffffa07e0af2>] f2fs_trim_fs+0x122/0x1d0 [f2fs]
>         [<ffffffffa07c07da>] f2fs_ioctl+0x7fa/0x9d0 [f2fs]
>         [<ffffffff81228448>] vfs_ioctl+0x18/0x40
>         [<ffffffff81228b96>] do_vfs_ioctl+0x96/0x680
>         [<ffffffff81229212>] SyS_ioctl+0x92/0xa0
>         [<ffffffff817e0957>] entry_SYSCALL_64_fastpath+0x12/0x6f
> 
>  other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&sbi->cp_rwsem);
>                                 lock(sb_internal#2);
>                                 lock(&sbi->cp_rwsem);
>    lock(sb_internal#2);
> 
>   *** DEADLOCK ***
> 
> Thanks,
> 
> > 
> > I've been testing this patch.
> > 
> > From ebddf607c64da691fef08cf68a8ecadafd5d896b Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Mon, 25 Jan 2016 05:57:05 -0800
> > Subject: [PATCH] f2fs: avoid multiple node page writes due to inline_data
> > 
> > The sceanrio is:
> > 1. create fully node blocks
> > 2. flush node blocks
> > 3. write inline_data for all the node blocks again
> > 4. flush node blocks redundantly
> > 
> > So, this patch tries to flush inline_data when flushing node blocks.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/data.c   |  1 +
> >  fs/f2fs/inline.c |  2 ++
> >  fs/f2fs/node.c   | 35 +++++++++++++++++++++++++++++++++++
> >  fs/f2fs/node.h   | 15 +++++++++++++++
> >  4 files changed, 53 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 6925c10..9043ecf 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1464,6 +1464,7 @@ restart:
> >  		if (pos + len <= MAX_INLINE_DATA) {
> >  			read_inline_data(page, ipage);
> >  			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
> > +			set_inline_node(ipage);
> >  			sync_inode_page(&dn);
> >  		} else {
> >  			err = f2fs_convert_inline_page(&dn, page);
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index 8df13e5..fc4d298 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -159,6 +159,7 @@ no_update:
> > 
> >  	/* clear inline data and flag after data writeback */
> >  	truncate_inline_inode(dn->inode_page, 0);
> > +	clear_inline_node(dn->inode_page);
> >  clear_out:
> >  	stat_dec_inline_inode(dn->inode);
> >  	f2fs_clear_inline_inode(dn->inode);
> > @@ -233,6 +234,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
> >  	set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
> > 
> >  	sync_inode_page(&dn);
> > +	clear_inline_node(dn.inode_page);
> >  	f2fs_put_dnode(&dn);
> >  	return 0;
> >  }
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 23b800d..1c5023e 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1154,6 +1154,33 @@ void sync_inode_page(struct dnode_of_data *dn)
> >  	dn->node_changed = ret ? true: false;
> >  }
> > 
> > +static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
> > +{
> > +	struct inode *inode;
> > +	struct page *page;
> > +
> > +	inode = ilookup(sbi->sb, ino);
> > +	if (!inode)
> > +		return;
> > +
> > +	page = find_lock_page(inode->i_mapping, 0);
> > +	if (!page)
> > +		goto iput_out;
> > +
> > +	if (!PageDirty(page))
> > +		goto put_page_out;
> > +
> > +	if (!clear_page_dirty_for_io(page))
> > +		goto put_page_out;
> > +
> > +	if (!f2fs_write_inline_data(inode, page))
> > +		inode_dec_dirty_pages(inode);
> > +put_page_out:
> > +	f2fs_put_page(page, 1);
> > +iput_out:
> > +	iput(inode);
> > +}
> > +
> >  int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
> >  					struct writeback_control *wbc)
> >  {
> > @@ -1221,6 +1248,14 @@ continue_unlock:
> >  				goto continue_unlock;
> >  			}
> > 
> > +			/* flush inline_data */
> > +			if (!ino && is_inline_node(page)) {
> > +				clear_inline_node(page);
> > +				unlock_page(page);
> > +				flush_inline_data(sbi, ino_of_node(page));
> > +				continue;
> > +			}
> > +
> >  			if (!clear_page_dirty_for_io(page))
> >  				goto continue_unlock;
> > 
> > diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> > index 23bd992..1f4f9d4 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -379,6 +379,21 @@ static inline int is_node(struct page *page, int type)
> >  #define is_fsync_dnode(page)	is_node(page, FSYNC_BIT_SHIFT)
> >  #define is_dent_dnode(page)	is_node(page, DENT_BIT_SHIFT)
> > 
> > +static inline int is_inline_node(struct page *page)
> > +{
> > +	return PageChecked(page);
> > +}
> > +
> > +static inline void set_inline_node(struct page *page)
> > +{
> > +	SetPageChecked(page);
> > +}
> > +
> > +static inline void clear_inline_node(struct page *page)
> > +{
> > +	ClearPageChecked(page);
> > +}
> > +
> >  static inline void set_cold_node(struct inode *inode, struct page *page)
> >  {
> >  	struct f2fs_node *rn = F2FS_NODE(page);
> > --
> > 2.6.3
> > 
> 

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
