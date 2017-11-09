From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATHC 1/2] f2fs: apply write hints to select
 the type of segments for buffered write
Date: Thu, 9 Nov 2017 16:21:25 +0800
Message-ID: <89790335-1d07-9280-ef17-1bdaeaafb54b@huawei.com>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
 <1510206688-12767-2-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eCi7M-0002L0-4H
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 08:23:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eCi7J-0002dC-RQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 08:23:20 +0000
In-Reply-To: <1510206688-12767-2-git-send-email-hyc.lee@gmail.com>
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
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/11/9 13:51, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> Write hints helps F2FS to determine which type of segments would be
> selected for buffered write.
> 
> This patch implements the mapping from write hints to segment types
> as shown below.
> 
>   hints               segment type
>   -----               ------------
>   WRITE_LIFE_SHORT    CURSEG_COLD_DATA
>   WRITE_LIFE_EXTREME  CURSEG_HOT_DATA

Should keep consistent with code implementation.

	WRITE_LIFE_SHORT    CURSEG_HOT_DATA
	WRITE_LIFE_EXTREME  CURSEG_COLD_DATA

>   others              CURSEG_WARM_DATA
> 
> the F2FS poliy for hot/cold seperation has precedence over this hints.
> And hints are not applied in in-place update.
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/segment.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c695ff4..45aef53 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2258,6 +2258,18 @@ static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
>  	return false;
>  }
>  
> +int rw_hint_to_seg_type(enum rw_hint hint)
> +{
> +	switch (hint) {
> +	case WRITE_LIFE_SHORT:
> +		return CURSEG_HOT_DATA;
> +	case WRITE_LIFE_EXTREME:
> +		return CURSEG_COLD_DATA;
> +	default:
> +		return CURSEG_WARM_DATA;
> +	}
> +}
> +
>  static int __get_segment_type_2(struct f2fs_io_info *fio)
>  {
>  	if (fio->type == DATA)
> @@ -2292,7 +2304,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  			return CURSEG_COLD_DATA;
>  		if (is_inode_flag_set(inode, FI_HOT_DATA))
>  			return CURSEG_HOT_DATA;
> -		return CURSEG_WARM_DATA;
> +		return rw_hint_to_seg_type(inode->i_write_hint);
>  	} else {
>  		if (IS_DNODE(fio->page))
>  			return is_cold_node(fio->page) ? CURSEG_WARM_NODE :
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
