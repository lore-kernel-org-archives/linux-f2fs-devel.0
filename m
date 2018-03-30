From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] libf2fs: reset wanted_total_sectors by new
 sector_size
Date: Fri, 30 Mar 2018 17:28:31 +0800
Message-ID: <7561e573-9d88-60f0-868f-4a4b59d588cb@huawei.com>
References: <20180327171908.15092-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f1qL6-0008Pk-83
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 09:28:52 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1qL3-003CSZ-TG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 09:28:52 +0000
In-Reply-To: <20180327171908.15092-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: katao <katao@xiaomi.com>, Jaegeuk Kim <jaegeuk@google.com>

Hi All,

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

I don't think this is the right way, since now we have changed previous
sector_counter's meaning, some applications, for example, like xfstests will get
device's real sector size via blockdev --getsize64, then calculate total wanted
sector count by total_wanted_size / real_sector_size, if we changed default
sector size to 512bytes, xfstests will pass a wrong sector number, result in
getting wrong partition size.

For something worse, in order to get the correct sector number, we have to
change the way of calculation method of xfstests for new mkfs, but how can
xfstests know the current version of mkfs is new or old...

I think the change didn't consider backward compatibility of mkfs, so, in order
to keep that, we'd better to let user pass the right sector number based on
their device, or we can introduce a new parameter to indicate user wanted total
size.

How do you think?

Thanks,

> 
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
