From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: no need to take the address of the
 array of sb->s_uuid
Date: Wed, 4 Apr 2018 20:54:44 -0700
Message-ID: <20180405035444.GD50337@jaegeuk-macbookpro.roam.corp.google.com>
References: <df2be96b-c613-def5-98e2-ed310e0b2f4b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f3vzA-0003aa-2Q
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 03:54:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3vz8-003lMV-Lb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 03:54:51 +0000
Content-Disposition: inline
In-Reply-To: <df2be96b-c613-def5-98e2-ed310e0b2f4b@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Gao Xiang <gaoxiang25@huawei.com>
Cc: Gao Xiang <hsiangkao@aol.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Gao,

Could you please check your email settings?
It's broken.

Thanks,

On 04/05, Gao Xiang wrote:
> Keep in line with the common case since it is some weird
> to take the address of an array again.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 42d564c5ccd0..f864ab702fa2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2701,7 +2701,7 @@ static int f2fs_fill_super(struct super_block *sb,
> void *data, int silent)
>  	sb->s_time_gran = 1;
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
> -	memcpy(&sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
> +	memcpy(sb->s_uuid, raw_super->uuid, sizeof(raw_super->uuid));
>  	sb->s_iflags |= SB_I_CGROUPWB;
>   	/* init f2fs-specific super block info */
> -- 
> 2.12.2

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
