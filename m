From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: check and fix i_namelen to avoid double free
Date: Fri, 15 Dec 2017 18:01:53 +0800
Message-ID: <506aa086-5cba-a2ee-332d-07e79e5aa764@huawei.com>
References: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net



On 2017/12/15 14:25, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fsck/fsck.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 2212aa3..8ff4e4b 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -643,7 +643,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>   	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
>   	int ofs = get_extra_isize(node_blk);
>   	unsigned char *en;
> -	int namelen;
> +	int namelen, i_namelen;
>   	unsigned int idx = 0;
>   	int need_fix = 0;
>   	int ret;
> @@ -850,8 +850,21 @@ skip_blkcnt_fix:
>   	en = malloc(F2FS_NAME_LEN + 1);
>   	ASSERT(en);
>   
> -	namelen = convert_encrypted_name(node_blk->i.i_name,
> -					le32_to_cpu(node_blk->i.i_namelen),
> +	i_namelen = le32_to_cpu(node_blk->i.i_namelen);
> +	namelen = strlen((const char *)node_blk->i.i_name);
Hi, Yunlong
The strlen doesn't work for encrypted i_name. strlen may get a wrong namelen.

thanks,
Sheng
> +	if (i_namelen > F2FS_NAME_LEN) {
> +		ASSERT_MSG("ino: 0x%x has i_namelen: 0x%x, "
> +				"but has %d characters for name",
> +				nid, i_namelen, namelen);
> +		if (c.fix_on) {
> +			FIX_MSG("[0x%x] i_namelen=0x%x -> 0x%x", nid, i_namelen,
> +				namelen);
> +			node_blk->i.i_namelen = cpu_to_le32(namelen);
> +			need_fix = 1;
> +		}
> +		i_namelen = namelen;
> +	}
> +	namelen = convert_encrypted_name(node_blk->i.i_name, i_namelen,
>   					en, file_enc_name(&node_blk->i));
>   	en[namelen] = '\0';
>   	if (ftype == F2FS_FT_ORPHAN)
> 
