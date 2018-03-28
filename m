From: Junling Zheng <zhengjunling@huawei.com>
Subject: Re: [PATCH] libf2fs: reset wanted_total_sectors by new
 sector_size
Date: Wed, 28 Mar 2018 10:40:11 +0800
Message-ID: <e09755ce-9610-99e9-bf18-63be01aa82c3@huawei.com>
References: <20180327171908.15092-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1f111u-0007pM-EV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 02:41:38 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f111r-00Bsjk-Nx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Mar 2018 02:41:38 +0000
In-Reply-To: <20180327171908.15092-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: katao@xiaomi.com, jaegeuk@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi, Jaegeuk:

On 2018/3/28 1:19, Jaegeuk Kim wrote:
> From: katao <katao@xiaomi.com>
> 
> The args of wanted_total_sectors is calculated based
> on the DEFAULT_SECTOR_SIZE(512Bytes).get_device_info(i)
> may be reset dev_sector_size, we should reset the number
> of wanted_total_sectors.
> 
> This bug was reported to Google Issue Tracker.
> Link: https://issuetracker.google.com/issues/76407663
> 

This fix is puzzling...

IMO, we should not recalculate wanted_total_sectors here.
c.wanted_total_sectors is got from user in f2fs_parse_options.
Users must know the sector size of device they use, and they need to
pass a correct wanted_total_sectors to mkfs.f2fs.

Thanks,
Junling

> Signed-off-by: katao <katao@xiaomi.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> ---
>  lib/libf2fs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 0c684d5..5f11796 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -799,8 +799,15 @@ int get_device_info(int i)
>  #ifdef BLKSSZGET
>  		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
>  			MSG(0, "\tError: Using the default sector size\n");
> -		else if (dev->sector_size < sector_size)
> +		else if (dev->sector_size < sector_size){
> +			/*
> +			 * wanted_total_sectors need to be reset by new
> +			 * sector_size.
> +			 */
> +			c.wanted_total_sectors = (c.wanted_total_sectors *
> +						dev->sector_size) / sector_size;
>  			dev->sector_size = sector_size;
> +		}
>  #endif
>  #ifdef BLKGETSIZE64
>  		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
> 



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
