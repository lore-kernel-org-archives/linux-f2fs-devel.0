From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: fix bad assignment of
 total_sectors for f2fs_configuration
Date: Tue, 24 Jan 2017 11:06:56 +0800
Message-ID: <5886C4D0.8040601@huawei.com>
References: <130c919b-def1-33b1-0e16-e18e8de28d5c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1cVrS2-0007ij-KR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 03:07:18 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cVrRz-0004oB-U6
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 03:07:18 +0000
In-Reply-To: <130c919b-def1-33b1-0e16-e18e8de28d5c@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kinglong Mee <kinglongmee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi, Kinglong

On 1/24/2017 10:42 AM, Kinglong Mee wrote:
> wanted_total_sectors is introduced instead total_sectors,
> so that, the initialize is a fault, drop it.
> 
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> ---
>  mkfs/f2fs_format_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index db1dc94..5bb1faf 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -151,9 +151,6 @@ static void f2fs_parse_options(int argc, char *argv[])
>  		c.wanted_total_sectors = atoll(argv[optind+1]);
>  	}
>  
> -	if ((optind + 1) < argc)
> -		c.total_sectors = atoll(argv[optind+1]);
> -
Here we get the number of sectors specified by user, so that we could
create an image based on a specific size. There seems no fault. Could
you please give more detail :)

thanks,
Sheng
>  	if (c.zoned_mode)
>  		c.feature |= cpu_to_le32(F2FS_FEATURE_BLKZONED);
>  }
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
