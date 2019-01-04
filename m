From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs-dev: support multi-device direct IO
Date: Fri, 4 Jan 2019 11:04:06 +0800
Message-ID: <d38a6442-cb0e-2e77-62e6-31c9e71fb636@huawei.com>
References: <20190102090659.7974-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102090659.7974-1-sunqiuyang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/1/2 17:06, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> The physical blocks in struct f2fs_map_blocks must be in the same device.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> ---
>  fs/f2fs/data.c | 20 +++++++++++++++++++-
>  fs/f2fs/f2fs.h |  2 --
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e5cd3fd..7a6369e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1076,6 +1076,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	struct extent_info ei = {0,0,0};
>  	block_t blkaddr;
>  	unsigned int start_pgofs;
> +	int devi;
> +	block_t end_blk;
>  
>  	if (!maxblocks)
>  		return 0;
> @@ -1207,8 +1209,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  
>  		map->m_pblk = blkaddr;
>  		map->m_len = 1;
> +
> +		if (sbi->s_ndevs && blkaddr != NEW_ADDR &&
> +							blkaddr != NULL_ADDR) {

int devi;

devi = f2fs_target_device_index(sbi, blkaddr);

> +			devi = f2fs_target_device_index(sbi, blkaddr);
> +			end_blk = FDEV(devi).end_blk;
> +		}
>  	} else if ((map->m_pblk != NEW_ADDR &&
> -			blkaddr == (map->m_pblk + ofs)) ||
> +			blkaddr == (map->m_pblk + ofs) &&
> +			(!sbi->s_ndevs || blkaddr <= end_blk)) ||
>  			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
>  			flag == F2FS_GET_BLOCK_PRE_DIO) {
>  		ofs++;
> @@ -1322,6 +1331,8 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  {
>  	struct f2fs_map_blocks map;
>  	int err;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int devi;
>  
>  	map.m_lblk = iblock;
>  	map.m_len = bh->b_size >> inode->i_blkbits;
> @@ -1333,6 +1344,13 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  	err = f2fs_map_blocks(inode, &map, create, flag);
>  	if (!err) {
>  		map_bh(bh, inode->i_sb, map.m_pblk);
> +		if (sbi->s_ndevs) {

struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
int devi;

> +			devi = f2fs_target_device_index(sbi, map.m_pblk);
> +			if (devi) {

Is it possible that devi == 0?

> +				bh->b_bdev = FDEV(devi).bdev;
> +				bh->b_blocknr -= FDEV(devi).start_blk;
> +			}
> +		}
>  		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
>  		bh->b_size = (u64)map.m_len << inode->i_blkbits;

For the write IO, we need to call update_device_state() to set dirty flag
in current device, in order to trigger flush command on right device during
fsync/fdatasync.

Thanks,

>  	}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eeede26..b311471 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3595,8 +3595,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  
>  	if (f2fs_post_read_required(inode))
>  		return true;
> -	if (sbi->s_ndevs)
> -		return true;
>  	/*
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>  	 * all IOs can be serialized by log-structured write.
> 
