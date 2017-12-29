From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Search nat_block_bitmap to accelerate
 free nids built process
Date: Fri, 29 Dec 2017 17:13:29 +0800
Message-ID: <b82b3c3c-c84b-2a50-6609-4978c96588ae@huawei.com>
References: <1514513851-9288-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eUqji-0006WS-TT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 09:13:54 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eUqjh-0001VM-C6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Dec 2017 09:13:54 +0000
In-Reply-To: <1514513851-9288-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com

On 2017/12/29 10:17, Yunlei He wrote:
> Search nat_block_bitmap to accelerate free nids built process.

We have tried to load free nid entries by searching nat_block_bitmap in
scan_free_nid_bits prior to the position you optimized?

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/f2fs.h |  3 ++-
>  fs/f2fs/node.c | 47 +++++++++++++++++++++++++++++++++--------------
>  2 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 398ed95..afbe705 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -733,7 +733,8 @@ struct f2fs_nm_info {
>  	spinlock_t nid_list_lock;	/* protect nid lists ops */
>  	struct mutex build_lock;	/* lock for build free nids */
>  	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
> -	unsigned char *nat_block_bitmap;
> +	unsigned long *nat_block_bitmap;
> +	unsigned int scaned_nat_blocks; /* # of nat blocks have been read */
>  	unsigned short *free_nid_count;	/* free nid count of NAT block */
>  
>  	/* for checkpoint */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 35b079d..e00d7a7 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1935,6 +1935,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  	int i;
>  
>  	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
> +	nm_i->scaned_nat_blocks++;
>  
>  	i = start_nid % NAT_ENTRY_PER_BLOCK;
>  
> @@ -2031,6 +2032,9 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  			return;
>  	}
>  
> +	if (nm_i->scaned_nat_blocks == nm_i->nat_blocks)
> +		return;
> +
>  	/* readahead nat pages to be scanned */
>  	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
>  							META_NAT, true);
> @@ -2038,19 +2042,35 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  	down_read(&nm_i->nat_tree_lock);
>  
>  	while (1) {
> -		if (!test_bit_le(NAT_BLOCK_OFFSET(nid),
> -						nm_i->nat_block_bitmap)) {
> -			struct page *page = get_current_nat_page(sbi, nid);
> +		unsigned int start;
> +		struct page *page;
>  
> -			scan_nat_page(sbi, page, nid);
> -			f2fs_put_page(page, 1);
> +		start = find_next_zero_bit(nm_i->nat_block_bitmap,
> +				nm_i->nat_blocks, NAT_BLOCK_OFFSET(nid));
> +
> +		if (start >= nm_i->nat_blocks) {
> +			if (nm_i->scaned_nat_blocks > nm_i->nat_blocks) {
> +				f2fs_bug_on(sbi, 1);
> +				break;
> +			} else if (nm_i->scaned_nat_blocks == nm_i->nat_blocks){
> +				break;
> +			} else {
> +				nid = 0;
> +				continue;
> +			}
>  		}
>  
> -		nid += (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
> -		if (unlikely(nid >= nm_i->max_nid))
> -			nid = 0;
> +		nid = start * NAT_ENTRY_PER_BLOCK;
> +		page = get_current_nat_page(sbi, nid);
> +		scan_nat_page(sbi, page, nid);
> +		f2fs_put_page(page, 1);
> +		nid += NAT_ENTRY_PER_BLOCK;
>  
> -		if (++i >= FREE_NID_PAGES)
> +		/* background or mount build, no more than 8 pages */
> +		if ((!sync || mount) && ++i >= FREE_NID_PAGES)
> +			break;
> +		/* foreground build, until get free nids */
> +		if (sync && !mount && nm_i->nid_cnt[FREE_NID])
>  			break;
>  	}
>  
> @@ -2061,9 +2081,6 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  	scan_curseg_cache(sbi);
>  
>  	up_read(&nm_i->nat_tree_lock);
> -
> -	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
> -					nm_i->ra_nid_pages, META_NAT, false);
>  }
>  
>  void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
> @@ -2656,6 +2673,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>  	nat_segs = le32_to_cpu(sb_raw->segment_count_nat) >> 1;
>  	nm_i->nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
>  	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nm_i->nat_blocks;
> +	nm_i->scaned_nat_blocks = 0;
>  
>  	/* not used nids: 0, node, meta, (and root counted as valid node) */
>  	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
> @@ -2705,14 +2723,15 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>  static int init_free_nid_cache(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	unsigned int bitmap_size;
>  
>  	nm_i->free_nid_bitmap = f2fs_kvzalloc(sbi, nm_i->nat_blocks *
>  					NAT_ENTRY_BITMAP_SIZE, GFP_KERNEL);
>  	if (!nm_i->free_nid_bitmap)
>  		return -ENOMEM;
>  
> -	nm_i->nat_block_bitmap = f2fs_kvzalloc(sbi, nm_i->nat_blocks / 8,
> -								GFP_KERNEL);
> +	bitmap_size = f2fs_bitmap_size(nm_i->nat_blocks);
> +	nm_i->nat_block_bitmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
>  	if (!nm_i->nat_block_bitmap)
>  		return -ENOMEM;
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
