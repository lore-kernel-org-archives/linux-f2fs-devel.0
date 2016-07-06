From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix to avoid data update racing
 between GC and DIO
Date: Wed, 6 Jul 2016 15:37:58 -0700
Message-ID: <20160706223758.GA85815@jaegeuk>
References: <20160630084248.57469-1-yuchao0@huawei.com>
	<20160630084248.57469-2-yuchao0@huawei.com>
	<20160701000311.GA59041@jaegeuk>
	<55063104-5f88-5781-6da7-6a824ae7993b@huawei.com>
	<20160706002416.GA74805@jaegeuk>
	<013cc29d-c1f9-6c0a-a922-beeb221361ec@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bKvSK-0001xj-Th
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 22:38:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bKvSJ-0003og-6d
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Jul 2016 22:38:08 +0000
Content-Disposition: inline
In-Reply-To: <013cc29d-c1f9-6c0a-a922-beeb221361ec@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Jul 06, 2016 at 10:10:57AM +0800, Chao Yu wrote:
> On 2016/7/6 8:24, Jaegeuk Kim wrote:
> > On Fri, Jul 01, 2016 at 02:03:17PM +0800, Chao Yu wrote:
> >> Hi Jaegeuk,
> >>
> >> On 2016/7/1 8:03, Jaegeuk Kim wrote:
> >>> Hi Chao,
> >>>
> >>> On Thu, Jun 30, 2016 at 04:42:48PM +0800, Chao Yu wrote:
> >>>> Datas in file can be operated by GC and DIO simultaneously, so we will
> >>>> face race case as below:
> >>>>
> >>>> For write case:
> >>>> Thread A				Thread B
> >>>> - generic_file_direct_write
> >>>>  - invalidate_inode_pages2_range
> >>>>  - f2fs_direct_IO
> >>>>   - do_blockdev_direct_IO
> >>>>    - do_direct_IO
> >>>>     - get_more_blocks
> >>>> 					- f2fs_gc
> >>>> 					 - do_garbage_collect
> >>>> 					  - gc_data_segment
> >>>> 					   - move_data_page
> >>>> 					    - do_write_data_page
> >>>> 					    migrate data block to new block address
> >>>>    - dio_bio_submit
> >>>>    update user data to old block address
> >>>>
> >>>> For read case:
> >>>> Thread A                                Thread B
> >>>> - generic_file_direct_write
> >>>>  - invalidate_inode_pages2_range
> >>>>  - f2fs_direct_IO
> >>>>   - do_blockdev_direct_IO
> >>>>    - do_direct_IO
> >>>>     - get_more_blocks
> >>>> 					- f2fs_balance_fs
> >>>> 					 - f2fs_gc
> >>>> 					  - do_garbage_collect
> >>>> 					   - gc_data_segment
> >>>> 					    - move_data_page
> >>>> 					     - do_write_data_page
> >>>> 					     migrate data block to new block address
> >>>> 					  - write_checkpoint
> >>>> 					   - do_checkpoint
> >>>> 					    - clear_prefree_segments
> >>>> 					     - f2fs_issue_discard
> >>>>                                              discard old block adress
> >>>>    - dio_bio_submit
> >>>>    update user buffer from obsolete block address
> >>>>
> >>>> In order to fix this, for one file, we should let DIO and GC getting exclusion
> >>>> against with each other.
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>>  fs/f2fs/data.c  |  2 ++
> >>>>  fs/f2fs/f2fs.h  |  1 +
> >>>>  fs/f2fs/gc.c    | 14 +++++++++++++-
> >>>>  fs/f2fs/super.c |  1 +
> >>>>  4 files changed, 17 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>> index ba4963f..08dc060 100644
> >>>> --- a/fs/f2fs/data.c
> >>>> +++ b/fs/f2fs/data.c
> >>>> @@ -1716,7 +1716,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >>>>  
> >>>>  	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
> >>>>  
> >>>> +	mutex_lock(&F2FS_I(inode)->dio_mutex);
> >>>>  	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
> >>>> +	mutex_unlock(&F2FS_I(inode)->dio_mutex);
> >>>
> >>> This means we need to sacrifice entire parallism even in the normal cases?
> >>> Can we find another way?
> >>
> >> 1. For dio write vs dio write, writer will grab i_mutex before dio_mutex, so
> >> anyway, concurrent dio writes will be exclusive.
> >>
> >> 2. For dio write vs gc, keep using dio_mutex for making them exclusive.
> >>
> >> 3. For dio read vs dio read, and dio read vs gc, what about adding dio_rwsem to
> >> control the parallelism?
> >>
> >> 4. For dio write vs dio read, we grab different lock (write grabs dio_mutex,
> >> read grabs dio_rwsem), so there is no race condition.
> > 
> > How about adding a flag in a dio inode and avoiding GCs for there-in blocks?
> 
> Hmm.. IMO, without lock, it's hard to keep the sequence that let GC checking the
> flag after setting it, right?

