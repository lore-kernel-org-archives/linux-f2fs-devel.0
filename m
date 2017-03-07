From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: combine nat_bits and
	free_nid_bitmap cache
Date: Tue, 7 Mar 2017 14:27:14 -0800
Message-ID: <20170307222714.GB2499@jaegeuk.local>
References: <20170306131241.36042-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1clNZl-0005lm-OV
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:27:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1clNZj-0000rB-FR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:27:25 +0000
Content-Disposition: inline
In-Reply-To: <20170306131241.36042-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

There were two reasons for slow down; one is set_bit_le and the other was 
spin_lock calls.

I think it would'b good to merge this patch in yours as well.
Let me know. I'm ready to integrate together and test them.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3377a512e299..0a1ea59c9d31 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1815,7 +1815,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 }
 
 void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
-							bool set, bool build)
+			bool set, bool build, bool locked)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
@@ -1829,12 +1829,14 @@ void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 	else
 		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
 
-	spin_lock(&nm_i->free_nid_lock);
+	if (!locked)
+		spin_lock(&nm_i->free_nid_lock);
 	if (set)
 		nm_i->free_nid_count[nat_ofs]++;
 	else if (!build)
 		nm_i->free_nid_count[nat_ofs]--;
-	spin_unlock(&nm_i->free_nid_lock);
+	if (!locked)
+		spin_unlock(&nm_i->free_nid_lock);
 }
 
 static void scan_nat_page(struct f2fs_sb_info *sbi,
@@ -1863,7 +1865,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
 		if (blk_addr == NULL_ADDR)
 			freed = add_free_nid(sbi, start_nid, true);
-		update_free_nid_bitmap(sbi, start_nid, freed, true);
+		update_free_nid_bitmap(sbi, start_nid, freed, true, false);
 	}
 }
 
@@ -2018,7 +2020,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
 		nm_i->available_nids--;
 
-		update_free_nid_bitmap(sbi, *nid, false, false);
+		update_free_nid_bitmap(sbi, *nid, false, false, false);
 
 		spin_unlock(&nm_i->nid_list_lock);
 		return true;
@@ -2074,7 +2076,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 
 	nm_i->available_nids++;
 
-	update_free_nid_bitmap(sbi, nid, true, false);
+	update_free_nid_bitmap(sbi, nid, true, false, false);
 
 	spin_unlock(&nm_i->nid_list_lock);
 
@@ -2404,11 +2406,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 			add_free_nid(sbi, nid, false);
 			spin_lock(&NM_I(sbi)->nid_list_lock);
 			NM_I(sbi)->available_nids++;
-			update_free_nid_bitmap(sbi, nid, true, false);
+			update_free_nid_bitmap(sbi, nid, true, false, false);
 			spin_unlock(&NM_I(sbi)->nid_list_lock);
 		} else {
 			spin_lock(&NM_I(sbi)->nid_list_lock);
-			update_free_nid_bitmap(sbi, nid, false, false);
+			update_free_nid_bitmap(sbi, nid, false, false, false);
 			spin_unlock(&NM_I(sbi)->nid_list_lock);
 		}
 	}
@@ -2533,8 +2535,10 @@ inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 		nid = i * NAT_ENTRY_PER_BLOCK;
 		last_nid = (i + 1) * NAT_ENTRY_PER_BLOCK;
 
+		spin_lock(&nm_i->free_nid_lock);
 		for (; nid < last_nid; nid++)
-			update_free_nid_bitmap(sbi, nid, true, true);
+			update_free_nid_bitmap(sbi, nid, true, true, true);
+		spin_unlock(&nm_i->free_nid_lock);
 	}
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
-- 
2.11.0


