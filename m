From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: combine nat_bits and
	free_nid_bitmap cache
Date: Wed, 8 Mar 2017 19:16:49 +0800
Message-ID: <dd51e53e-aa4a-7879-1e77-839c22bc66cf@huawei.com>
References: <20170306131241.36042-1-yuchao0@huawei.com>
	<20170307222714.GB2499@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1clZam-0001E6-8I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 11:17:16 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1clZak-0000Ni-Ks
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 11:17:16 +0000
In-Reply-To: <20170307222714.GB2499@jaegeuk.local>
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

On 2017/3/8 6:27, Jaegeuk Kim wrote:
> Hi Chao,
> 
> There were two reasons for slow down; one is set_bit_le and the other was 
> spin_lock calls.
> 
> I think it would'b good to merge this patch in yours as well.
> Let me know. I'm ready to integrate together and test them.

The change looks good to me. ;)

Anyway I will send last updated patch which you have merged in order to tracking
others' comments if there will be.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 3377a512e299..0a1ea59c9d31 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1815,7 +1815,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
>  }
>  
>  void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
> -							bool set, bool build)
> +			bool set, bool build, bool locked)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
> @@ -1829,12 +1829,14 @@ void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
>  	else
>  		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
>  
> -	spin_lock(&nm_i->free_nid_lock);
> +	if (!locked)
> +		spin_lock(&nm_i->free_nid_lock);
>  	if (set)
>  		nm_i->free_nid_count[nat_ofs]++;
>  	else if (!build)
>  		nm_i->free_nid_count[nat_ofs]--;
> -	spin_unlock(&nm_i->free_nid_lock);
> +	if (!locked)
> +		spin_unlock(&nm_i->free_nid_lock);
>  }
>  
>  static void scan_nat_page(struct f2fs_sb_info *sbi,
> @@ -1863,7 +1865,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
>  		if (blk_addr == NULL_ADDR)
>  			freed = add_free_nid(sbi, start_nid, true);
> -		update_free_nid_bitmap(sbi, start_nid, freed, true);
> +		update_free_nid_bitmap(sbi, start_nid, freed, true, false);
>  	}
>  }
>  
> @@ -2018,7 +2020,7 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
>  		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
>  		nm_i->available_nids--;
>  
> -		update_free_nid_bitmap(sbi, *nid, false, false);
> +		update_free_nid_bitmap(sbi, *nid, false, false, false);
>  
>  		spin_unlock(&nm_i->nid_list_lock);
>  		return true;
> @@ -2074,7 +2076,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
>  
>  	nm_i->available_nids++;
>  
> -	update_free_nid_bitmap(sbi, nid, true, false);
> +	update_free_nid_bitmap(sbi, nid, true, false, false);
>  
>  	spin_unlock(&nm_i->nid_list_lock);
>  
> @@ -2404,11 +2406,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  			add_free_nid(sbi, nid, false);
>  			spin_lock(&NM_I(sbi)->nid_list_lock);
>  			NM_I(sbi)->available_nids++;
> -			update_free_nid_bitmap(sbi, nid, true, false);
> +			update_free_nid_bitmap(sbi, nid, true, false, false);
>  			spin_unlock(&NM_I(sbi)->nid_list_lock);
>  		} else {
>  			spin_lock(&NM_I(sbi)->nid_list_lock);
> -			update_free_nid_bitmap(sbi, nid, false, false);
> +			update_free_nid_bitmap(sbi, nid, false, false, false);
>  			spin_unlock(&NM_I(sbi)->nid_list_lock);
>  		}
>  	}
> @@ -2533,8 +2535,10 @@ inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
>  		nid = i * NAT_ENTRY_PER_BLOCK;
>  		last_nid = (i + 1) * NAT_ENTRY_PER_BLOCK;
>  
> +		spin_lock(&nm_i->free_nid_lock);
>  		for (; nid < last_nid; nid++)
> -			update_free_nid_bitmap(sbi, nid, true, true);
> +			update_free_nid_bitmap(sbi, nid, true, true, true);
> +		spin_unlock(&nm_i->free_nid_lock);
>  	}
>  
>  	for (i = 0; i < nm_i->nat_blocks; i++) {
> 


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
