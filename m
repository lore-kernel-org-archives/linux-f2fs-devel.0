From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] f2fs: fix 32-bit build
Date: Tue, 22 Nov 2016 23:27:00 +0900
Message-ID: <896398fe-d971-1166-faa8-de2ff005cc70@wdc.com>
References: <20161122142033.1680054-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122142033.1680054-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>, Fan Li <fanofcode.li@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


Arnd,

> Unfortunately, the sector number is usually a 64-bit number, and
> we probably can't guarantee that bdev_zone_size() returns a
> power-of-two number, so we actually have to do the expensive 64-bit
> operation to get the remainder.

No, the zone size is guaranteed to be a power of 2. See sd_zbc.c in Jens
linux-block tree, branch for-4.10/block. So it is ok to do a
& (bdev_zone_size() - 1) for the remainder.

That was indeed my mistake in this patch. Modulo should not have been
used in the first place. My bad.

> 
> Fixes: 792b84b74b54 ("f2fs: support multiple devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/f2fs/segment.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 634834e5a232..e4c5497aa172 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -685,6 +685,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>  {
>  	sector_t nr_sects = SECTOR_FROM_BLOCK(blklen);
>  	sector_t sector;
> +	u32 rem;
>  	int devi = 0;
>  
>  	if (sbi->s_ndevs) {
> @@ -693,7 +694,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>  	}
>  	sector = SECTOR_FROM_BLOCK(blkstart);
>  
> -	if (sector % bdev_zone_size(bdev) || nr_sects != bdev_zone_size(bdev)) {
> +	div_u64_rem(sector, bdev_zone_size(bdev), &rem);
> +	if (rem || nr_sects != bdev_zone_size(bdev)) {
>  		f2fs_msg(sbi->sb, KERN_INFO,
>  			"(%d) %s: Unaligned discard attempted (block %x + %x)",
>  			devi, sbi->s_ndevs ? FDEV(devi).path: "",

Thanks !

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr Manager, System Software Research Group,
Western Digital
Damien.LeMoal@hgst.com
Tel: (+81) 0466-98-3593 (Ext. 51-3593)
1 kirihara-cho, Fujisawa, Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
