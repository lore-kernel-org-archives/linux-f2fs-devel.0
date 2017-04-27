From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/1] f2fs-tools: sanity check segno and
 blk_off when building curseg array
Date: Thu, 27 Apr 2017 15:41:48 -0700
Message-ID: <20170427224148.GA14138@jaegeuk.local>
References: <20170427220349.35334-1-jinqian@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d3s6p-0007Tw-7d
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 22:41:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d3s6n-0000Mi-6s
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 22:41:59 +0000
Content-Disposition: inline
In-Reply-To: <20170427220349.35334-1-jinqian@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jin Qian <jinqian@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jin,

On 04/27, Jin Qian wrote:
> segno and blk_off were read from input image without sanity check. This
> could lead to buffer overflow when accessing internal arrays like SIT
> sentries and seg_entry cur_valid_map.
> 
> Signed-off-by: Jin Qian <jinqian@google.com>
> ---
>  fsck/mount.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index ffaa0ed..749c417 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1040,6 +1040,9 @@ static void build_curseg(struct f2fs_sb_info *sbi)
>  			blk_off = get_cp(cur_node_blkoff[i - CURSEG_HOT_NODE]);
>  			segno = get_cp(cur_node_segno[i - CURSEG_HOT_NODE]);
>  		}
> +		ASSERT(segno < TOTAL_SEGS(sbi));
> +		ASSERT((blk_off >> 3) < SIT_VBLOCK_MAP_SIZE);

		ASSERT(blk_off < DEFAULT_BLOCKS_PER_SEGMENT);

Otherwise, blk_off can be cut by shift operation.

Thanks,

> +
>  		array[i].segno = segno;
>  		array[i].zone = GET_ZONENO_FROM_SEGNO(sbi, segno);
>  		array[i].next_segno = NULL_SEGNO;
> -- 
> 2.13.0.rc0.306.g87b477812d-goog

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
