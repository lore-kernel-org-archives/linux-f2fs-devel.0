From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: show # of dirty segments via sysfs
Date: Tue, 24 Oct 2017 17:47:23 +0800
Message-ID: <89adc713-6bbf-a237-07ce-eb7597c3235e@huawei.com>
References: <20171024083649.80404-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171024083649.80404-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/24 16:36, Jaegeuk Kim wrote:
> This patch adds one sysfs entry to show # of dirty segments which can be
> used for gc timing by user.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/sysfs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index ca74bfdfd4eb..e09e59cc678a 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -63,6 +63,13 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
>  	return NULL;
>  }
>  
> +static ssize_t dirty_segments_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +		(unsigned long long)(dirty_segments(sbi)));
> +}
> +
>  static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -283,6 +290,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
>  F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
>  F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
>  #endif
> +F2FS_GENERAL_RO_ATTR(dirty_segments);
>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
>  F2FS_GENERAL_RO_ATTR(features);
>  
> @@ -326,6 +334,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(inject_rate),
>  	ATTR_LIST(inject_type),
>  #endif
> +	ATTR_LIST(dirty_segments),
>  	ATTR_LIST(lifetime_write_kbytes),
>  	ATTR_LIST(features),
>  	ATTR_LIST(reserved_blocks),
> 
