From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH V2] f2fs: introduce free nid bitmap
Date: Sat, 25 Feb 2017 14:25:26 +0800
Message-ID: <c13a289e-5d46-70f3-5f49-eb88864bfa3d@huawei.com>
References: <20170223025349.104160-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1chVoo-00011Z-2u
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 06:26:58 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chVoj-0005aN-H4
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 06:26:58 +0000
In-Reply-To: <20170223025349.104160-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

I added below diff code into this patch in order to fix incorrectly nid status
updating to reduce large latency of generic/251 in fstest, could you help to
review code below?

Latency:    before    after
generic/251 1483s ... 184s

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 52db02396878..d25dcadf901a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1774,23 +1774,24 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t
nid, bool build)

        /* 0 nid should not be used */
        if (unlikely(nid == 0))
-               return 0;
+               return 1;

        if (build) {
                /* do not add allocated nids */
                ne = __lookup_nat_cache(nm_i, nid);
                if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
                                nat_get_blkaddr(ne) != NULL_ADDR))
-                       return 0;
+                       return 1;
        }

        i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
        i->nid = nid;
        i->state = NID_NEW;

-       if (radix_tree_preload(GFP_NOFS)) {
+       err = radix_tree_preload(GFP_NOFS);
+       if (err) {
                kmem_cache_free(free_nid_slab, i);
-               return 0;
+               return err;
        }

        spin_lock(&nm_i->nid_list_lock);
@@ -1799,9 +1800,9 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t
nid, bool build)
        radix_tree_preload_end();
        if (err) {
                kmem_cache_free(free_nid_slab, i);
-               return 0;
+               return err;
        }
-       return 1;
+       return 0;
 }

 static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
@@ -1844,7 +1845,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
        struct f2fs_nat_block *nat_blk = page_address(nat_page);
        block_t blk_addr;
        unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
-       int i;
+       int i, ret;

        set_bit_le(nat_ofs, nm_i->nat_block_bitmap);

@@ -1857,9 +1858,12 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,

                blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
                f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
-               if (blk_addr == NULL_ADDR)
-                       add_free_nid(sbi, start_nid, true);
-               update_free_nid_bitmap(sbi, start_nid, blk_addr == NULL_ADDR);
+               if (blk_addr == NULL_ADDR) {
+                       ret = add_free_nid(sbi, start_nid, true);
+                       update_free_nid_bitmap(sbi, start_nid, ret <= 0);
+               } else {
+                       update_free_nid_bitmap(sbi, start_nid, false);
+               }
        }
 }


