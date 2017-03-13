From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH] f2fs: cover update_free_nid_bitmap with
 free_list_lock
Date: Mon, 13 Mar 2017 20:22:34 +0800
Message-ID: <5cd19a42-0941-2dbd-fbae-b885b79cb227@gmail.com>
References: <20170313121041.121407-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cnOzz-0001yw-1U
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 12:22:51 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cnOzw-0003I5-U8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Mar 2017 12:22:51 +0000
Received: by mail-it0-f68.google.com with SMTP id g138so5741819itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 13 Mar 2017 05:22:48 -0700 (PDT)
In-Reply-To: <20170313121041.121407-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 3/13/2017 20:10, Chao Yu wrote:
> free_nid_bitmap and free_nid_count in update_free_nid_bitmap should be
> updated atomically, use free_list_lock cover them to avoid race in

nid_list_lock?

Reviewed-by: Kinglong Mee <kinglongmee@gmail.com>

> concurrent scenario.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h |  1 -
>  fs/f2fs/node.c | 27 +++++++++++----------------
>  2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 843ce39502bc..d905e53ba524 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -561,7 +561,6 @@ struct f2fs_nm_info {
>  	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
>  	unsigned char *nat_block_bitmap;
>  	unsigned short *free_nid_count;	/* free nid count of NAT block */
> -	spinlock_t free_nid_lock;	/* protect updating of nid count */
>  
>  	/* for checkpoint */
>  	char *nat_bitmap;		/* NAT bitmap pointer */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 11df8ab32478..3bfffd744f87 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1815,7 +1815,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
>  }
>  
>  static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
> -			bool set, bool build, bool locked)
> +							bool set, bool build)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
> @@ -1829,14 +1829,10 @@ static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
>  	else
>  		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>  
> -	if (!locked)
> -		spin_lock(&nm_i->free_nid_lock);
>  	if (set)
>  		nm_i->free_nid_count[nat_ofs]++;
>  	else if (!build)
>  		nm_i->free_nid_count[nat_ofs]--;
> -	if (!locked)
> -		spin_unlock(&nm_i->free_nid_lock);
>  }
>  
>  static void scan_nat_page(struct f2fs_sb_info *sbi,
> @@ -1865,7 +1861,9 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
>  		if (blk_addr == NULL_ADDR)
>  			freed = add_free_nid(sbi, start_nid, true);
> -		update_free_nid_bitmap(sbi, start_nid, freed, true, false);
> +		spin_lock(&NM_I(sbi)->nid_list_lock);
> +		update_free_nid_bitmap(sbi, start_nid, freed, true);
> +		spin_unlock(&NM_I(sbi)->nid_list_lock);
>  	}
>  }
>  
> @@ -2020,7 +2018,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>  		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
>  		nm_i->available_nids--;
>  
> -		update_free_nid_bitmap(sbi, *nid, false, false, false);
> +		update_free_nid_bitmap(sbi, *nid, false, false);
>  
>  		spin_unlock(&nm_i->nid_list_lock);
>  		return true;
> @@ -2076,7 +2074,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>  
>  	nm_i->available_nids++;
>  
> -	update_free_nid_bitmap(sbi, nid, true, false, false);
> +	update_free_nid_bitmap(sbi, nid, true, false);
>  
>  	spin_unlock(&nm_i->nid_list_lock);
>  
> @@ -2406,11 +2404,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  			add_free_nid(sbi, nid, false);
>  			spin_lock(&NM_I(sbi)->nid_list_lock);
>  			NM_I(sbi)->available_nids++;
> -			update_free_nid_bitmap(sbi, nid, true, false, false);
> +			update_free_nid_bitmap(sbi, nid, true, false);
>  			spin_unlock(&NM_I(sbi)->nid_list_lock);
>  		} else {
>  			spin_lock(&NM_I(sbi)->nid_list_lock);
> -			update_free_nid_bitmap(sbi, nid, false, false, false);
> +			update_free_nid_bitmap(sbi, nid, false, false);
>  			spin_unlock(&NM_I(sbi)->nid_list_lock);
>  		}
>  	}
> @@ -2535,10 +2533,10 @@ inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
>  		nid = i * NAT_ENTRY_PER_BLOCK;
>  		last_nid = (i + 1) * NAT_ENTRY_PER_BLOCK;
>  
> -		spin_lock(&nm_i->free_nid_lock);
> +		spin_lock(&NM_I(sbi)->nid_list_lock);
>  		for (; nid < last_nid; nid++)
> -			update_free_nid_bitmap(sbi, nid, true, true, true);
> -		spin_unlock(&nm_i->free_nid_lock);
> +			update_free_nid_bitmap(sbi, nid, true, true);
> +		spin_unlock(&NM_I(sbi)->nid_list_lock);
>  	}
>  
>  	for (i = 0; i < nm_i->nat_blocks; i++) {
> @@ -2629,9 +2627,6 @@ static int init_free_nid_cache(struct f2fs_sb_info *sbi)
>  					sizeof(unsigned short), GFP_KERNEL);
>  	if (!nm_i->free_nid_count)
>  		return -ENOMEM;
> -
> -	spin_lock_init(&nm_i->free_nid_lock);
> -
>  	return 0;
>  }
>  
> 

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
