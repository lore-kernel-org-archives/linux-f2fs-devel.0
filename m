From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix use-after-free issue when
 accessing sbi->stat_info
Date: Wed, 26 Dec 2018 17:55:51 +0800
Message-ID: <7f89b0c1-fc5d-8c83-0ecc-0b0943b7be69@huawei.com>
References: <1545803429-14340-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gc5v3-0002In-Bz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Dec 2018 09:56:05 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gc5v1-001D2s-31
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Dec 2018 09:56:05 +0000
In-Reply-To: <1545803429-14340-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On 2018/12/26 13:50, Sahitya Tummala wrote:
> iput() on sbi->node_inode can update sbi->stat_info
> in the below context, if the f2fs_write_checkpoint()
> has failed with error.
> 
> f2fs_balance_fs_bg+0x1ac/0x1ec
> f2fs_write_node_pages+0x4c/0x260
> do_writepages+0x80/0xbc
> __writeback_single_inode+0xdc/0x4ac
> writeback_single_inode+0x9c/0x144
> write_inode_now+0xc4/0xec
> iput+0x194/0x22c
> f2fs_put_super+0x11c/0x1e8
> generic_shutdown_super+0x70/0xf4
> kill_block_super+0x2c/0x5c
> kill_f2fs_super+0x44/0x50
> deactivate_locked_super+0x60/0x8c
> deactivate_super+0x68/0x74
> cleanup_mnt+0x40/0x78
> 
> Fix this by moving f2fs_destroy_stats() further below iput() in
> both f2fs_put_super() and f2fs_fill_super() paths.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

It looks good to me now. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
