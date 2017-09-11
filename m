From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: support CP_CRC_RECOVERY_FLAG check
Date: Mon, 11 Sep 2017 18:32:13 +0800
Message-ID: <ff7842f7-6781-01e7-258b-d1b6dc844774@huawei.com>
References: <1504794297-150702-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504794297-150702-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

Do we need to recover other flags?

Thanks,

On 2017/9/7 22:24, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fsck/fsck.c  | 3 +++
>  fsck/mount.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index cb341ba..f63a609 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -1786,6 +1786,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
>  	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
>  
>  	flags = update_nat_bits_flags(sb, cp, flags);
> +
> +	if (is_set_ckpt_flags(cp, CP_CRC_RECOVERY_FLAG))
> +		flags |= CP_CRC_RECOVERY_FLAG;
>  	set_cp(ckpt_flags, flags);
>  
>  	set_cp(free_segment_count, get_free_segments(sbi));
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 7a8aeae..0d77cce 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1902,6 +1902,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
>  
>  	flags = update_nat_bits_flags(sb, cp, flags);
> +
> +	if (is_set_ckpt_flags(cp, CP_CRC_RECOVERY_FLAG))
> +		flags |= CP_CRC_RECOVERY_FLAG;
>  	set_cp(ckpt_flags, flags);
>  
>  	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
> 
