From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH v4] f2fs: fix to data block override node
 segment by mistake
Date: Mon, 4 Mar 2019 10:18:53 +0530
Message-ID: <20190304044853.GB8377@codeaurora.org>
References: <46bb1ca2-e768-274b-6d98-3ff4323abd1f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1h0fXH-0000Pk-ED
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 04:49:07 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h0fXF-009dMt-0b
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 04:49:07 +0000
Content-Disposition: inline
In-Reply-To: <46bb1ca2-e768-274b-6d98-3ff4323abd1f@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: zhengliang <zhengliang6@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Mar 04, 2019 at 09:32:25AM +0800, zhengliang wrote:
> v4: Rearrange the previous three versions.
> 
> The following scenario could lead to data block override by mistake.
> 
> TASK A            |  TASK kworker                                            |     TASK B                                            |       TASK C
>                   |                                                          |                                                       |
> open              |                                                          |                                                       |
> write             |                                                          |                                                       |
> close             |                                                          |                                                       |
>                   |  f2fs_write_data_pages                                   |                                                       |
>                   |    f2fs_write_cache_pages                                |                                                       |
>                   |      f2fs_outplace_write_data                            |                                                       |
>                   |        f2fs_allocate_data_block (get block in seg S,     |                                                       |
>                   |                                  S is full, and only     |                                                       |
>                   |                                  have this valid data    |                                                       |
>                   |                                  block)                  |                                                       |
>                   |          allocate_segment                                |                                                       |
>                   |          locate_dirty_segment (mark S as PRE)            |                                                       |

In Task kworker context, if there is one valid data block allocated from S, then how can
S be marked as PRE? Shouldn't it be DIRTY? Please clarify.

>                   |        f2fs_submit_page_write (submit but is not         |                                                       |
>                   |                                written on dev)           |                                                       |
> unlink            |                                                          |                                                       |
>  iput_final       |                                                          |                                                       |
>   f2fs_drop_inode |                                                          |                                                       |
>     f2fs_truncate |                                                          |                                                       |
>  (not evict)      |                                                          |                                                       |
>                   |                                                          | write_checkpoint                                      |
>                   |                                                          |  flush merged bio but not wait file data writeback    |
>                   |                                                          |  set_prefree_as_free (mark S as FREE)                 |
>                   |                                                          |                                                       | update NODE/DATA
>                   |                                                          |                                                       | allocate_segment (select S)
>                   |     writeback done                                       |                                                       |
> 
> So we need to guarantee io complete before truncate inode in f2fs_drop_inode.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
> --------
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index c46a1d43..60f0599 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -915,6 +915,10 @@ static int f2fs_drop_inode(struct inode *inode)
>                         sb_start_intwrite(inode->i_sb);
>                         f2fs_i_size_write(inode, 0);
> 
> +                       f2fs_submit_merged_write_cond(F2FS_I_SB(inode),
> +                                       inode, NULL, 0, DATA);
> +                       truncate_inode_pages_final(inode->i_mapping);
> +
>                         if (F2FS_HAS_BLOCKS(inode))
>                                 f2fs_truncate(inode);
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
