From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: Do not issue small discards in LFS
 mode
Date: Fri, 26 May 2017 16:16:50 +0800
Message-ID: <9287ca85-e796-3216-6496-8ead3a786467@huawei.com>
References: <20170526080440.11160-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dEAQK-0002w2-2J
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 May 2017 08:16:40 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dEAQH-00031h-7E
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 May 2017 08:16:40 +0000
In-Reply-To: <20170526080440.11160-1-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org

On 2017/5/26 16:04, Damien Le Moal wrote:
> clear_prefree_segments() issues small discards after discarding full
> segments. These small discards may not be section aligned, so not zone
> aligned on a zoned block device, causing __f2fs_iissue_discard_zone() to fail.
> Fix this by not issuing small discards for a volume mounted with the BLKZONED
> feature enabled.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

This version looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9684585..1279650 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1322,7 +1322,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  					sbi->blocks_per_seg, cur_pos);
>  			len = next_pos - cur_pos;
>  
> -			if (force && len < cpc->trim_minlen)
> +			if (f2fs_sb_mounted_blkzoned(sbi->sb) ||
> +			    (force && len < cpc->trim_minlen))
>  				goto skip;
>  
>  			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