Okay, could you add dio_rwsem for now?
Later, we may need to take a look at dio_overwrite case to mitigate inode_lock
contention likewise xfs. :)

Thanks,

> >>>
> >>>>  	if (iov_iter_rw(iter) == WRITE) {
> >>>>  		if (err > 0)
> >>>>  			set_inode_flag(inode, FI_UPDATE_WRITE);
> >>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>> index bd82b6d..a241576 100644
> >>>> --- a/fs/f2fs/f2fs.h
> >>>> +++ b/fs/f2fs/f2fs.h
> >>>> @@ -474,6 +474,7 @@ struct f2fs_inode_info {
> >>>>  	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
> >>>>  	struct mutex inmem_lock;	/* lock for inmemory pages */
> >>>>  	struct extent_tree *extent_tree;	/* cached extent_tree entry */
> >>>> +	struct mutex dio_mutex;		/* avoid racing between dio and gc */
> >>>>  };
> >>>>  
> >>>>  static inline void get_extent_info(struct extent_info *ext,
> >>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>>> index c2c4ac3..98e3763 100644
> >>>> --- a/fs/f2fs/gc.c
> >>>> +++ b/fs/f2fs/gc.c
> >>>> @@ -744,12 +744,24 @@ next_step:
> >>>>  		/* phase 3 */
> >>>>  		inode = find_gc_inode(gc_list, dni.ino);
> >>>>  		if (inode) {
> >>>> +			bool locked = false;
> >>>> +
> >>>> +			if (S_ISREG(inode->i_mode)) {
> >>>> +				if (!mutex_trylock(&F2FS_I(inode)->dio_mutex))
> >>>> +					continue;
> >>>> +				locked = true;
> >>>> +			}
> >>>> +
> >>>>  			start_bidx = start_bidx_of_node(nofs, inode)
> >>>>  								+ ofs_in_node;
> >>>> -			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> >>>> +			if (f2fs_encrypted_inode(inode) &&
> >>>> +							S_ISREG(inode->i_mode))
> >>>>  				move_encrypted_block(inode, start_bidx);
> >>>>  			else
> >>>>  				move_data_page(inode, start_bidx, gc_type);
> >>>> +			if (locked)
> >>>> +				mutex_unlock(&F2FS_I(inode)->dio_mutex);
> >>>> +
> >>>>  			stat_inc_data_blk_count(sbi, 1, gc_type);
> >>>>  		}
> >>>>  	}
> >>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>>> index 8c698e1..24aab3f 100644
> >>>> --- a/fs/f2fs/super.c
> >>>> +++ b/fs/f2fs/super.c
> >>>> @@ -575,6 +575,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
> >>>>  	INIT_LIST_HEAD(&fi->gdirty_list);
> >>>>  	INIT_LIST_HEAD(&fi->inmem_pages);
> >>>>  	mutex_init(&fi->inmem_lock);
> >>>> +	mutex_init(&fi->dio_mutex);
> >>>>  
> >>>>  	/* Will be used by directory only */
> >>>>  	fi->i_dir_level = F2FS_SB(sb)->dir_level;
> >>>> -- 
> >>>> 2.8.2.311.gee88674
> >>>
> >>> .
> >>>
> > 
> > .
> > 

------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
