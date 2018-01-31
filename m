From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add sanity check for quota sysfile ino
Date: Tue, 30 Jan 2018 17:35:56 -0800
Message-ID: <20180131013556.GE65489@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180129082933.64556-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eghJk-00062U-6h
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 01:36:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eghJi-0007ig-Uy
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 01:36:04 +0000
Content-Disposition: inline
In-Reply-To: <20180129082933.64556-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 01/29, Chao Yu wrote:
> Add missing sanity check for quota sysfile ino.

We don't need to limit the specific inode numbers for quota files, since
we may be able to set any inode numbers later. How about checkint the
numbers are allocated as quota?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 368f63d7bad2..6011071688ca 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2116,6 +2116,25 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  		return 1;
>  	}
>  
> +	/* check quota sysfile ino info */
> +	if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
> +		if (le32_to_cpu(raw_super->qf_ino[0]) != 4 ||
> +			le32_to_cpu(raw_super->qf_ino[1]) != 5) {
> +			f2fs_msg(sb, KERN_INFO,
> +				"Invalid Quota Ino: user_ino(%u), grp_ino(%u)",
> +				le32_to_cpu(raw_super->qf_ino[0]),
> +				le32_to_cpu(raw_super->qf_ino[1]));
> +			return 1;
> +		}
> +		if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA) &&
> +			le32_to_cpu(raw_super->qf_ino[2]) != 6) {
> +			f2fs_msg(sb, KERN_INFO,
> +				"Invalid Quota Ino: prj_ino(%u)",
> +				le32_to_cpu(raw_super->qf_ino[2]));
> +			return 1;
> +		}
> +	}
> +
>  	if (le32_to_cpu(raw_super->segment_count) > F2FS_MAX_SEGMENT) {
>  		f2fs_msg(sb, KERN_INFO,
>  			"Invalid segment count (%u)",
> -- 
> 2.15.0.55.gc2ece9dc4de6

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
