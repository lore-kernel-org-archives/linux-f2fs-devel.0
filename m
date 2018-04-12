From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: use cur_map instead of ckpt_map
Date: Thu, 12 Apr 2018 15:37:00 -0700
Message-ID: <20180412223700.GA46603@jaegeuk-macbookpro.roam.corp.google.com>
References: <1523328631-6658-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f6kq4-0001Hx-GZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Apr 2018 22:37:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f6kq2-00C9Yh-Pt
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Apr 2018 22:37:08 +0000
Content-Disposition: inline
In-Reply-To: <1523328631-6658-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: zhangdianfang@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 04/10, Yunlei He wrote:
> In flush_sit_entries::add_discard_addrs path, cur_map and ckpt_map
> are the same, but in exist_trim_candidates::add_discard_addrs,
> cur_map is updated one, and newer than ckpt_map, so we need to use
> cur_map to check whether there are discard candidates.
> 
> v1->v2: one problem of check discard candidates reported by Chao,
> besides, update commit message.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 5854cc4..f5d0499 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1559,7 +1559,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>  
>  	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
>  	for (i = 0; i < entries; i++)
> -		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
> +		dmap[i] = force ? ~cur_map[i] & ~discard_map[i] :

NAK. We're able to loose data for roll-forward recovery.

>  				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
>  
>  	while (force || SM_I(sbi)->dcc_info->nr_discards <=
> -- 
> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
