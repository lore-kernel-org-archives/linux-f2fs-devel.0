From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/5] f2fs: clear the remaining prefree_map of
 the section
Date: Fri, 13 Jul 2018 11:13:54 +0800
Message-ID: <c9a3972b-dc52-19ca-7ed0-2f754d89ab33@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-3-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fdoXI-0006tr-Tr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 03:14:24 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdoXH-007gk5-27
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Jul 2018 03:14:24 +0000
In-Reply-To: <1531408170-45758-3-git-send-email-yunlong.song@huawei.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

On 2018/7/12 23:09, Yunlong Song wrote:
> For the case when sbi->segs_per_sec > 1, take section:segment = 5 for
> example, if the section prefree_map is ...previous section | current
> section (1 1 0 1 1) | next section..., then the start = x, end = x + 1,
> after start = start_segno + sbi->segs_per_sec, start = x + 5, then it
> will skip x + 3 and x + 4, but their bitmap is still set, which will
> cause duplicated f2fs_issue_discard of this same section in the next
> write_checkpoint, so fix it.

I didn't get it, if # 2 segment is not prefree state, so it still has valid
blocks there, so we won't issue discard due to below condition, right?

		if (!IS_CURSEC(sbi, secno) &&
			!get_valid_blocks(sbi, start, true))

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 47b6595..fd38b61 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1684,8 +1684,23 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  		start = start_segno + sbi->segs_per_sec;
>  		if (start < end)
>  			goto next;
> -		else
> -			end = start - 1;
> +		else {
> +			start_segno = start;
> +
> +			while (1) {
> +				start = find_next_bit(prefree_map, start_segno,
> +									end + 1);
> +				if (start >= start_segno)
> +					break;
> +				end = find_next_zero_bit(prefree_map, start_segno,
> +										start + 1);
> +				for (i = start; i < end; i++)
> +					clear_bit(i, prefree_map);
> +				dirty_i->nr_dirty[PRE] -= end - start;
> +			}
> +
> +			end = start_segno - 1;
> +		}
>  	}
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
