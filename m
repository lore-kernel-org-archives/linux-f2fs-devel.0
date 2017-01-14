From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH 6/6] f2fs: show # of on-going flush and
 discard bios
Date: Sat, 14 Jan 2017 10:26:21 +0800
Message-ID: <92d77ec4-affe-6411-46d3-27fc0edeaa23@huawei.com>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
	<20170112224407.54026-6-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cSE4S-0000NW-KC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Jan 2017 02:27:56 +0000
Received: from [45.249.212.190] (helo=dggrg04-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cSE4P-00040t-Sz
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 Jan 2017 02:27:56 +0000
In-Reply-To: <20170112224407.54026-6-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk Kim,

On 2017/1/13 6:44, Jaegeuk Kim wrote:
> This patch adds stat information for flush and discard commands.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/debug.c   | 7 +++++--
>  fs/f2fs/f2fs.h    | 3 ++-
>  fs/f2fs/segment.c | 4 ++++
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index f9f6b0aeba02..e67cab2fafac 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -54,6 +54,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
>  	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
>  	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
> +	si->nr_flush = atomic_read(&SM_I(sbi)->fcc_info->submit_flush);
> +	si->nr_discard = atomic_read(&SM_I(sbi)->dcc_info->submit_discard);
>  	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
>  	si->rsvd_segs = reserved_segments(sbi);
>  	si->overp_segs = overprovision_segments(sbi);
> @@ -318,8 +320,9 @@ static int stat_show(struct seq_file *s, void *v)
>  		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
>  				si->ext_tree, si->zombie_tree, si->ext_node);
>  		seq_puts(s, "\nBalancing F2FS Async:\n");
> -		seq_printf(s, "  - IO (CP: %4d, Data: %4d)\n",
> -			   si->nr_wb_cp_data, si->nr_wb_data);
> +		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: %4d, Discard: %4d)\n",
> +			   si->nr_wb_cp_data, si->nr_wb_data,
> +			   si->nr_flush, si->nr_discard);
>  		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d)\n",
>  			   si->inmem_pages, si->aw_cnt, si->max_aw_cnt);
>  		seq_printf(s, "  - nodes: %4d in %4d\n",
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ef5e3709c161..d51bc18e7292 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -201,6 +201,7 @@ struct discard_cmd_control {
>  	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
>  	struct mutex cmd_lock;
>  	int max_discards;			/* max. discards to be issued */
> +	atomic_t submit_discard;		/* # of issued discard */
>  };

Here, we need to initialize submit_discard.

Thanks.
>
>  /* for the list of fsync inodes, used only during recovery */
> @@ -2254,7 +2255,7 @@ struct f2fs_stat_info {
>  	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
>  	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
>  	int total_count, utilization;
> -	int bg_gc, nr_wb_cp_data, nr_wb_data;
> +	int bg_gc, nr_wb_cp_data, nr_wb_data, nr_flush, nr_discard;
>  	int inline_xattr, inline_inode, inline_dir, orphans;
>  	int aw_cnt, max_aw_cnt;
>  	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 74364006bfa6..5a2d380182d9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -653,6 +653,8 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *d
>  {
>  	int err = dc->bio->bi_error;
>
> +	atomic_dec(&(SM_I(sbi)->dcc_info->submit_discard));
> +
>  	if (err == -EOPNOTSUPP)
>  		err = 0;
>
> @@ -678,6 +680,7 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  			if (dc->state == D_PREP) {
>  				dc->state = D_SUBMIT;
>  				submit_bio(dc->bio);
> +				atomic_inc(&dcc->submit_discard);
>  			}
>  			wait_for_completion_io(&dc->wait);
>
> @@ -723,6 +726,7 @@ static int issue_discard_thread(void *data)
>  		if (dc->state == D_PREP) {
>  			dc->state = D_SUBMIT;
>  			submit_bio(dc->bio);
> +			atomic_inc(&dcc->submit_discard);
>  			if (iter++ > DISCARD_ISSUE_RATE)
>  				break;
>  		} else if (dc->state == D_DONE) {
>


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
