From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH v2] f2fs-tools: set segment_count in super
 block correctly
Date: Thu, 4 Feb 2016 10:51:55 +0800
Message-ID: <56B2BCCB.3080308@huawei.com>
References: <000c01d15e44$0401d0f0$0c0572d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1aRA29-0005eG-Lx
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Feb 2016 02:52:37 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aRA23-0004Al-E7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Feb 2016 02:52:37 +0000
In-Reply-To: <000c01d15e44$0401d0f0$0c0572d0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, heyunlei@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2016/2/3 13:29, Fan Li wrote:
> Now f2fs will check statistics recorded in super block in 
> sanity_check_area_boundary() during mount,if number of segments per 
> section is greater than 1, and the disk space isn't aligned with section,

Hi Fan, Hi Kim:

I'm uncertain about which unit the disk space should be aligned with? section or zone?

It looks like commit "e9dfbbb"(mkfs.f2fs: introduce zone align for main area)

from Yunlei had changed the aligning unit from section to zone.

So, should segment_count in superblock be aligned with zone rather than section?

Thanks,

Junling

> mount will fail due to following condition:
> 
> main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
> 		segment0_blkaddr + (segment_count << log_blocks_per_seg)
> 
> this is because when the length of main area isn't aligned with section, 
> mkfs didn't add the number of excess segments to segment_count_main, but 
> add it to segment_count. 
> Here align segment_count with section size first to prevent such problem.
> 
> Signed-off-by: Fan Li <fanofcode.li@samsung.com>
> ---
>  mkfs/f2fs_format.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 66d7342..3366302 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -174,7 +174,8 @@ static int f2fs_prepare_super_block(void)
>         }
> 
>         set_sb(segment_count, (config.total_sectors * config.sector_size -
> -                               zone_align_start_offset) / segment_size_bytes);
> +                               zone_align_start_offset) / segment_size_bytes /
> +                               config.segs_per_sec * config.segs_per_sec);
> 
>         set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
>         sb->cp_blkaddr = sb->segment0_blkaddr;
> 



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
