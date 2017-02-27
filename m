From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: use MAX_FREE_NIDS for the free nids
	target
Date: Mon, 27 Feb 2017 14:14:12 +0800
Message-ID: <8e4f5ced-c15e-9048-26ef-bb8225977f43@huawei.com>
References: <8facba63-3a92-85a0-4257-9122fcb19fcd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciEZw-0002SN-L8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 06:14:36 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciEZt-0004c6-Um
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 06:14:36 +0000
In-Reply-To: <8facba63-3a92-85a0-4257-9122fcb19fcd@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/2/26 20:47, Kinglong Mee wrote:
> F2FS has define MAX_FREE_NIDS for maximum of cached free nids target.
> 
> #define MAX_FREE_NIDS   (NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES)
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>

All clean patches looks good to me.

To Jaegeuk, please add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/node.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 6d43095..9284f65 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1870,7 +1870,6 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>  	struct f2fs_journal *journal = curseg->journal;
>  	unsigned int i, idx;
> -	unsigned int target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
>  
>  	down_read(&nm_i->nat_tree_lock);
>  
> @@ -1886,7 +1885,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
>  			nid = i * NAT_ENTRY_PER_BLOCK + idx;
>  			add_free_nid(sbi, nid, true);
>  
> -			if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
> +			if (nm_i->nid_cnt[FREE_NID_LIST] >= MAX_FREE_NIDS)
>  				goto out;
>  		}
>  	}
> @@ -1912,7 +1911,6 @@ static int scan_nat_bits(struct f2fs_sb_info *sbi)
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct page *page;
>  	unsigned int i = 0;
> -	nid_t target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
>  	nid_t nid;
>  
>  	if (!enabled_nat_bits(sbi, NULL))
> @@ -1933,7 +1931,7 @@ static int scan_nat_bits(struct f2fs_sb_info *sbi)
>  		add_free_nid(sbi, nid, true);
>  	}
>  
> -	if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
> +	if (nm_i->nid_cnt[FREE_NID_LIST] >= MAX_FREE_NIDS)
>  		goto out;
>  	i++;
>  	goto check_empty;
> @@ -1951,7 +1949,7 @@ static int scan_nat_bits(struct f2fs_sb_info *sbi)
>  	scan_nat_page(sbi, page, nid);
>  	f2fs_put_page(page, 1);
>  
> -	if (nm_i->nid_cnt[FREE_NID_LIST] < target) {
> +	if (nm_i->nid_cnt[FREE_NID_LIST] < MAX_FREE_NIDS) {
>  		i++;
>  		goto check_partial;
>  	}
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
