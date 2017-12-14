From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Thu, 14 Dec 2017 19:03:37 +0800
Message-ID: <e539f1c4-0a7f-fc04-9ec4-428c6353dd30@huawei.com>
References: <1513223692-20178-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1ePRJa-000548-GS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Dec 2017 11:04:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ePRJV-0001ug-Vf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Dec 2017 11:04:34 +0000
In-Reply-To: <1513223692-20178-1-git-send-email-heyunlei@huawei.com>
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

On 2017/12/14 11:54, Yunlei He wrote:
> Came across a dead loop in recovery like this:
> 
> ......
> [   24.680480s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597696
> [   24.698394s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597697
> [   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724426s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> ......
> 
> Mount process will block in dead loop and fsck can do nothing with this
> error, This patch abandon recovery if node chain is cyclical.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/data.c     |  5 +++++
>  fs/f2fs/recovery.c | 23 +++++++++++++++--------
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7aca6cc..2ac992f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2146,6 +2146,9 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
>  		}
>  	}
>  
> +	if (PageChecked(page))
> +		ClearPageChecked(page);

IMO, we don't need to care about this flag like most other PG_* flags
during truncation.

> +
>  	/* This is atomic written page, keep Private */
>  	if (IS_ATOMIC_WRITTEN_PAGE(page))
>  		return drop_inmem_page(inode, page);
> @@ -2292,6 +2295,8 @@ int f2fs_migrate_page(struct address_space *mapping,
>  		SetPagePrivate(newpage);
>  	set_page_private(newpage, page_private(page));
>  
> +	if (PageChecked(page))
> +		SetPageChecked(page);

Actually, migrate_page_copy will do this job.

>  	if (mode != MIGRATE_SYNC_NO_COPY)
>  		migrate_page_copy(newpage, page);
>  	else
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 7d63faf..905be02 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -220,6 +220,14 @@ static void recover_inode(struct inode *inode, struct page *page)
>  			ino_of_node(page), name);
>  }
>  
> +static void destroy_fsync_dnodes(struct list_head *head)
> +{
> +	struct fsync_inode_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, head, list)
> +		del_fsync_inode(entry);
> +}

How about moving this function behind del_fsync_inode?

> +
>  static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
>  				bool check_only)
>  {
> @@ -239,7 +247,14 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
>  			return 0;
>  
>  		page = get_tmp_page(sbi, blkaddr);
> +		if (PageChecked(page)) {
> +			f2fs_msg(sbi->sb, KERN_ERR, "Abandon dead loop node block list");

"Abandon looped node block list"

> +			destroy_fsync_dnodes(head);
> +			break;
> +		}
>  
> +		/* No need ClearPageChecked for page cache truncated */

/*
 * it's not needed to clear PG_checked flag in temp page since we
 * will truncate all those pages in the end of recovery.
 */

> +		SetPageChecked(page);

Will looks more neat to leave a blank line here.

Thanks,

>  		if (!is_recoverable_dnode(page))
>  			break;
>  
> @@ -288,14 +303,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
>  	return err;
>  }
>  
> -static void destroy_fsync_dnodes(struct list_head *head)
> -{
> -	struct fsync_inode_entry *entry, *tmp;
> -
> -	list_for_each_entry_safe(entry, tmp, head, list)
> -		del_fsync_inode(entry);
> -}
> -
>  static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
>  			block_t blkaddr, struct dnode_of_data *dn)
>  {
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