On 03/06, Chao Yu wrote:
> Both nat_bits cache and free_nid_bitmap cache provide same functionality
> as a intermediate cache between free nid cache and disk, but with
> different granularity of indicating free nid range, and different
> persistence policy. nat_bits cache provides better persistence ability,
> and free_nid_bitmap provides better granularity.
> 
> In this patch we combine advantage of both caches, so finally policy of
> the intermediate cache would be:
> - init: load free nid status from nat_bits into free_nid_bitmap
> - lookup: scan free_nid_bitmap before load NAT blocks
> - update: update free_nid_bitmap in real-time
> - persistence: udpate and persist nat_bits in checkpoint
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c | 105 +++++++++++++++++++--------------------------------------
>  1 file changed, 35 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 1a759d45b7e4..625b46bc55ad 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -338,9 +338,6 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>  		set_nat_flag(e, IS_CHECKPOINTED, false);
>  	__set_nat_cache_dirty(nm_i, e);
>  
> -	if (enabled_nat_bits(sbi, NULL) && new_blkaddr == NEW_ADDR)
> -		clear_bit_le(NAT_BLOCK_OFFSET(ni->nid), nm_i->empty_nat_bits);
> -
>  	/* update fsync_mark if its inode nat entry is still alive */
>  	if (ni->nid != ni->ino)
>  		e = __lookup_nat_cache(nm_i, ni->ino);
> @@ -1920,58 +1917,6 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>  	up_read(&nm_i->nat_tree_lock);
>  }
>  
> -static int scan_nat_bits(struct f2fs_sb_info *sbi)
> -{
> -	struct f2fs_nm_info *nm_i = NM_I(sbi);
> -	struct page *page;
> -	unsigned int i = 0;
> -	nid_t nid;
> -
> -	if (!enabled_nat_bits(sbi, NULL))
> -		return -EAGAIN;
> -
> -	down_read(&nm_i->nat_tree_lock);
> -check_empty:
> -	i = find_next_bit_le(nm_i->empty_nat_bits, nm_i->nat_blocks, i);
> -	if (i >= nm_i->nat_blocks) {
> -		i = 0;
> -		goto check_partial;
> -	}
> -
> -	for (nid = i * NAT_ENTRY_PER_BLOCK; nid < (i + 1) * NAT_ENTRY_PER_BLOCK;
> -									nid++) {
> -		if (unlikely(nid >= nm_i->max_nid))
> -			break;
> -		add_free_nid(sbi, nid, true);
> -	}
> -
> -	if (nm_i->nid_cnt[FREE_NID_LIST] >= MAX_FREE_NIDS)
> -		goto out;
> -	i++;
> -	goto check_empty;
> -
> -check_partial:
> -	i = find_next_zero_bit_le(nm_i->full_nat_bits, nm_i->nat_blocks, i);
> -	if (i >= nm_i->nat_blocks) {
> -		disable_nat_bits(sbi, true);
> -		up_read(&nm_i->nat_tree_lock);
> -		return -EINVAL;
> -	}
> -
> -	nid = i * NAT_ENTRY_PER_BLOCK;
> -	page = get_current_nat_page(sbi, nid);
> -	scan_nat_page(sbi, page, nid);
> -	f2fs_put_page(page, 1);
> -
> -	if (nm_i->nid_cnt[FREE_NID_LIST] < MAX_FREE_NIDS) {
> -		i++;
> -		goto check_partial;
> -	}
> -out:
> -	up_read(&nm_i->nat_tree_lock);
> -	return 0;
> -}
> -
>  static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> @@ -1993,21 +1938,6 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>  
>  		if (nm_i->nid_cnt[FREE_NID_LIST])
>  			return;
> -
> -		/* try to find free nids with nat_bits */
> -		if (!scan_nat_bits(sbi) && nm_i->nid_cnt[FREE_NID_LIST])
> -			return;
> -	}
> -
> -	/* find next valid candidate */
> -	if (enabled_nat_bits(sbi, NULL)) {
> -		int idx = find_next_zero_bit_le(nm_i->full_nat_bits,
> -					nm_i->nat_blocks, 0);
> -
> -		if (idx >= nm_i->nat_blocks)
> -			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		else
> -			nid = idx * NAT_ENTRY_PER_BLOCK;
>  	}
>  
>  	/* readahead nat pages to be scanned */
> @@ -2590,6 +2520,38 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>  	return 0;
>  }
>  
> +inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	unsigned int i = 0;
> +	nid_t nid, last_nid;
> +
> +	if (!enabled_nat_bits(sbi, NULL))
> +		return;
> +
> +	for (i = 0; i < nm_i->nat_blocks; i++) {
> +		i = find_next_bit_le(nm_i->empty_nat_bits, nm_i->nat_blocks, i);
> +		if (i >= nm_i->nat_blocks)
> +			break;
> +
> +		__set_bit_le(i, nm_i->nat_block_bitmap);
> +
> +		nid = i * NAT_ENTRY_PER_BLOCK;
> +		last_nid = (i + 1) * NAT_ENTRY_PER_BLOCK;
> +
> +		for (; nid < last_nid; nid++)
> +			update_free_nid_bitmap(sbi, nid, true, true);
> +	}
> +
> +	for (i = 0; i < nm_i->nat_blocks; i++) {
> +		i = find_next_bit_le(nm_i->full_nat_bits, nm_i->nat_blocks, i);
> +		if (i >= nm_i->nat_blocks)
> +			break;
> +
> +		__set_bit_le(i, nm_i->nat_block_bitmap);
> +	}
> +}
> +
>  static int init_node_manager(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *sb_raw = F2FS_RAW_SUPER(sbi);
> @@ -2691,6 +2653,9 @@ int build_node_manager(struct f2fs_sb_info *sbi)
>  	if (err)
>  		return err;
>  
> +	/* load free nid status from nat_bits table */
> +	load_free_nid_bitmap(sbi);
> +
>  	build_free_nids(sbi, true, true);
>  	return 0;
>  }
> -- 
> 2.8.2.295.g3f1c1d0

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
