From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: introduce __drop_inmem_page
Date: Wed, 22 Mar 2017 14:39:05 +0800
Message-ID: <247b17b4-efe5-cb2b-1640-68009dbd8eeb@huawei.com>
References: <20170321120945.76050-1-yuchao0@huawei.com>
	<20170322024146.GA71425@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqZvh-0002ph-25
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:39:33 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqZvf-0003ma-HF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:39:33 +0000
In-Reply-To: <20170322024146.GA71425@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/3/22 10:41, Jaegeuk Kim wrote:
> Hi Chao,
> 
> Please let me make one patch by integrating into my original patch like this.
> I slightly changed drop_inmem_page() as well.

The merged patch looks good to me. ;)

Thanks,

> 
> Thanks,
> 
>>From 8c242db9b8c01b252290e23827163787f07e01d1 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 17 Mar 2017 09:55:52 +0800
> Subject: [PATCH] f2fs: fix stale ATOMIC_WRITTEN_PAGE private pointer
> 
> When I forced to enable atomic operations intentionally, I could hit the below
> panic, since we didn't clear page->private in f2fs_invalidate_page called by
> file truncation.
> 
> The panic occurs due to NULL mapping having page->private.
> 
> BUG: unable to handle kernel paging request at ffffffffffffffff
> IP: drop_buffers+0x38/0xe0
> PGD 5d00c067
> PUD 5d00e067
> PMD 0
> CPU: 3 PID: 1648 Comm: fsstress Tainted: G      D    OE   4.10.0+ #5
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> task: ffff9151952863c0 task.stack: ffffaaec40db4000
> RIP: 0010:drop_buffers+0x38/0xe0
> RSP: 0018:ffffaaec40db74c8 EFLAGS: 00010292
> Call Trace:
>  ? page_referenced+0x8b/0x170
>  try_to_free_buffers+0xc5/0xe0
>  try_to_release_page+0x49/0x50
>  shrink_page_list+0x8bc/0x9f0
>  shrink_inactive_list+0x1dd/0x500
>  ? shrink_active_list+0x2c0/0x430
>  shrink_node_memcg+0x5eb/0x7c0
>  shrink_node+0xe1/0x320
>  do_try_to_free_pages+0xef/0x2e0
>  try_to_free_pages+0xe9/0x190
>  __alloc_pages_slowpath+0x390/0xe70
>  __alloc_pages_nodemask+0x291/0x2b0
>  alloc_pages_current+0x95/0x140
>  __page_cache_alloc+0xc4/0xe0
>  pagecache_get_page+0xab/0x2a0
>  grab_cache_page_write_begin+0x20/0x40
>  get_read_data_page+0x2e6/0x4c0 [f2fs]
>  ? f2fs_mark_inode_dirty_sync+0x16/0x30 [f2fs]
>  ? truncate_data_blocks_range+0x238/0x2b0 [f2fs]
>  get_lock_data_page+0x30/0x190 [f2fs]
>  __exchange_data_block+0xaaf/0xf40 [f2fs]
>  f2fs_fallocate+0x418/0xd00 [f2fs]
>  vfs_fallocate+0x157/0x220
>  SyS_fallocate+0x48/0x80
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> [Chao Yu: use INMEM_INVALIDATE for better tracing]
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c              |  2 +-
>  fs/f2fs/f2fs.h              |  2 ++
>  fs/f2fs/segment.c           | 30 ++++++++++++++++++++++++++++++
>  include/trace/events/f2fs.h |  2 ++
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 1602b4bccae6..e341d446205a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1951,7 +1951,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>  
>  	/* This is atomic written page, keep Private */
>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
> -		return;
> +		return drop_inmem_page(inode, page);
>  
>  	set_page_private(page, 0);
>  	ClearPagePrivate(page);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0a6e115562f6..264c219f41a5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -722,6 +722,7 @@ enum page_type {
>  	META_FLUSH,
>  	INMEM,		/* the below types are used by tracepoints only. */
>  	INMEM_DROP,
> +	INMEM_INVALIDATE,
>  	INMEM_REVOKE,
>  	IPU,
>  	OPU,
> @@ -2184,6 +2185,7 @@ void destroy_node_manager_caches(void);
>   */
>  void register_inmem_page(struct inode *inode, struct page *page);
>  void drop_inmem_pages(struct inode *inode);
> +void drop_inmem_page(struct inode *inode, struct page *page);
>  int commit_inmem_pages(struct inode *inode);
>  void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
>  void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4d7bf84dc393..cb6d9ed634a3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -250,6 +250,36 @@ void drop_inmem_pages(struct inode *inode)
>  	stat_dec_atomic_write(inode);
>  }
>  
> +void drop_inmem_page(struct inode *inode, struct page *page)
> +{
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct list_head *head = &fi->inmem_pages;
> +	struct inmem_pages *cur = NULL;
> +
> +	f2fs_bug_on(sbi, !IS_ATOMIC_WRITTEN_PAGE(page));
> +
> +	mutex_lock(&fi->inmem_lock);
> +	list_for_each_entry(cur, head, list) {
> +		if (cur->page == page)
> +			break;
> +	}
> +
> +	f2fs_bug_on(sbi, !cur || cur->page != page);
> +	list_del(&cur->list);
> +	mutex_unlock(&fi->inmem_lock);
> +
> +	dec_page_count(sbi, F2FS_INMEM_PAGES);
> +	kmem_cache_free(inmem_entry_slab, cur);
> +
> +	ClearPageUptodate(page);
> +	set_page_private(page, 0);
> +	ClearPagePrivate(page);
> +	f2fs_put_page(page, 0);
> +
> +	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
> +}
> +
>  static int __commit_inmem_pages(struct inode *inode,
>  					struct list_head *revoke_list)
>  {
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index c80fcad0a6c9..96139021b6bc 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -15,6 +15,7 @@ TRACE_DEFINE_ENUM(META);
>  TRACE_DEFINE_ENUM(META_FLUSH);
>  TRACE_DEFINE_ENUM(INMEM);
>  TRACE_DEFINE_ENUM(INMEM_DROP);
> +TRACE_DEFINE_ENUM(INMEM_INVALIDATE);
>  TRACE_DEFINE_ENUM(IPU);
>  TRACE_DEFINE_ENUM(OPU);
>  TRACE_DEFINE_ENUM(CURSEG_HOT_DATA);
> @@ -51,6 +52,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
>  		{ META_FLUSH,	"META_FLUSH" },				\
>  		{ INMEM,	"INMEM" },				\
>  		{ INMEM_DROP,	"INMEM_DROP" },				\
> +		{ INMEM_INVALIDATE,	"INMEM_INVALIDATE" },		\
>  		{ INMEM_REVOKE,	"INMEM_REVOKE" },			\
>  		{ IPU,		"IN-PLACE" },				\
>  		{ OPU,		"OUT-OF-PLACE" })
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
