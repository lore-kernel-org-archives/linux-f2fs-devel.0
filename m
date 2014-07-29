From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 04/11] f2fs: use radix_tree for ino management
Date: Tue, 29 Jul 2014 19:32:08 +0800
Message-ID: <008001cfab20$d5e6ce50$81b46af0$@samsung.com>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
	<1406328445-63707-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XC5eR-0004R5-2a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:33:03 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XC5eP-0006wk-Cu
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 11:33:03 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9H00DRY1EUWA70@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 20:32:54 +0900 (KST)
In-reply-to: <1406328445-63707-4-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

One comment as following.

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, July 26, 2014 6:47 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 04/11] f2fs: use radix_tree for ino management
> 
> For better ino management, this patch replaces the data structure from list
> to radix tree.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/checkpoint.c | 48 ++++++++++++++++++++++++++----------------------
>  fs/f2fs/f2fs.h       |  1 +
>  2 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index f93d154..d35094a 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -284,24 +284,26 @@ const struct address_space_operations f2fs_meta_aops = {
> 
>  static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
>  {
> -	struct ino_entry *new, *e;
> -
> -	new = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC);
> -	new->ino = ino;
> -
> +	struct ino_entry *e;
> +retry:
>  	spin_lock(&sbi->ino_lock[type]);
> -	list_for_each_entry(e, &sbi->ino_list[type], list) {
> -		if (e->ino == ino) {
> +
> +	e = radix_tree_lookup(&sbi->ino_root[type], ino);
> +	if (!e) {
> +		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC);
> +		if (!e) {
>  			spin_unlock(&sbi->ino_lock[type]);
> -			kmem_cache_free(ino_entry_slab, new);
> -			return;
> +			goto retry;
>  		}
> -		if (e->ino > ino)
> -			break;
> -	}
> +		if (radix_tree_insert(&sbi->ino_root[type], ino, e)) {
> +			spin_unlock(&sbi->ino_lock[type]);

we should add kmem_cache_free(ino_entry_slab, e) here to avoid memory leak.

> +			goto retry;
> +		}
> +		memset(e, 0, sizeof(struct ino_entry));
> +		e->ino = ino;
> 
> -	/* add new entry into list which is sorted by inode number */
> -	list_add_tail(&new->list, &e->list);
> +		list_add_tail(&e->list, &sbi->ino_list[type]);
> +	}
>  	spin_unlock(&sbi->ino_lock[type]);
>  }
> 
> @@ -310,14 +312,15 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int
> type)
>  	struct ino_entry *e;
> 
>  	spin_lock(&sbi->ino_lock[type]);
> -	list_for_each_entry(e, &sbi->ino_list[type], list) {
> -		if (e->ino == ino) {
> -			list_del(&e->list);
> +	e = radix_tree_lookup(&sbi->ino_root[type], ino);
> +	if (e) {
> +		list_del(&e->list);
> +		radix_tree_delete(&sbi->ino_root[type], ino);
> +		if (type == ORPHAN_INO)
>  			sbi->n_orphans--;
> -			spin_unlock(&sbi->ino_lock[type]);
> -			kmem_cache_free(ino_entry_slab, e);
> -			return;
> -		}
> +		spin_unlock(&sbi->ino_lock[type]);
> +		kmem_cache_free(ino_entry_slab, e);
> +		return;
>  	}
>  	spin_unlock(&sbi->ino_lock[type]);
>  }
> @@ -346,7 +349,7 @@ void release_orphan_inode(struct f2fs_sb_info *sbi)
> 
>  void add_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>  {
> -	/* add new orphan entry into list which is sorted by inode number */
> +	/* add new orphan ino entry into list */
>  	__add_ino_entry(sbi, ino, ORPHAN_INO);
>  }
> 
> @@ -943,6 +946,7 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
>  	int i;
> 
>  	for (i = 0; i < MAX_INO_ENTRY; i++) {
> +		INIT_RADIX_TREE(&sbi->ino_root[i], GFP_ATOMIC);
>  		spin_lock_init(&sbi->ino_lock[i]);
>  		INIT_LIST_HEAD(&sbi->ino_list[i]);
>  	}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b6fa6ec..4454caa 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -456,6 +456,7 @@ struct f2fs_sb_info {
>  	wait_queue_head_t cp_wait;
> 
>  	/* for inode management */
> +	struct radix_tree_root ino_root[MAX_INO_ENTRY];	/* ino entry array */
>  	spinlock_t ino_lock[MAX_INO_ENTRY];		/* for ino entry lock */
>  	struct list_head ino_list[MAX_INO_ENTRY];	/* inode list head */
> 
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
