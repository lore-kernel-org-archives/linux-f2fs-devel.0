From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: move dir data flush to write
 checkpoint process
Date: Tue, 6 Nov 2018 17:19:36 +0800
Message-ID: <9645a434-87e9-bf24-7ad8-a908f7b479a7@huawei.com>
References: <1541471129-25373-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gJxWv-0003KN-E3
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Nov 2018 09:20:13 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gJxWg-002UTY-3d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Nov 2018 09:20:13 +0000
In-Reply-To: <1541471129-25373-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net



On 2018/11/6 10:25, Yunlei He wrote:
> This patch move dir data flush to write checkpoint process, by
> doing this, it may reduce some time for dir fsync.
> 
> pre:
> 	-f2fs_do_sync_file enter
> 		-file_write_and_wait_range  <- flush & wait
> 		-write_checkpoint
> 			-do_checkpoint	    <- wait all
> 	-f2fs_do_sync_file exit
> 
> now:
> 	-f2fs_do_sync_file enter
> 		-write_checkpoint
> 			-block_operations   <- flush dir & no wait
> 			-do_checkpoint	    <- wait all
> 	-f2fs_do_sync_file exit
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 88b1246..9eaf07f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -216,6 +216,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  
>  	trace_f2fs_sync_file_enter(inode);
>  
> +	if (S_ISDIR(inode->i_mode))
> +		goto go_write;

Not sure, will we skip calling f2fs_write_inode due to this check? so we
will miss some metadata update cached in inode cache?

Thanks,

> +
>  	/* if fdatasync is triggered, let's do in-place-update */
>  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
>  		set_inode_flag(inode, FI_NEED_IPU);
> 
