From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Do not issue small discards in LFS mode
Date: Wed, 24 May 2017 19:13:51 +0800
Message-ID: <14e5d385-71ed-eb79-0e11-c0e9ef183df2@huawei.com>
References: <20170524050229.13213-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dDUDu-00069s-42
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 May 2017 11:13:02 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dDUDr-000786-Ph
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 May 2017 11:13:02 +0000
In-Reply-To: <20170524050229.13213-1-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org

Hi Damien,

On 2017/5/24 13:02, Damien Le Moal wrote:
> clear_prefree_segments() issues small discards after discarding full
> segments. These small discards may not be section aligned, so not zone
> aligned when using a zoned block device, or more generally, when
> mounted in LFS mode. So do not issue these small discards when mounted
> in LFS mode.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  fs/f2fs/segment.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9684585..3d190a7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1322,7 +1322,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  					sbi->blocks_per_seg, cur_pos);
>  			len = next_pos - cur_pos;
>  
> -			if (force && len < cpc->trim_minlen)
> +			if (test_opt(sbi, LFS) ||

Could we just check f2fs_sb_mounted_blkzoned here instead of F2FS_MOUNT_LFS here
? so a non-blkzoned device can enables small discard when user mount the device
with LFS option. Right?

Thanks,

> +			    (force && len < cpc->trim_minlen))
>  				goto skip;
>  
>  			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
