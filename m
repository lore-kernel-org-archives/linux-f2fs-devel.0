From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: report error if quota off error
 during umount
Date: Thu, 21 Jun 2018 20:49:37 +0800
Message-ID: <c5686e40-93a2-667b-179c-777638e6a599@huawei.com>
References: <1529583633-20746-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVz2a-0004JD-Gl
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 12:50:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVz2X-002PRz-G8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 12:50:20 +0000
In-Reply-To: <1529583633-20746-1-git-send-email-heyunlei@huawei.com>
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

On 2018/6/21 20:20, Yunlei He wrote:
> Now, we depend on fsck to ensure quota file data is ok,
> so we scan whole partition if checkpoint without umount
> flag. It's same for quota off error case, which may make
> quota file data inconsistent.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/super.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 73d7d7e..679af0a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1820,7 +1820,9 @@ static int f2fs_quota_off(struct super_block *sb, int type)
>  	if (!inode || !igrab(inode))
>  		return dquot_quota_off(sb, type);
>  
> -	f2fs_quota_sync(sb, type);
> +	err = f2fs_quota_sync(sb, type);
> +	if (err)
> +		goto out_put;
>  
>  	err = dquot_quota_off(sb, type);
>  	if (err || f2fs_sb_has_quota_ino(sb))
> @@ -1839,9 +1841,18 @@ static int f2fs_quota_off(struct super_block *sb, int type)
>  void f2fs_quota_off_umount(struct super_block *sb)
>  {
>  	int type;
> +	int err;
>  
> -	for (type = 0; type < MAXQUOTAS; type++)
> -		f2fs_quota_off(sb, type);
> +	for (type = 0; type < MAXQUOTAS; type++) {
> +		err = f2fs_quota_off(sb, type);
> +		if (err) {
> +			f2fs_msg(sb, KERN_ERR,
> +				"Failed to off quota tracking "

Minor,

"Fail to turn off disk quota (type: %d, err: %d), run fsck to fix it." type, err)

Thanks,

> +				"(type=%d, err=%d). Please run "
> +				"fsck to fix.", type, err);
> +			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
> +		}
> +	}
>  }
>  
>  static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
