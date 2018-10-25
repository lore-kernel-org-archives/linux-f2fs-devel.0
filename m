From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: export migration_granularity sysfs
 entry
Date: Thu, 25 Oct 2018 11:01:35 +0800
Message-ID: <a85b83ee-affb-138b-f804-0590eb2cd3be@huawei.com>
References: <20181024103728.9870-1-yuchao0@huawei.com>
 <20181024103728.9870-3-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yunlong.song@huawei.com>) id 1gFVuS-0007yA-Ir
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Oct 2018 03:02:08 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gFVuO-0029cR-Rw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Oct 2018 03:02:08 +0000
In-Reply-To: <20181024103728.9870-3-yuchao0@huawei.com>
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
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 2018/10/24 18:37, Chao Yu wrote:
> Add one sysfs entry to control migration granularity of GC in large
> section f2fs, it can be tuned to mitigate heavy overhead of migrating
> huge number of blocks in large section.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 9 +++++++++
>   fs/f2fs/sysfs.c                         | 7 +++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 3ac41774ad3c..a7ce33199457 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -92,6 +92,15 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>   Description:
>   		 Controls the number of trials to find a victim segment.
>   
> +What:		/sys/fs/f2fs/<disk>/migration_granularity
> +Date:		October 2018
> +Contact:	"Chao Yu" <yuchao0@huawei.com>
> +Description:
> +		 Controls migration granularity of garbage collection on large
> +		 section, it can let GC move partial segment{s} of one section
> +		 in one GC cycle, so that dispersing heavy overhead GC to
> +		 multiple lightweight one.
> +
>   What:		/sys/fs/f2fs/<disk>/dir_level
>   Date:		March 2014
>   Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 240e4881279e..b393fda6d6dc 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -246,6 +246,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "discard_granularity")) {

Should be migration_granularity ?

> +		if (t == 0 || t > sbi->segs_per_sec)
> +			return -EINVAL;
> +	}
> +
>   	if (!strcmp(a->attr.name, "trim_sections"))
>   		return -EINVAL;
>   
> @@ -406,6 +411,7 @@ F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
>   F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
>   F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, migration_granularity, migration_granularity);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
> @@ -460,6 +466,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(min_hot_blocks),
>   	ATTR_LIST(min_ssr_sections),
>   	ATTR_LIST(max_victim_search),
> +	ATTR_LIST(migration_granularity),
>   	ATTR_LIST(dir_level),
>   	ATTR_LIST(ram_thresh),
>   	ATTR_LIST(ra_nid_pages),

-- 
Thanks,
Yunlong Song
