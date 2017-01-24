From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: introduce nid cache
Date: Tue, 24 Jan 2017 13:35:00 +0900
Message-ID: <20170124043500.GC1566@jaegeuk.local>
References: <20170122095331.58427-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cVsp8-0004Ko-6l
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 04:35:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cVsp6-0003Lu-PV
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 04:35:14 +0000
Content-Disposition: inline
In-Reply-To: <20170122095331.58427-1-yuchao0@huawei.com>
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

On 01/22, Chao Yu wrote:
> In scenario of intensively node allocation, free nids will be ran out
> soon, then it needs to stop to load free nids by traversing NAT blocks,
> in worse case, if NAT blocks does not be cached in memory, it generates
> IOs which slows down our foreground operations.
> 
> In order to speed up node allocation, in this patch we introduce a new
> option named "nid cache", when turns on this option, it will load all
> nat entries in NAT blocks when doing mount, and organize all free nids
> in a bitmap, for any operations related to free nid, we will query and
> set the new prebuilded bitmap instead of reading and lookuping NAT
> blocks, so performance of node allocation can be improved.
> 

How does this affect mount time and memory consumption? IMO, if those do not
raise huge concerns, we would be able to consider just replacing current free
nid list with this bitmap.

Thanks,

> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  Documentation/filesystems/f2fs.txt |   3 ++
>  fs/f2fs/f2fs.h                     |   2 +
>  fs/f2fs/node.c                     | 107 +++++++++++++++++++++++++++++++++++++
>  fs/f2fs/super.c                    |   5 ++
>  4 files changed, 117 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index d99faced79cb..3320a4976c12 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -159,6 +159,9 @@ mode=%s                Control block allocation mode which supports "adaptive"
>                         writes towards main area.
>  io_bits=%u             Set the bit size of write IO requests. It should be set
>                         with "mode=lfs".
> +nid_cache              Enable free nid bitmap cache which records all nid usage
> +                       status, it can improve performance of continuously node
> +                       allocating.
>  
>  ================================================================================
>  DEBUGFS ENTRIES
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 620f6be060a5..c696b5eee1f0 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -83,6 +83,7 @@ extern char *fault_name[FAULT_MAX];
>  #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
>  #define F2FS_MOUNT_ADAPTIVE		0x00020000
>  #define F2FS_MOUNT_LFS			0x00040000
> +#define F2FS_MOUNT_NID_CACHE		0x00080000
>  
>  #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
> @@ -551,6 +552,7 @@ struct f2fs_nm_info {
>  	unsigned int nid_cnt[MAX_NID_LIST];	/* the number of free node id */
>  	spinlock_t nid_list_lock;	/* protect nid lists ops */
>  	struct mutex build_lock;	/* lock for build free nids */
> +	unsigned long *free_nid_bitmap;	/* indicate nid is free or not */
>  
>  	/* for checkpoint */
>  	char *nat_bitmap;		/* NAT bitmap pointer */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 69c38a0022e7..5cdf05919e9f 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1819,6 +1819,24 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  	}
>  }
>  
> +void load_nids_from_bitmap(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	nid_t nid = 0;
> +	unsigned int count = 0;
> +
> +	down_read(&nm_i->nat_tree_lock);
> +	do {
> +		nid = find_next_bit(nm_i->free_nid_bitmap, nm_i->max_nid, nid);
> +		if (nid < nm_i->max_nid)
> +			count += add_free_nid(sbi, nid, true);
> +
> +		if (nm_i->nid_cnt[FREE_NID_LIST] >= NAT_ENTRY_PER_BLOCK)
> +			break;
> +	} while (++nid < nm_i->max_nid);
> +	up_read(&nm_i->nat_tree_lock);
> +}
> +
>  static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> @@ -1834,6 +1852,9 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
>  	if (!sync && !available_free_memory(sbi, FREE_NIDS))
>  		return;
>  
> +	if (test_opt(sbi, NID_CACHE))
> +		return load_nids_from_bitmap(sbi);
> +
>  	/* readahead nat pages to be scanned */
>  	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
>  							META_NAT, true);
> @@ -1915,6 +1936,11 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>  		i->state = NID_ALLOC;
>  		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
>  		nm_i->available_nids--;
> +
> +		if (test_opt(sbi, NID_CACHE)) {
> +			f2fs_bug_on(sbi, !test_bit(*nid, nm_i->free_nid_bitmap));
> +			clear_bit(*nid, nm_i->free_nid_bitmap);
> +		}
>  		spin_unlock(&nm_i->nid_list_lock);
>  		return true;
>  	}
> @@ -1969,6 +1995,9 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>  
>  	nm_i->available_nids++;
>  
> +	if (test_opt(sbi, NID_CACHE))
> +		set_bit(nid, nm_i->free_nid_bitmap);
> +
>  	spin_unlock(&nm_i->nid_list_lock);
>  
>  	if (need_free)
> @@ -2257,6 +2286,13 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  			add_free_nid(sbi, nid, false);
>  			spin_lock(&NM_I(sbi)->nid_list_lock);
>  			NM_I(sbi)->available_nids++;
> +			if (test_opt(sbi, NID_CACHE))
> +				set_bit(nid, NM_I(sbi)->free_nid_bitmap);
> +			spin_unlock(&NM_I(sbi)->nid_list_lock);
> +		} else {
> +			spin_lock(&NM_I(sbi)->nid_list_lock);
> +			if (test_opt(sbi, NID_CACHE))
> +				clear_bit(nid, NM_I(sbi)->free_nid_bitmap);
>  			spin_unlock(&NM_I(sbi)->nid_list_lock);
>  		}
>  	}
> @@ -2374,6 +2410,71 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>  	return 0;
>  }
>  
> +int init_free_nid_cache(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> +	struct f2fs_journal *journal = curseg->journal;
> +	struct f2fs_nat_entry *nat;
> +	unsigned int i, readed, start_blk = 0, end_blk;
> +	unsigned int max_blk = NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid);
> +	nid_t nid = 0;
> +
> +	if (!test_opt(sbi, NID_CACHE))
> +		return 0;
> +
> +	nm_i->free_nid_bitmap = f2fs_kvzalloc(nm_i->max_nid / 8, GFP_KERNEL);
> +	if (!nm_i->free_nid_bitmap)
> +		return -ENOMEM;
> +
> +	do {
> +		readed = ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid),
> +					FREE_NID_PAGES * 8, META_NAT, true);
> +
> +		end_blk = start_blk + readed;
> +
> +		for (; start_blk < end_blk; start_blk++) {
> +			struct f2fs_nat_block *nat_blk;
> +			struct page *page;
> +			nid_t start_nid = START_NID(nid);
> +
> +			page = get_current_nat_page(sbi, nid);
> +			nat_blk = (struct f2fs_nat_block *)page_address(page);
> +
> +			for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++, nid++) {
> +				if (unlikely(nid >= nm_i->max_nid))
> +					break;
> +
> +				if (unlikely(nid == 0))
> +					continue;
> +
> +				nat = &nat_blk->entries[nid - start_nid];
> +				if (le32_to_cpu(nat->block_addr) == NULL_ADDR)
> +					set_bit(nid, nm_i->free_nid_bitmap);
> +				else
> +					clear_bit(nid, nm_i->free_nid_bitmap);
> +			}
> +
> +			f2fs_put_page(page, 1);
> +
> +		}
> +	} while (start_blk < max_blk);
> +
> +	down_read(&curseg->journal_rwsem);
> +	for (i = 0; i < nats_in_cursum(journal); i++) {
> +		nid_t nid = le32_to_cpu(nid_in_journal(journal, i));
> +
> +		nat = &nat_in_journal(journal, i);
> +		if (le32_to_cpu(nat->block_addr) == NULL_ADDR)
> +			set_bit(nid, nm_i->free_nid_bitmap);
> +		else
> +			clear_bit(nid, nm_i->free_nid_bitmap);
> +	}
> +	up_read(&curseg->journal_rwsem);
> +
> +	return 0;
> +}
> +
>  int build_node_manager(struct f2fs_sb_info *sbi)
>  {
>  	int err;
> @@ -2386,6 +2487,10 @@ int build_node_manager(struct f2fs_sb_info *sbi)
>  	if (err)
>  		return err;
>  
> +	err = init_free_nid_cache(sbi);
> +	if (err)
> +		return err;
> +
>  	build_free_nids(sbi, true);
>  	return 0;
>  }
> @@ -2444,6 +2549,8 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
>  	}
>  	up_write(&nm_i->nat_tree_lock);
>  
> +	kfree(nm_i->free_nid_bitmap);
> +
>  	kfree(nm_i->nat_bitmap);
>  #ifdef CONFIG_F2FS_CHECK_FS
>  	kfree(nm_i->nat_bitmap_mir);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2ddd2dc50b08..3c84c27d026a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -105,6 +105,7 @@ enum {
>  	Opt_fault_injection,
>  	Opt_lazytime,
>  	Opt_nolazytime,
> +	Opt_nid_cache,
>  	Opt_err,
>  };
>  
> @@ -138,6 +139,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_fault_injection, "fault_injection=%u"},
>  	{Opt_lazytime, "lazytime"},
>  	{Opt_nolazytime, "nolazytime"},
> +	{Opt_nid_cache, "nid_cache"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -565,6 +567,9 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_nolazytime:
>  			sb->s_flags &= ~MS_LAZYTIME;
>  			break;
> +		case Opt_nid_cache:
> +			set_opt(sbi, NID_CACHE);
> +			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> -- 
> 2.8.2.295.g3f1c1d0

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
