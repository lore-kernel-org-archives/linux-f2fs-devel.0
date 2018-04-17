From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: allocate hot_data for atomic write
 more strictly
Date: Tue, 17 Apr 2018 16:30:45 +0800
Message-ID: <16d8fe6b-5e48-2723-b7df-7f199ecb499c@huawei.com>
References: <1523878456-5058-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f8M3h-0006ty-3e
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 08:33:49 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8M1B-008sDl-Kk
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 08:33:49 +0000
In-Reply-To: <1523878456-5058-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/4/16 19:34, Yunlei He wrote:
> If a file not set type as hot, has dirty pages more than
> threshold 64 before starting atomic write, may be lose hot
> flag.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 79eeed5..bf61e20 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1685,7 +1685,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  		goto out;
>  
>  	set_inode_flag(inode, FI_ATOMIC_FILE);

How about moving this below inc_stat tag? If there is still dirty page, for
reclaim path, we may redirty page with atomic write mode, we need to avoid that.

> -	set_inode_flag(inode, FI_HOT_DATA);
>  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);

Ditto.

Thanks,

>  
>  	if (!get_dirty_pages(inode))
> @@ -1697,11 +1696,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (ret) {
>  		clear_inode_flag(inode, FI_ATOMIC_FILE);
> -		clear_inode_flag(inode, FI_HOT_DATA);
>  		goto out;
>  	}
>  
>  inc_stat:
> +	set_inode_flag(inode, FI_HOT_DATA);
>  	F2FS_I(inode)->inmem_task = current;
>  	stat_inc_atomic_write(inode);
>  	stat_update_max_atomic_write(inode);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
