From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: change the codes of checking CP_CRC_RECOVERY_FLAG
 to macro
Date: Fri, 24 Feb 2017 18:29:48 +0800
Message-ID: <096f8d0b-774c-2065-db96-dde455a4ec53@huawei.com>
References: <1487930771-14491-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1487930771-14491-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, cm224.lee@samsung.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com
Cc: bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/2/24 18:06, Yunlong Song wrote:
> No need to check the "if" condition each time, just change it to macro codes.

We're going to check flag in CP, not just in code of f2fs.

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/node.h    | 20 ++++++++++----------
>  fs/f2fs/segment.c |  5 +++--
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 3fc9c4b..3e5a58b 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -303,11 +303,11 @@ static inline void fill_node_footer_blkaddr(struct page *page, block_t blkaddr)
>  	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
>  	__u64 cp_ver = le64_to_cpu(ckpt->checkpoint_ver);
>  
> -	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
> -		__u64 crc = le32_to_cpu(*((__le32 *)
> -				((unsigned char *)ckpt + crc_offset)));
> -		cp_ver |= (crc << 32);
> -	}
> +#ifdef CP_CRC_RECOVERY_FLAG
> +	__u64 crc = le32_to_cpu(*((__le32 *)
> +			((unsigned char *)ckpt + crc_offset)));
> +	cp_ver |= (crc << 32);
> +#endif
>  	rn->footer.cp_ver = cpu_to_le64(cp_ver);
>  	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
>  }
> @@ -318,11 +318,11 @@ static inline bool is_recoverable_dnode(struct page *page)
>  	size_t crc_offset = le32_to_cpu(ckpt->checksum_offset);
>  	__u64 cp_ver = cur_cp_version(ckpt);
>  
> -	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
> -		__u64 crc = le32_to_cpu(*((__le32 *)
> -				((unsigned char *)ckpt + crc_offset)));
> -		cp_ver |= (crc << 32);
> -	}
> +#ifdef CP_CRC_RECOVERY_FLAG
> +	__u64 crc = le32_to_cpu(*((__le32 *)
> +			((unsigned char *)ckpt + crc_offset)));
> +	cp_ver |= (crc << 32);
> +#endif
>  	return cp_ver == cpver_of_node(page);
>  }
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9eb6d89..6c2e1ee 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1573,9 +1573,10 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
>  {
>  	if (force)
>  		new_curseg(sbi, type, true);
> -	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
> -					type == CURSEG_WARM_NODE)
> +#ifndef CP_CRC_RECOVERY_FLAG
> +	else if (type == CURSEG_WARM_NODE)
>  		new_curseg(sbi, type, false);
> +#endif
>  	else if (need_SSR(sbi) && get_ssr_segment(sbi, type))
>  		change_curseg(sbi, type, true);
>  	else
> 
