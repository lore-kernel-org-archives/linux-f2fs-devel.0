From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH 12/12] f2fs: use extent_cache by default
Date: Thu, 2 Jul 2015 20:36:16 +0800
Message-ID: <COL402-EAS385C99A3E59C61CC6871C57AB970@phx.gbl>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-12-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZAdj9-0002zB-8n
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:36:27 +0000
Received: from col004-omc1s10.hotmail.com ([65.55.34.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAdj8-00080D-GT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:36:27 +0000
In-Reply-To: <1435603176-63219-12-git-send-email-jaegeuk@kernel.org>
Content-Language: zh-cn
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

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, June 30, 2015 2:40 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 12/12] f2fs: use extent_cache by default
> 
> We don't need to handle the duplicate extent infot showrmation.

information?

> 
> The integrated rule is:
>  - update on-disk extent with largest one tracked by in-memory extent_cache
>  - destroy extent_tree for the truncation case
>  - drop per-inode extent_cache by shrinker
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

[snip]

> @@ -538,7 +427,11 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>  		}
>  	}
> 
> -	return __attach_extent_node(sbi, et, ei, parent, p);
> +	en = __attach_extent_node(sbi, et, ei, parent, p);
> +update_out:
> +	if (en && en->ei.len > et->largest.len)
> +		et->largest = en->ei;

IMO, it's better to update cached_en here if it is invalid in
__detach_extent_node, then cached_en and largest may point different
extent info, it can expand our region of first level extent cache.

[snip]

> +
> +	/* free all extent info belong to this extent tree */
> +	f2fs_destroy_extent_node(inode);

How about returning number of freed extent node for tracing.

node_cnt = f2fs_destroy_extent_node(inode);

[snip]

> @@ -237,10 +237,11 @@ void update_inode(struct inode *inode, struct page *node_page)
>  	ri->i_size = cpu_to_le64(i_size_read(inode));
>  	ri->i_blocks = cpu_to_le64(inode->i_blocks);
> 
> -	read_lock(&F2FS_I(inode)->ext_lock);
> -	set_raw_extent(&F2FS_I(inode)->ext, &ri->i_ext);
> -	read_unlock(&F2FS_I(inode)->ext_lock);
> -
> +	if (F2FS_I(inode)->extent_tree)

Could extent cache destroy after above check?

Thanks,

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
