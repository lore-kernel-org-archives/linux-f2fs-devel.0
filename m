From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix race between write_checkpoint and
 write_begin
Date: Mon, 12 Nov 2018 23:12:24 +0800
Message-ID: <c798d917-2ff0-86df-ce97-c8b9eeb8ff65@kernel.org>
References: <20181112120128.96682-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gMDtW-0000qQ-Cl
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Nov 2018 15:12:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gMDtO-006kLH-FP
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Nov 2018 15:12:54 +0000
In-Reply-To: <20181112120128.96682-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, yuchao0@huawei.com, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018-11-12 20:01, Sheng Yong wrote:
> The following race could lead to inconsistent SIT bitmap:
> 
> Task A                          Task B
> ======                          ======
> f2fs_write_checkpoint
>   block_operations
>     f2fs_lock_all
>       down_write(node_change)
>       down_write(node_write)
>       ... sync ...
>       up_write(node_change)
>                                 f2fs_file_write_iter
>                                   set_inode_flag(FI_NO_PREALLOC)
>                                   ......
>                                   f2fs_write_begin(index=0, has inline data)
>                                     prepare_write_begin
>                                       __do_map_lock(AIO) => down_read(node_change)
>                                       f2fs_convert_inline_page => update SIT
>                                       __do_map_lock(AIO) => up_read(node_change)
>   f2fs_flush_sit_entries <= inconsistent SIT
>   finish write checkpoint
>   sudden-power-off
> 
> If SPO occurs after checkpoint is finished, SIT bitmap will be set
> incorrectly. This patch uses node_write to avoid the race condition.

Good catch!

> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 106f116466bf..dc5b251aee86 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2355,7 +2355,9 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>  			if (inode->i_nlink)
>  				set_inline_node(ipage);
>  		} else {
> +			down_read(&sbi->node_write);

This makes lock dependence more complicated, how about calling f2fs_lock_op for
inline data conversion case:

        struct extent_info ei = {0,0,0};
+       int flag;
        int err = 0;

-       if (f2fs_has_inline_data(inode) ||
-                       (pos & PAGE_MASK) >= i_size_read(inode)) {
-               __do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+       if (f2fs_has_inline_data(inode)) {
+               if (pos + len > MAX_INLINE_DATA(inode))
+                       flag = F2FS_GET_BLOCK_PRE_DIO;
+               else if (pos & PAGE_MASK) >= i_size_read(inode))
+                       flag = F2FS_GET_BLOCK_PRE_AIO;
+               __do_map_lock(sbi, flag, true);

                        if (err || dn.data_blkaddr == NULL_ADDR) {
                                f2fs_put_dnode(&dn);
-                               __do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
-                                                               true);
+                               flag = F2FS_GET_BLOCK_PRE_AIO;
+                               __do_map_lock(sbi, flag, true);
                                locked = true;

 unlock_out:
        if (locked)
-               __do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+               __do_map_lock(sbi, flag, false);

Thanks,

>  			err = f2fs_convert_inline_page(&dn, page);
> +			up_read(&sbi->node_write);
>  			if (err)
>  				goto out;
>  			if (dn.data_blkaddr == NULL_ADDR)
> 
