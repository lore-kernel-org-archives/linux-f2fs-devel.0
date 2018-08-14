From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: set 4KB discard granularity by
 default
Date: Mon, 13 Aug 2018 21:13:29 -0700
Message-ID: <20180814041329.GB52730@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180810100806.9298-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fpQiA-0005mI-69
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Aug 2018 04:13:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fpQi8-002hKR-9x
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Aug 2018 04:13:38 +0000
Content-Disposition: inline
In-Reply-To: <20180810100806.9298-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 08/10, Chao Yu wrote:
> Small granularity (size < 64K) fragmentation will cause f2fs suspending
> all pending discards, result in performance regression, so let's set
> 4KB discard granularity by default.
> 
> So that without fstrim, we also have the ability to avoid any performance
> regression caused by non-alignment mapping between fs and flash device.

This is why we added a sysfs entry. Why do we need to change the default
value every time?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 58431b9bfd8f..273ffdaf4891 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -248,7 +248,7 @@ struct discard_entry {
>  };
>  
>  /* default discard granularity of inner discard thread, unit: block count */
> -#define DEFAULT_DISCARD_GRANULARITY		16
> +#define DEFAULT_DISCARD_GRANULARITY		1
>  
>  /* max discard pend list number */
>  #define MAX_PLIST_NUM		512
> -- 
> 2.18.0.rc1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
