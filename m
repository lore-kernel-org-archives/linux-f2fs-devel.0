From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: change the codes of checking
 CP_CRC_RECOVERY_FLAG to macro
Date: Sat, 25 Feb 2017 10:46:19 -0800
Message-ID: <20170225184619.GC51627@jaegeuk.local>
References: <1487930771-14491-1-git-send-email-yunlong.song@huawei.com>
 <1488009678-17334-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488009678-17334-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/25, Yunlong Song wrote:
> No need to check the "if" condition each time, just change it to macro codes.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/node.h    | 10 +++++-----
>  fs/f2fs/segment.c |  5 +++--
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 3fc9c4b..caebb23 100644
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

NAK.
This is not a kernel config, nor a recommendable coding style.
Moreover, it is simply able to be defined through header file in old kernel.

Thanks,

> +	__u64 crc = le32_to_cpu(*((__le32 *)
> +			((unsigned char *)ckpt + crc_offset)));
> +	cp_ver |= (crc << 32);
> +#endif
>  	rn->footer.cp_ver = cpu_to_le64(cp_ver);
>  	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
>  }
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
> -- 
> 1.8.5.2
