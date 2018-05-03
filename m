From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: fix the way to wake up issue_flush
 thread
Date: Thu, 3 May 2018 15:57:29 +0800
Message-ID: <8ecda55f-1975-2797-41e4-eb72b492dcc3@huawei.com>
References: <1525333543-106702-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yunlong.song@huawei.com>) id 1fE990-0008NQ-Ve
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 May 2018 07:59:14 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fE98y-003Tif-4y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 May 2018 07:59:14 +0000
In-Reply-To: <1525333543-106702-1-git-send-email-yunlong.song@huawei.com>
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
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

Please avoid this patch, I make a mistake.

On 2018/5/3 15:45, Yunlong Song wrote:
> Commit 6f890df0 ("f2fs: fix out-of-order execution in f2fs_issue_flush")
> uses waitqueue_active to wake up issue_flush thread, but there is no
> wait entry to wake in this queue, so change it back to use the original
> fcc->dispatch_list to wake up issue_flush thread.
>
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fs/f2fs/segment.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 503a98a..5aa5ee4e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -612,7 +612,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
>   	/* update issue_list before we wake up issue_flush thread */
>   	smp_mb();
>   
> -	if (waitqueue_active(&fcc->flush_wait_queue))
> +	if (!fcc->dispatch_list)
>   		wake_up(&fcc->flush_wait_queue);
>   
>   	if (fcc->f2fs_issue_flush) {

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
