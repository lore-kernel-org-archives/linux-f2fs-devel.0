From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: show precise # of blocks that
 user/root can use
Date: Fri, 5 Jan 2018 15:05:07 +0800
Message-ID: <7206fb17-4785-756c-9fef-39565adf8780@huawei.com>
References: <20180103185845.29953-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eXM4W-00057c-W1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jan 2018 07:05:44 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eXM4V-0003Ji-9w
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jan 2018 07:05:44 +0000
In-Reply-To: <20180103185845.29953-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: "shengyong (A)" <shengyong1@huawei.com>, heyunlei@huawei.com, miaoxie@huawei.com

NACK

man statfs shows:

struct statfs {
     ...
     fsblkcnt_t   f_bfree;   /* free blocks in fs */
     fsblkcnt_t   f_bavail;  /* free blocks available to
                                     unprivileged user */
     ...
}

f_bfree is free blocks in fs, so buf->bfree should be

buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;

On 2018/1/4 2:58, Jaegeuk Kim wrote:
> Let's show precise # of blocks that user/root can use through bavail and bfree
> respectively.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0a820ba55b10..4c1c99cf54ef 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1005,9 +1005,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>   	buf->f_bsize = sbi->blocksize;
>   
>   	buf->f_blocks = total_count - start_count;
> -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
> -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
> +	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
>   						sbi->current_reserved_blocks;
> +	buf->f_bavail = buf->f_bfree;
>   
>   	avail_node_count = sbi->total_node_count - sbi->nquota_files -
>   						F2FS_RESERVED_NODE_NUM;

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
