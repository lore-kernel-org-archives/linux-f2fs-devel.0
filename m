From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: move_curseg_info only if
 check_curseg_offset fails
Date: Tue, 12 Sep 2017 09:19:19 +0800
Message-ID: <150fcefc-416e-7132-752a-c37f7ad88bf3@huawei.com>
References: <1505060436-45299-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1drZsa-0003n5-SK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 01:20:44 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1drZsW-0001xY-Tx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 01:20:44 +0000
In-Reply-To: <1505060436-45299-1-git-send-email-yunlong.song@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/9/11 0:20, Yunlong Song wrote:
> Current design will lose recovery process when check_curseg_offset is OK.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fsck/fsck.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index cb341ba..56a47be 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2026,9 +2026,11 @@ int fsck_verify(struct f2fs_sb_info *sbi)
>  			fix_hard_links(sbi);
>  			fix_nat_entries(sbi);
>  			rewrite_sit_area_bitmap(sbi);
> -			move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
> -			write_curseg_info(sbi);
> -			flush_curseg_sit_entries(sbi);
> +			if (check_curseg_offset(sbi)) {
> +				move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
> +				write_curseg_info(sbi);
> +				flush_curseg_sit_entries(sbi);
> +			}
>  			fix_checkpoint(sbi);
>  		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG)) {
>  			write_checkpoint(sbi);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
