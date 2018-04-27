From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH f2fs] f2fs: release_discard_addr() can be
 static
Date: Fri, 27 Apr 2018 10:38:39 +0800
Message-ID: <ceab8f88-be4b-a69e-c121-be5b4036d2ee@huawei.com>
References: <201804270303.VPJ9nTL4%fengguang.wu@intel.com>
 <20180426195731.GA71397@xian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fBtHf-0005cY-Qj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 02:38:51 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBtHe-00DWl9-4v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 02:38:51 +0000
In-Reply-To: <20180426195731.GA71397@xian>
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
To: kbuild test robot <lkp@intel.com>, Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

Hi Fengguang, thanks for the fix.

To Jaegeuk, could you please merge it to original patch?

Thanks,

On 2018/4/27 3:57, kbuild test robot wrote:
> 
> Fixes: 6f89409e87ce ("f2fs: introduce release_discard_addr() for cleanup")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  segment.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8652cfd..a0fce5e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1598,7 +1598,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>  	return false;
>  }
>  
> -void release_discard_addr(struct discard_entry *entry)
> +static void release_discard_addr(struct discard_entry *entry)
>  {
>  	list_del(&entry->list);
>  	kmem_cache_free(discard_entry_slab, entry);
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
