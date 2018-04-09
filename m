From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: stop issue discard if something
 wrong with f2fs
Date: Mon, 9 Apr 2018 19:04:36 +0800
Message-ID: <1276efb6-ba79-a0c1-e7f9-779432bcd3e9@huawei.com>
References: <1523246090-22055-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f5UbR-00036M-9K
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:04:49 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5UbP-00519E-Ni
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 11:04:49 +0000
In-Reply-To: <1523246090-22055-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/4/9 11:54, Yunlei He wrote:
> This patch stop discard thread to issue discard io if
> something wrong with f2fs, which is similar to fstrim.
> 
> v1->v2: add fs error check in not only discard thread but also umount process
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 5854cc4..7f45cc4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1202,6 +1202,12 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	int i, iter = 0, issued = 0;
>  	bool io_interrupted = false;
>  
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +			"Found FS corruption, run fsck to fix.");

I think we don't need to print this message redundantly if we have print in all
places we set the flag.

So let's just skip issuing discard in async thread and __submit_discard_cmd.

> +		return issued;
> +	}
> +
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>  		if (i + 1 < dpolicy->granularity)
>  			break;
> @@ -1410,7 +1416,6 @@ static int issue_discard_thread(void *data)
>  			continue;
>  		if (kthread_should_stop())
>  			return 0;
> -

We'd better to avoid meaningless blank line removal.

Thank,s

>  		if (dcc->discard_wake)
>  			dcc->discard_wake = 0;
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
