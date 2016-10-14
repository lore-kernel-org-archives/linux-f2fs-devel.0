From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH 2/2] f2fs: fix allocation failure
Date: Fri, 14 Oct 2016 22:09:29 +0800
Message-ID: <bdaa97c9-5c37-d210-13c8-c2ca009cf221@kernel.org>
References: <20161012161427.24419-1-chao@kernel.org>
	<20161012161427.24419-2-chao@kernel.org>
	<20161013204907.GC6363@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bv3BH-0007qG-9w
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 14:09:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bv3BF-0006ow-8q
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 14:09:51 +0000
In-Reply-To: <20161013204907.GC6363@jaegeuk>
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

On 2016/10/14 4:49, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Thu, Oct 13, 2016 at 12:14:27AM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> tests/generic/251 of fstest reports a f2fs bug in below message:
>>
>> ------------[ cut here ]------------
>> invalid opcode: 0000 [#1] PREEMPT SMP
>> CPU: 1 PID: 109 Comm: kworker/u8:2 Tainted: G        W  O    4.8.0-rc4+ #22
>> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>> Workqueue: writeback wb_workfn (flush-251:1)
>> task: f33c8000 task.stack: f33c6000
>> EIP: 0060:[<f8992139>] EFLAGS: 00010246 CPU: 1
>> EIP is at new_curseg+0x2c9/0x2d0 [f2fs]
>> EAX: 000003f3 EBX: ee3e5000 ECX: 00000400 EDX: 000003f3
>> ESI: 00000000 EDI: 00000008 EBP: f33c78c4 ESP: f33c7890
>>  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
>> CR0: 80050033 CR2: b6706000 CR3: 2e8d70c0 CR4: 000406f0
>> Stack:
>>  eb29480c 00000004 f27a0290 000003f3 00000008 f33c78c0 00000001 eb294800
>>  00000001 00000000 ee3e5000 f899dbb4 00000290 f33c7924 f89926d6 c10b42b6
>>  00000246 00000000 eed513e8 00000246 f33c78e8 c10b7b4b f33c7924 c178c304
>> Call Trace:
>>  [<f89926d6>] allocate_segment_by_default+0x3c6/0x3d0 [f2fs]
>>  [<f8992b3a>] allocate_data_block+0x13a/0x3c0 [f2fs]
>>  [<f8992e4b>] do_write_page+0x8b/0x230 [f2fs]
>>  [<f8993070>] write_node_page+0x20/0x30 [f2fs]
>>  [<f898a156>] f2fs_write_node_page+0x1a6/0x340 [f2fs]
>>  [<f898ca45>] sync_node_pages+0x4a5/0x590 [f2fs]
>>  [<f897ea48>] write_checkpoint+0x218/0x720 [f2fs]
>>  [<f898143d>] f2fs_gc+0x4cd/0x6b0 [f2fs]
>>  [<f8990ebe>] f2fs_balance_fs+0x18e/0x1b0 [f2fs]
>>  [<f8988017>] f2fs_write_data_page+0x197/0x6f0 [f2fs]
>>  [<f89830fe>] f2fs_write_data_pages+0x28e/0x7e0 [f2fs]
>>  [<c118b1cd>] do_writepages+0x1d/0x40
>>  [<c1228cb5>] __writeback_single_inode+0x55/0x7e0
>>  [<c1229b6b>] writeback_sb_inodes+0x21b/0x490
>>  [<c1229f6c>] wb_writeback+0xdc/0x590
>>  [<c122ae18>] wb_workfn+0xf8/0x690
>>  [<c107c231>] process_one_work+0x1a1/0x580
>>  [<c107c712>] worker_thread+0x102/0x440
>>  [<c1082021>] kthread+0xa1/0xc0
>>  [<c178f862>] ret_from_kernel_thread+0xe/0x24
>> EIP: [<f8992139>] new_curseg+0x2c9/0x2d0 [f2fs] SS:ESP 0068:f33c7890
>>
>> The reason is after f2fs enabled lazytime by default, when inode time is
>> changed, we do not set this inode dirty through ->f2fs_dirty_inode, so
>> itime updating will be delayed.
>>
>> Finally it needs to update the dirty time of inode into inode page,
>> and writeback the page, however, before that, we didn't count the inode
>> as imeta data. So f2fs won't be aware of dirty metadata page count is
>> exceeded watermark of GC, result in encountering panic when allocating
>> free segment.
>>
>> There is an easy way to produce this bug:
>> 1. mount with lazytime option
>> 2. fragment space
>> 3. touch all files in the image
>> 4. umount
> 
> I think modifying has_not_enough_secs() is enough like this.

Seems it won't solve this problem as I tested, the root cause here is that if
huge number of inode updates due to time changes, actually inodes won't be set
dirty as we return directly if flags is I_DIRTY_TIME in f2fs_dirty_inode, then
once inode cache is been shrunk, inodes in lru list will be set dirty in iput:

In iput()
		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
			atomic_inc(&inode->i_count);
			inode->i_state &= ~I_DIRTY_TIME;
			spin_unlock(&inode->i_lock);
			trace_writeback_lazytime_iput(inode);
			mark_inode_dirty_sync(inode);
			goto retry;

After that once someone calls write_checkpoint(), if number of dirty imeta data
is exceeded remain blocks in free segments, we will encounter this bug.

In order to fix this bug, I try to account these delayed dirtied inodes to
detect actual dirty metadata number, by this way we can set delayed dirtied
inode dirty and flush them in advance to avoid the dirty metadata number
exceeding blocks number in free segments, finally allocation failure issue can
be solved.

Thanks,

> 
> ---
>  fs/f2fs/segment.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index fecb856..a6efb5c 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -471,11 +471,12 @@ static inline bool need_SSR(struct f2fs_sb_info *sbi)
>  {
>  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
>  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> +	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
>  
>  	if (test_opt(sbi, LFS))
>  		return false;
>  
> -	return free_sections(sbi) <= (node_secs + 2 * dent_secs +
> +	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
>  						reserved_sections(sbi) + 1);
>  }
>  
> @@ -484,6 +485,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>  {
>  	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
>  	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> +	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
>  
>  	node_secs += get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
>  
> @@ -491,7 +493,8 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>  		return false;
>  
>  	return (free_sections(sbi) + freed) <=
> -		(node_secs + 2 * dent_secs + reserved_sections(sbi) + needed);
> +		(node_secs + 2 * dent_secs + imeta_secs +
> +		reserved_sections(sbi) + needed);
>  }
>  
>  static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
