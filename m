From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 2/8] fsck.f2fs: do not fix corrupted nat
 entries in build_nat_area_bitmap
Date: Tue, 31 Oct 2017 15:20:32 +0800
Message-ID: <3f115971-e992-2382-8aca-9a77cfc3558d@huawei.com>
References: <20171031013824.46544-1-shengyong1@huawei.com>
 <20171031013824.46544-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e9Qrz-0003p9-0x
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 07:21:55 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e9Qrx-00080C-L6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 07:21:54 +0000
In-Reply-To: <20171031013824.46544-2-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 9:38, Sheng Yong wrote:
> Fixing corrupted data depends on c.fix_on. If it's not set, we should not
> force fixing corrupted data.  So if nat entries are found invalid when
> building nat_area_bitmap, we should just set c.bug_on, and fix it later.

It looks comments and code change doesn't match? do you mean

@@ -2031,7 +2032,6 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 				 */
 				ASSERT_MSG("Invalid nat entry[0]: "
 					"blk_addr[0x%x]\n", ni.blk_addr);
-				c.fix_on = 1;
 				fsck->chk.valid_nat_entry_cnt--;
 			}

Thanks,

> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fsck/mount.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index faa9bc8..2d51678 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1877,9 +1877,15 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
>  	ret = dev_read_block(nat_block, block_addr);
>  	ASSERT(ret >= 0);
>  
> -	memset(&nat_block->entries[entry_off], 0,
> +	if (nid == F2FS_NODE_INO(sbi) || nid == F2FS_META_INO(sbi)) {
> +		FIX_MSG("nid [0x%x] block_addr= 0x%x -> 0x1", nid,
> +			le32_to_cpu(nat_block->entries[entry_off].block_addr));
> +		nat_block->entries[entry_off].block_addr = cpu_to_le32(0x1);
> +	} else {
> +		memset(&nat_block->entries[entry_off], 0,
>  					sizeof(struct f2fs_nat_entry));
> -	FIX_MSG("Remove nid [0x%x] in NAT\n", nid);
> +		FIX_MSG("Remove nid [0x%x] in NAT\n", nid);
> +	}
>  
>  	ret = dev_write_block(nat_block, block_addr);
>  	ASSERT(ret >= 0);
> @@ -2001,13 +2007,14 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
>  
>  			if ((nid + i) == F2FS_NODE_INO(sbi) ||
>  					(nid + i) == F2FS_META_INO(sbi)) {
> -				/* block_addr of node/meta inode should be 0x1 */
> +				/*
> +				 * block_addr of node/meta inode should be 0x1.
> +				 * Set this bit, and fsck_verify will fix it.
> +				 */
>  				if (le32_to_cpu(nat_block->entries[i].block_addr) != 0x1) {
> -					FIX_MSG("ino: 0x%x node/meta inode, block_addr= 0x%x -> 0x1",
> +					ASSERT_MSG("\tError: ino[0x%x] block_addr[0x%x] is invalid\n",
>  							nid + i, le32_to_cpu(nat_block->entries[i].block_addr));
> -					nat_block->entries[i].block_addr = cpu_to_le32(0x1);
> -					ret = dev_write_block(nat_block, block_addr);
> -					ASSERT(ret >= 0);
> +					f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
>  				}
>  				continue;
>  			}
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
