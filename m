From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: stop issue discard if something
 wrong with f2fs
Date: Sun, 8 Apr 2018 16:26:23 +0800
Message-ID: <8ca9f7d4-d56a-7a1c-a245-a973bfe02649@huawei.com>
References: <1523171471-538-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f55ex-0006Fs-1y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 08:26:47 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f55es-002nvq-VX
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 08:26:47 +0000
In-Reply-To: <1523171471-538-1-git-send-email-heyunlei@huawei.com>
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

On 2018/4/8 15:11, Yunlei He wrote:
> This patch stop discard thread to issue discard io if
> something wrong with f2fs, which is similar to fstrim.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 5854cc4..f75f503 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1410,6 +1410,11 @@ static int issue_discard_thread(void *data)
>  			continue;
>  		if (kthread_should_stop())
>  			return 0;
> +		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> +			f2fs_msg(sbi->sb, KERN_WARNING,
> +				"Found FS corruption, run fsck to fix.");

__get_nat_bitmaps can set this flag during mounting? so its meaning is not only
indicate the image is corrupted but also mean that we need run fsck to recover
status like nat bitmaps?

Thanks,

> +			continue;
> +		}
>  
>  		if (dcc->discard_wake)
>  			dcc->discard_wake = 0;
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
