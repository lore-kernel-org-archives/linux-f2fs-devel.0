From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH RESEND] f2fs: fix to restrict mount condition
 when without CONFIG_QUOTA
Date: Thu, 26 Jul 2018 09:41:55 +0800
Message-ID: <4b46f8b3-2858-a528-de53-c2de333c3314@huawei.com>
References: <20180725231948.18075-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fiVIE-0000YL-Ox
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 01:42:14 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fiVIC-000iUK-IS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 01:42:14 +0000
In-Reply-To: <20180725231948.18075-1-chao@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi, Chao

On 2018/7/26 7:19, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Like quota_ino feature, we need to reject mounting RDWR with image
> which enables project_quota feature when there is no CONFIG_QUOTA
> be set in kernel.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   fs/f2fs/super.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index dbc1cb53581f..bc7c14a055bb 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
>   			 "without CONFIG_QUOTA");
>   		return -EINVAL;
>   	}

I think the following should be checked within !CONFIG_QUOTA, like patch "f2fs: quota: do
not mount as RDWR without QUOTA if quota feature enabled" :)

thanks

> +	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
> +		f2fs_msg(sb, KERN_ERR,
> +			"Filesystem with project quota feature cannot be "
> +			"mounted RDWR without CONFIG_QUOTA");
> +		return -EINVAL;
> +	}
>   #endif
>   
>   	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
