From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: quota: fix incorrect error message
 and comments
Date: Wed, 25 Jul 2018 23:44:37 +0800
Message-ID: <95afcbba-32be-7433-7ea5-c48db148689e@kernel.org>
References: <20180724121754.19920-1-shengyong1@huawei.com>
 <20180724121754.19920-3-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fiLy8-0003Rg-Uc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Jul 2018 15:44:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fiLy7-000FjG-Iq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Jul 2018 15:44:52 +0000
In-Reply-To: <20180724121754.19920-3-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/24 20:17, Sheng Yong wrote:
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 5 ++++-
>  fs/f2fs/recovery.c   | 2 +-
>  fs/f2fs/super.c      | 5 +----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 9c29526a7633..9a0222d9e28c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -645,7 +645,10 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  	/* Needed for iput() to work correctly and not trash data */
>  	sbi->sb->s_flags |= SB_ACTIVE;
>  
> -	/* Turn on quotas so that they are updated correctly */
> +	/*
> +	 * Turn on quotas which were not enabled for read-only mounts if
> +	 * filesystem has quota feature, so that they are updated correctly.
> +	 */
>  	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & SB_RDONLY);
>  #endif
>  
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 0d927ae26c48..e93162a2e6d8 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -628,7 +628,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  #endif
>  
>  	if (s_flags & SB_RDONLY) {
> -		f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
> +		f2fs_msg(sbi->sb, KERN_INFO, "fsync data recover on readonly fs");

I remember Yunlei has fix this print info in another patch.

Thanks,

>  		sbi->sb->s_flags &= ~SB_RDONLY;
>  	}
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 4ed91ceab3ee..3e24dde60f54 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2970,10 +2970,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_root_inode;
>  
>  #ifdef CONFIG_QUOTA
> -	/*
> -	 * Turn on quotas which were not enabled for read-only mounts if
> -	 * filesystem has quota feature, so that they are updated correctly.
> -	 */
> +	/* Enable quota usage during mount */
>  	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
>  		err = f2fs_enable_quotas(sb);
>  		if (err) {
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
