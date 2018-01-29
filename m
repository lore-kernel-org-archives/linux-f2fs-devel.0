From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix potential corruption in area
 before F2FS_SUPER_OFFSET
Date: Mon, 29 Jan 2018 16:27:28 +0800
Message-ID: <247cff44-995a-bec0-7482-e0fe475f6dd5@huawei.com>
References: <20180129080418.33490-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eg4nE-0007XN-UX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 08:27:56 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eg4nD-0005ty-8s
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 08:27:56 +0000
In-Reply-To: <20180129080418.33490-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/1/29 16:04, Sheng Yong wrote:
> sb_getblk does not guarantee the buffer head is uptodate. If bh is not
> uptodate, the data (may be used as boot code) in area before

Why boot code can be stored into the position f2fs superblock locates?

And even we have updated the buffer, we will still commit superblock's
datas into that buffer, boot code can be messed up anyway, right?

Thanks,

> F2FS_SUPER_OFFSET may get corrupted when super block is committed.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8173ae688814..7def48cb2b22 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2334,7 +2334,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>  	}
>  
>  	/* write back-up superblock first */
> -	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0: 1);
> +	bh = sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
>  	if (!bh)
>  		return -EIO;
>  	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
> @@ -2345,7 +2345,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>  		return err;
>  
>  	/* write current valid superblock */
> -	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
> +	bh = sb_bread(sbi->sb, sbi->valid_super_block);
>  	if (!bh)
>  		return -EIO;
>  	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
