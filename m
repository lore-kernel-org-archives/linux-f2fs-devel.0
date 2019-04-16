From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: avoid retrying quota flushes while the
 device is congested
Date: Tue, 16 Apr 2019 09:57:58 +0800
Message-ID: <549ff0f7-6111-e844-d03d-1c3879d4ae36@huawei.com>
References: <20190415130703.23983-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hGDMQ-0002wj-Bt
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 01:58:10 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGDMO-007nsQ-Ep
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 01:58:10 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 2E19C59BB0145B12481A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Apr 2019 09:58:00 +0800 (CST)
In-Reply-To: <20190415130703.23983-1-qkrwngud825@gmail.com>
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
To: Park Ju Hyung <qkrwngud825@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Ju Hyung,

On 2019/4/15 21:07, Park Ju Hyung wrote:
> While experimenting with ICE/FBE + f2fs on an Android device,
> I was able to reliably reproduce quota corruption during
> initial setup wizard.
> 
> During 10 times of factory resets, quota flushes failed 5 times each
> in average.

I knew this works in scenario cell phone suffers sudden power-cut frequently,
actually, in a normal case, if there is race in between checkpoint() and quota
updater, checkpoint() may suffer longer delay than before.

So I suggest we keep the logic as it is, since sudden power-cut is not a common
case, even in such case, quota sysfile is corrupted, we have another chance to
repair it with fsck-tools, right?

Thanks,

> 
> Add a wait for uncongestion on quota flush retries to resolve the issue.
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>  fs/f2fs/checkpoint.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index a98e1b02279e..e63cfab6be5d 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1130,6 +1130,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  	f2fs_lock_all(sbi);
>  	if (__need_flush_quota(sbi)) {
>  		f2fs_unlock_all(sbi);
> +		congestion_wait(BLK_RW_ASYNC, HZ/50);
>  		cond_resched();
>  		goto retry_flush_quotas;
>  	}
> 
