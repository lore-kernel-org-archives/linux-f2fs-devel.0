From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [dev-test][PATCH 1/2] f2fs: add a missing
 truncate_inode_pages_final
Date: Fri, 17 Mar 2017 09:49:55 +0800
Message-ID: <20170317014955.GA27379@jaegeuk.local>
References: <20170310095047.14540-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1coh1s-0007eE-Ey
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 01:50:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1coh1r-0003Ok-16
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 01:50:08 +0000
Content-Disposition: inline
In-Reply-To: <20170310095047.14540-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

I just hit this, so will pop the patch out.

[  870.158785] sysrq: SysRq : Show Blocked State
[  870.158991]   task                        PC stack   pid father
[  870.159024] kworker/u8:2    D    0   127      2 0x00000000
[  870.159033] Workqueue: writeback wb_workfn (flush-8:32)
[  870.159036] Call Trace:
[  870.159042]  __schedule+0x28e/0x8d0
[  870.159045]  schedule+0x36/0x80
[  870.159049]  io_schedule+0x16/0x40
[  870.159052]  wait_on_page_bit+0xf7/0x130
[  870.159054]  ? page_cache_tree_insert+0x120/0x120
[  870.159057]  truncate_inode_pages_range+0x4b0/0x930
[  870.159063]  truncate_inode_pages_final+0x4d/0x60
[  870.159073]  f2fs_drop_inode+0x1a0/0x290 [f2fs]
[  870.159075]  iput+0xf0/0x230
[  870.159083]  f2fs_sync_inode_meta+0x3f/0x100 [f2fs]
[  870.159090]  block_operations+0xfc/0x200 [f2fs]
[  870.159097]  ? f2fs_inode_dirtied+0x62/0xd0 [f2fs]
[  870.159106]  ? __insert_extent_tree+0xc0/0xf0 [f2fs]
[  870.159113]  write_checkpoint+0x9d/0xe50 [f2fs]
[  870.159121]  f2fs_gc+0x398/0x480 [f2fs]
[  870.159129]  ? write_data_page+0x68/0x90 [f2fs]
[  870.159137]  f2fs_balance_fs+0x132/0x150 [f2fs]
[  870.159145]  __write_data_page+0x111/0x5c0 [f2fs]
[  870.159153]  f2fs_write_cache_pages+0x23a/0x4a0 [f2fs]
[  870.159160]  f2fs_write_data_pages+0x9b/0x1d0 [f2fs]
[  870.159162]  ? set_page_dirty+0x5b/0xb0
[  870.159204]  ? update_inode+0x273/0x2e0 [f2fs]
[  870.159206]  do_writepages+0x1e/0x30
[  870.159208]  __writeback_single_inode+0x45/0x320
[  870.159211]  writeback_sb_inodes+0x266/0x5f0
[  870.159213]  __writeback_inodes_wb+0x92/0xc0
[  870.159215]  wb_writeback+0x268/0x300
[  870.159217]  ? get_nr_dirty_inodes+0x4c/0x70
[  870.159219]  wb_workfn+0x2df/0x410
[  870.159221]  process_one_work+0x1fc/0x4b0
[  870.159223]  worker_thread+0x4b/0x500
[  870.159224]  kthread+0x101/0x140
[  870.159226]  ? process_one_work+0x4b0/0x4b0
[  870.159227]  ? kthread_create_on_node+0x60/0x60
[  870.159229]  ret_from_fork+0x2c/0x40
[  870.159269] fsstress        D    0  3329   3328 0x000000

Thanks,

On 03/10, Yunlei He wrote:
> This patch add a missing truncate_inode_pages_final
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index cfb40d3..7ad2606 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -642,6 +642,8 @@ static int f2fs_drop_inode(struct inode *inode)
>  			if (f2fs_is_atomic_file(inode))
>  				drop_inmem_pages(inode);
>  
> +			truncate_inode_pages_final(&inode->i_data);
> +
>  			/* should remain fi->extent_tree for writepage */
>  			f2fs_destroy_extent_node(inode);
>  
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Announcing the Oxford Dictionaries API! The API offers world-renowned
> dictionary content that is easy and intuitive to access. Sign up for an
> account today to start using our lexical data to power your apps and
> projects. Get started today and enter our developer competition.
> http://sdm.link/oxford
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
