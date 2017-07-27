From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs: provide f2fs_balance_fs to
 __write_node_page
Date: Thu, 27 Jul 2017 20:13:15 +0800
Message-ID: <98e2be6b-904b-bb32-fb90-769cdedda0c1@huawei.com>
References: <1501072811-32260-1-git-send-email-yunlong.song@huawei.com>
 <1501157460-51262-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1dahiw-0002O9-JN
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jul 2017 12:17:02 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dahiv-0002Tm-1o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jul 2017 12:17:02 +0000
In-Reply-To: <1501157460-51262-1-git-send-email-yunlong.song@huawei.com>
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
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, sylinux@163.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

v1->v2, fix some dead lock problems under some heavy load test

On 2017/7/27 20:11, Yunlong Song wrote:
> Let node writeback also do f2fs_balance_fs to ensure there are always enough free
> segments.
>
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fs/f2fs/checkpoint.c |  2 +-
>   fs/f2fs/f2fs.h       |  2 +-
>   fs/f2fs/node.c       | 14 ++++++++------
>   3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 5b876f6..3c84a25 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1017,7 +1017,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
>   
>   	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
>   		up_write(&sbi->node_write);
> -		err = sync_node_pages(sbi, &wbc);
> +		err = sync_node_pages(sbi, &wbc, false);
>   		if (err) {
>   			up_write(&sbi->node_change);
>   			f2fs_unlock_all(sbi);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 94a88b2..f69051b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2293,7 +2293,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
>   void move_node_page(struct page *node_page, int gc_type);
>   int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>   			struct writeback_control *wbc, bool atomic);
> -int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc);
> +int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc, bool need);
>   void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
>   bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
>   void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index d53fe62..210ec25 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1326,7 +1326,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
>   }
>   
>   static int __write_node_page(struct page *page, bool atomic, bool *submitted,
> -				struct writeback_control *wbc)
> +				struct writeback_control *wbc, bool need)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
>   	nid_t nid;
> @@ -1387,6 +1387,8 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>   	}
>   
>   	unlock_page(page);
> +	if (need)
> +		f2fs_balance_fs(sbi, false);
>   
>   	if (unlikely(f2fs_cp_error(sbi))) {
>   		f2fs_submit_merged_write(sbi, NODE);
> @@ -1405,7 +1407,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>   static int f2fs_write_node_page(struct page *page,
>   				struct writeback_control *wbc)
>   {
> -	return __write_node_page(page, false, NULL, wbc);
> +	return __write_node_page(page, false, NULL, wbc, false);
>   }
>   
>   int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> @@ -1493,7 +1495,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>   
>   			ret = __write_node_page(page, atomic &&
>   						page == last_page,
> -						&submitted, wbc);
> +						&submitted, wbc, true);
>   			if (ret) {
>   				unlock_page(page);
>   				f2fs_put_page(last_page, 0);
> @@ -1530,7 +1532,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>   	return ret ? -EIO: 0;
>   }
>   
> -int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
> +int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc, bool need)
>   {
>   	pgoff_t index, end;
>   	struct pagevec pvec;
> @@ -1608,7 +1610,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
>   			set_fsync_mark(page, 0);
>   			set_dentry_mark(page, 0);
>   
> -			ret = __write_node_page(page, false, &submitted, wbc);
> +			ret = __write_node_page(page, false, &submitted, wbc, need);
>   			if (ret)
>   				unlock_page(page);
>   			else if (submitted)
> @@ -1697,7 +1699,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
>   	diff = nr_pages_to_write(sbi, NODE, wbc);
>   	wbc->sync_mode = WB_SYNC_NONE;
>   	blk_start_plug(&plug);
> -	sync_node_pages(sbi, wbc);
> +	sync_node_pages(sbi, wbc, true);
>   	blk_finish_plug(&plug);
>   	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
>   	return 0;

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
