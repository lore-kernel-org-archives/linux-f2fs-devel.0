From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v3] f2fs: fix to avoid data update racing
 between GC and DIO
Date: Fri, 8 Jul 2016 23:50:02 +0800
Message-ID: <5f133653-face-a3ba-9fb4-cd0ac3239099@kernel.org>
References: <1467866952-10863-1-git-send-email-chao@kernel.org>
	<20160708031916.GA94348@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bLY2r-0004Mr-JE
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jul 2016 15:50:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bLY2p-0006du-QC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 08 Jul 2016 15:50:25 +0000
In-Reply-To: <20160708031916.GA94348@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2016/7/8 11:19, Jaegeuk Kim wrote:
> Hi Chao,
> 
> Could you take a look at this in xfstests/generic/013?
> 
> [  502.480850] ======================================================
> [  502.480864] [ INFO: possible circular locking dependency detected ]
> [  502.480877] 4.7.0-rc1+ #124 Tainted: G           OE  
> [  502.480886] -------------------------------------------------------
> [  502.480897] fsstress/10729 is trying to acquire lock:
> [  502.480906]  (&sb->s_type->i_mutex_key#18){+.+.+.}, at: [<ffffffff81299c3b>] do_blockdev_direct_IO+0x1db/0x2310
> [  502.480948] 
> [  502.480948] but task is already holding lock:
> [  502.480959]  (&fi->dio_rwsem){.+.+.+}, at: [<ffffffffc081e2b1>] f2fs_direct_IO+0xd1/0x3d0 [f2fs]
> [  502.481003] 
> [  502.481003] which lock already depends on the new lock.
> [  502.481003] 
> [  502.481018] 
> [  502.481018] the existing dependency chain (in reverse order) is:
> [  502.481030] 
> [  502.481030] -> #1 (&fi->dio_rwsem){.+.+.+}:
> [  502.481054]        [<ffffffff810e51c3>] lock_acquire+0xd3/0x220
> [  502.481071]        [<ffffffff818d1921>] down_read+0x51/0xa0
> [  502.481089]        [<ffffffffc081e2b1>] f2fs_direct_IO+0xd1/0x3d0 [f2fs]
> [  502.481114]        [<ffffffff811c34c7>] generic_file_direct_write+0xa7/0x160
> [  502.481133]        [<ffffffff811c363d>] __generic_file_write_iter+0xbd/0x1e0
> [  502.481149]        [<ffffffffc080437b>] f2fs_file_write_iter+0xdb/0x100 [f2fs]
> [  502.481173]        [<ffffffff81253a88>] __vfs_write+0xc8/0x140
> [  502.481190]        [<ffffffff81254c55>] vfs_write+0xb5/0x1b0
> [  502.481205]        [<ffffffff81255fe9>] SyS_write+0x49/0xa0
> [  502.481220]        [<ffffffff818d4100>] entry_SYSCALL_64_fastpath+0x23/0xc1
> [  502.481236] 
> [  502.481236] -> #0 (&sb->s_type->i_mutex_key#18){+.+.+.}:
> [  502.481264]        [<ffffffff810e481c>] __lock_acquire+0x161c/0x1940
> [  502.481280]        [<ffffffff810e51c3>] lock_acquire+0xd3/0x220
> [  502.481296]        [<ffffffff818d1b9a>] down_write+0x5a/0xc0
> [  502.481312]        [<ffffffff81299c3b>] do_blockdev_direct_IO+0x1db/0x2310
> [  502.481328]        [<ffffffff8129bdaa>] __blockdev_direct_IO+0x3a/0x40
> [  502.481344]        [<ffffffffc081e2e4>] f2fs_direct_IO+0x104/0x3d0 [f2fs]
> [  502.481368]        [<ffffffff811c40a9>] generic_file_read_iter+0x689/0x7e0
> [  502.481384]        [<ffffffff812545d1>] __vfs_read+0xc1/0x130
> [  502.481399]        [<ffffffff81254af1>] vfs_read+0x91/0x140
> [  502.481414]        [<ffffffff81255f49>] SyS_read+0x49/0xa0
> [  502.481429]        [<ffffffff818d4100>] entry_SYSCALL_64_fastpath+0x23/0xc1
> [  502.481445] 
> [  502.481445] other info that might help us debug this:
> [  502.481445] 
> [  502.481459]  Possible unsafe locking scenario:
> [  502.481459] 
> [  502.481726]        CPU0                    CPU1
> [  502.481987]        ----                    ----
> [  502.482242]   lock(&fi->dio_rwsem);
> [  502.482501]                                lock(&sb->s_type->i_mutex_key#18);
> [  502.482765]                                lock(&fi->dio_rwsem);
> [  502.483025]   lock(&sb->s_type->i_mutex_key#18);

Seems we will suffer ABBA deadlock:

writer					reader
- f2fs_file_write_iter
 - down_write(&inode->i_rwsem)
 - __generic_file_write_iter
  - generic_file_direct_write
   - f2fs_direct_IO
					- generic_file_read_iter
					 - f2fs_direct_IO
					 - down_read(&fi->dio_rwsem)
					  - __blockdev_direct_IO
					   - do_blockdev_direct_IO
					    - down_write(&inode->i_rwsem)
					
    - down_read(&fi->dio_rwsem)

What about splitting dio_rwsem to rdio_rwsem/wdio_rwsem for reader/writer to
avoid deadlock?

Thanks,

> [  502.483285] 
> [  502.483285]  *** DEADLOCK ***
> [  502.483285] 
> [  502.484018] 1 lock held by fsstress/10729:
> [  502.484262]  #0:  (&fi->dio_rwsem){.+.+.+}, at: [<ffffffffc081e2b1>] f2fs_direct_IO+0xd1/0x3d0 [f2fs]
> 
> Thanks,
> 
> On Thu, Jul 07, 2016 at 12:49:12PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Datas in file can be operated by GC and DIO simultaneously, so we will
>> face race case as below:
>>
>> For write case:
>> Thread A				Thread B
>> - generic_file_direct_write
>>  - invalidate_inode_pages2_range
>>  - f2fs_direct_IO
>>   - do_blockdev_direct_IO
>>    - do_direct_IO
>>     - get_more_blocks
>> 					- f2fs_gc
>> 					 - do_garbage_collect
>> 					  - gc_data_segment
>> 					   - move_data_page
>> 					    - do_write_data_page
>> 					    migrate data block to new block address
>>    - dio_bio_submit
>>    update user data to old block address
>>
>> For read case:
>> Thread A                                Thread B
>> - generic_file_direct_write
>>  - invalidate_inode_pages2_range
>>  - f2fs_direct_IO
>>   - do_blockdev_direct_IO
>>    - do_direct_IO
>>     - get_more_blocks
>> 					- f2fs_balance_fs
>> 					 - f2fs_gc
>> 					  - do_garbage_collect
>> 					   - gc_data_segment
>> 					    - move_data_page
>> 					     - do_write_data_page
>> 					     migrate data block to new block address
>> 					  - write_checkpoint
>> 					   - do_checkpoint
>> 					    - clear_prefree_segments
>> 					     - f2fs_issue_discard
>>                                              discard old block adress
>>    - dio_bio_submit
>>    update user buffer from obsolete block address
>>
>> In order to fix this, for one file, we should let DIO and GC getting exclusion
>> against with each other.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v3: use semaphore to avoid racing in between read dio and write dio.
>>  fs/f2fs/data.c  |  4 ++++
>>  fs/f2fs/f2fs.h  |  1 +
>>  fs/f2fs/gc.c    | 13 +++++++++++++
>>  fs/f2fs/super.c |  1 +
>>  4 files changed, 19 insertions(+)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index b6fd5bd..19197bb 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1712,6 +1712,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>  {
>>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>>  	struct inode *inode = mapping->host;
>> +	struct f2fs_inode_info *fi = F2FS_I(inode);
>>  	size_t count = iov_iter_count(iter);
>>  	loff_t offset = iocb->ki_pos;
>>  	int err;
>> @@ -1727,7 +1728,10 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>  
>>  	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
>>  
>> +	down_read(&fi->dio_rwsem);
>>  	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
>> +	up_read(&fi->dio_rwsem);
>> +
>>  	if (iov_iter_rw(iter) == WRITE) {
>>  		if (err > 0)
>>  			set_inode_flag(inode, FI_UPDATE_WRITE);
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index bf9a13a..2e439ec 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -474,6 +474,7 @@ struct f2fs_inode_info {
>>  	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
>>  	struct mutex inmem_lock;	/* lock for inmemory pages */
>>  	struct extent_tree *extent_tree;	/* cached extent_tree entry */
>> +	struct rw_semaphore dio_rwsem;	/* avoid racing between dio and gc */
>>  };
>>  
>>  static inline void get_extent_info(struct extent_info *ext,
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index c612137..a9bfb8d 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -755,12 +755,25 @@ next_step:
>>  		/* phase 3 */
>>  		inode = find_gc_inode(gc_list, dni.ino);
>>  		if (inode) {
>> +			struct f2fs_inode_info *fi = F2FS_I(inode);
>> +			bool locked = false;
>> +
>> +			if (S_ISREG(inode->i_mode)) {
>> +				if (!down_write_trylock(&fi->dio_rwsem))
>> +					continue;
>> +				locked = true;
>> +			}
>> +
>>  			start_bidx = start_bidx_of_node(nofs, inode)
>>  								+ ofs_in_node;
>>  			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
>>  				move_encrypted_block(inode, start_bidx);
>>  			else
>>  				move_data_page(inode, start_bidx, gc_type);
>> +
>> +			if (locked)
>> +				up_write(&fi->dio_rwsem);
>> +
>>  			stat_inc_data_blk_count(sbi, 1, gc_type);
>>  		}
>>  	}
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index edd1b35..dde57fb 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -579,6 +579,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>>  	INIT_LIST_HEAD(&fi->gdirty_list);
>>  	INIT_LIST_HEAD(&fi->inmem_pages);
>>  	mutex_init(&fi->inmem_lock);
>> +	init_rwsem(&fi->dio_rwsem);
>>  
>>  	/* Will be used by directory only */
>>  	fi->i_dir_level = F2FS_SB(sb)->dir_level;
>> -- 
>> 2.7.2

------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