On 2017/2/23 10:53, Chao Yu wrote:
> In scenario of intensively node allocation, free nids will be ran out
> soon, then it needs to stop to load free nids by traversing NAT blocks,
> in worse case, if NAT blocks does not be cached in memory, it generates
> IOs which slows down our foreground operations.
> 
> In order to speed up node allocation, in this patch we introduce a new
> free_nid_bitmap array, so there is an bitmap table for each NAT block,
> Once the NAT block is loaded, related bitmap cache will be switched on,
> and bitmap will be set during traversing nat entries in NAT block, later
> we can query and update nid usage status in memory completely.
> 
> With such implementation, I expect performance of node allocation can be
> improved in the long-term after filesystem image is mounted.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/debug.c         |   2 +
>  fs/f2fs/f2fs.h          |   2 +
>  fs/f2fs/node.c          | 109 ++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/f2fs_fs.h |   1 +
>  4 files changed, 111 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 015ad2b73a92..a77df377e2e8 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -194,6 +194,8 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>  	si->base_mem += sizeof(struct f2fs_nm_info);
>  	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
>  	si->base_mem += (NM_I(sbi)->nat_bits_blocks << F2FS_BLKSIZE_BITS);
> +	si->base_mem += NM_I(sbi)->nat_blocks * NAT_ENTRY_BITMAP_SIZE;
> +	si->base_mem += NM_I(sbi)->nat_blocks / 8;
>  
>  get_cache:
>  	si->cache_mem = 0;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1c9f0cc8f027..6a48e649bfef 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -556,6 +556,8 @@ struct f2fs_nm_info {
>  	unsigned int nid_cnt[MAX_NID_LIST];	/* the number of free node id */
>  	spinlock_t nid_list_lock;	/* protect nid lists ops */
>  	struct mutex build_lock;	/* lock for build free nids */
> +	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
> +	unsigned char *nat_block_bitmap;
>  
>  	/* for checkpoint */
>  	char *nat_bitmap;		/* NAT bitmap pointer */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index b63bdb85ad66..f0f036c2d2fc 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1821,14 +1821,32 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
>  		kmem_cache_free(free_nid_slab, i);
>  }
>  
> +void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid, bool set)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
> +	unsigned int nid_ofs = nid - START_NID(nid);
> +
> +	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
> +		return;
> +
> +	if (set)
> +		set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
> +	else
> +		clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
> +}
> +
>  static void scan_nat_page(struct f2fs_sb_info *sbi,
>  			struct page *nat_page, nid_t start_nid)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct f2fs_nat_block *nat_blk = page_address(nat_page);
>  	block_t blk_addr;
> +	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
>  	int i;
>  
> +	set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
> +
>  	i = start_nid % NAT_ENTRY_PER_BLOCK;
>  
>  	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
> @@ -1840,7 +1858,51 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
>  		if (blk_addr == NULL_ADDR)
>  			add_free_nid(sbi, start_nid, true);
> +		update_free_nid_bitmap(sbi, start_nid, blk_addr == NULL_ADDR);
> +	}
> +}
> +
> +static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> +	struct f2fs_journal *journal = curseg->journal;
> +	unsigned int i, idx;
> +	unsigned int target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
> +
> +	down_read(&nm_i->nat_tree_lock);
> +
> +	for (i = 0; i < nm_i->nat_blocks; i++) {
> +		if (!test_bit_le(i, nm_i->nat_block_bitmap))
> +			continue;
> +		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK; idx++) {
> +			nid_t nid;
> +
> +			if (!test_bit_le(idx, nm_i->free_nid_bitmap[i]))
> +				continue;
> +
> +			nid = i * NAT_ENTRY_PER_BLOCK + idx;
> +			add_free_nid(sbi, nid, true);
> +
> +			if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
> +				goto out;
> +		}
> +	}
> +out:
> +	down_read(&curseg->journal_rwsem);
> +	for (i = 0; i < nats_in_cursum(journal); i++) {
> +		block_t addr;
> +		nid_t nid;
> +
> +		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
> +		nid = le32_to_cpu(nid_in_journal(journal, i));
> +		if (addr == NULL_ADDR)
> +			add_free_nid(sbi, nid, true);
> +		else
> +			remove_free_nid(sbi, nid);
>  	}
> +	up_read(&curseg->journal_rwsem);
> +	up_read(&nm_i->nat_tree_lock);
>  }
>  
>  static int scan_nat_bits(struct f2fs_sb_info *sbi)
> @@ -1910,9 +1972,17 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  	if (!sync && !available_free_memory(sbi, FREE_NIDS))
>  		return;
>  
> -	/* try to find free nids with nat_bits */
> -	if (!mount && !scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
> -		return;
> +	if (!mount) {
> +		/* try to find free nids in free_nid_bitmap */
> +		scan_free_nid_bits(sbi);
> +
> +		if (nm_i->nid_cnt[FREE_NID_LIST])
> +			return;
> +
> +		/* try to find free nids with nat_bits */
> +		if (!scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
> +			return;
> +	}
>  
>  	/* find next valid candidate */
>  	if (is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
> @@ -2005,6 +2075,9 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>  		i->state = NID_ALLOC;
>  		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
>  		nm_i->available_nids--;
> +
> +		update_free_nid_bitmap(sbi, *nid, false);
> +
>  		spin_unlock(&nm_i->nid_list_lock);
>  		return true;
>  	}
> @@ -2059,6 +2132,8 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>  
>  	nm_i->available_nids++;
>  
> +	update_free_nid_bitmap(sbi, nid, true);
> +
>  	spin_unlock(&nm_i->nid_list_lock);
>  
>  	if (need_free)
> @@ -2387,6 +2462,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  			add_free_nid(sbi, nid, false);
>  			spin_lock(&NM_I(sbi)->nid_list_lock);
>  			NM_I(sbi)->available_nids++;
> +			update_free_nid_bitmap(sbi, nid, true);
> +			spin_unlock(&NM_I(sbi)->nid_list_lock);
> +		} else {
> +			spin_lock(&NM_I(sbi)->nid_list_lock);
> +			update_free_nid_bitmap(sbi, nid, false);
>  			spin_unlock(&NM_I(sbi)->nid_list_lock);
>  		}
>  	}
> @@ -2556,6 +2636,22 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>  	return 0;
>  }
>  
> +int init_free_nid_cache(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +
> +	nm_i->free_nid_bitmap = f2fs_kvzalloc(nm_i->nat_blocks *
> +					NAT_ENTRY_BITMAP_SIZE, GFP_KERNEL);
> +	if (!nm_i->free_nid_bitmap)
> +		return -ENOMEM;
> +
> +	nm_i->nat_block_bitmap = f2fs_kvzalloc(nm_i->nat_blocks / 8,
> +								GFP_KERNEL);
> +	if (!nm_i->nat_block_bitmap)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
>  int build_node_manager(struct f2fs_sb_info *sbi)
>  {
>  	int err;
> @@ -2568,6 +2664,10 @@ int build_node_manager(struct f2fs_sb_info *sbi)
>  	if (err)
>  		return err;
>  
> +	err = init_free_nid_cache(sbi);
> +	if (err)
> +		return err;
> +
>  	build_free_nids(sbi, true, true);
>  	return 0;
>  }
> @@ -2626,6 +2726,9 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
>  	}
>  	up_write(&nm_i->nat_tree_lock);
>  
> +	kvfree(nm_i->nat_block_bitmap);
> +	kvfree(nm_i->free_nid_bitmap);
> +
>  	kfree(nm_i->nat_bitmap);
>  	kfree(nm_i->nat_bits);
>  #ifdef CONFIG_F2FS_CHECK_FS
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 1c92ace2e8f8..e2d239ed4c60 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -279,6 +279,7 @@ struct f2fs_node {
>   * For NAT entries
>   */
>  #define NAT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_nat_entry))
> +#define NAT_ENTRY_BITMAP_SIZE	((NAT_ENTRY_PER_BLOCK + 7) / 8)
>  
>  struct f2fs_nat_entry {
>  	__u8 version;		/* latest version of cached nat entry */
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
