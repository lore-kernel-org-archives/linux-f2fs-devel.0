From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs-tools: fix to match with the start_sector
Date: Sat, 26 May 2018 16:13:45 +0800
Message-ID: <cc0f0f06-18b7-92a5-cd43-825732cddcaf@huawei.com>
References: <1525425645-127945-1-git-send-email-yunlong.song@huawei.com>
 <1525659336-145433-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525659336-145433-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

ping...

On 2018/5/7 10:15, Yunlong Song wrote:
> f2fs-tools uses ioctl BLKSSZGET to get sector_size, however, this ioctl
> will return a value which may be larger than 512 (according to the value
> of q->limits.logical_block_size), then this will be inconsistent with
> the start_sector, since start_sector is got from ioctl HDIO_GETGEO and
> is always in 512 size unit for a sector. To fix this problem, just
> change the sector_size to the default value when computing with
> start_sector. And fix sectors_per_blk as well.
>
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fsck/resize.c      |  4 ++--
>   mkfs/f2fs_format.c | 12 ++++++------
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fsck/resize.c b/fsck/resize.c
> index d285dd7..ada2155 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -27,10 +27,10 @@ static int get_new_sb(struct f2fs_super_block *sb)
>   
>   	zone_size_bytes = segment_size_bytes * segs_per_zone;
>   	zone_align_start_offset =
> -		(c.start_sector * c.sector_size +
> +		(c.start_sector * DEFAULT_SECTOR_SIZE +
>   		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
>   		zone_size_bytes * zone_size_bytes -
> -		c.start_sector * c.sector_size;
> +		c.start_sector * DEFAULT_SECTOR_SIZE;
>   
>   	set_sb(segment_count, (c.target_sectors * c.sector_size -
>   				zone_align_start_offset) / segment_size_bytes /
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 0a99a77..ced5fea 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -212,18 +212,18 @@ static int f2fs_prepare_super_block(void)
>   	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
>   
>   	zone_align_start_offset =
> -		(c.start_sector * c.sector_size +
> +		(c.start_sector * DEFAULT_SECTOR_SIZE +
>   		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
>   		zone_size_bytes * zone_size_bytes -
> -		c.start_sector * c.sector_size;
> +		c.start_sector * DEFAULT_SECTOR_SIZE;
>   
> -	if (c.start_sector % c.sectors_per_blk) {
> +	if (c.start_sector % DEFAULT_SECTORS_PER_BLOCK) {
>   		MSG(1, "\t%s: Align start sector number to the page unit\n",
>   				c.zoned_mode ? "FAIL" : "WARN");
>   		MSG(1, "\ti.e., start sector: %d, ofs:%d (sects/page: %d)\n",
>   				c.start_sector,
> -				c.start_sector % c.sectors_per_blk,
> -				c.sectors_per_blk);
> +				c.start_sector % DEFAULT_SECTORS_PER_BLOCK,
> +				DEFAULT_SECTORS_PER_BLOCK);
>   		if (c.zoned_mode)
>   			return -1;
>   	}
> @@ -235,7 +235,7 @@ static int f2fs_prepare_super_block(void)
>   					get_sb(segment0_blkaddr));
>   
>   	if (c.zoned_mode && (get_sb(segment0_blkaddr) + c.start_sector /
> -					c.sectors_per_blk) % c.zone_blocks) {
> +					DEFAULT_SECTORS_PER_BLOCK) % c.zone_blocks) {
>   		MSG(1, "\tError: Unaligned segment0 block address %u\n",
>   				get_sb(segment0_blkaddr));
>   		return -1;

-- 
Thanks,
Yunlong Song
