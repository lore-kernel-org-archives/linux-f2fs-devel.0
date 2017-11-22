From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v3 RESEND] f2fs: add bug_on when f2fs_gc even
 fails to get one victim
Date: Wed, 22 Nov 2017 11:50:10 +0800
Message-ID: <ad823d10-ac5c-095d-2eb6-5f84c559a098@huawei.com>
References: <1510880948-154538-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eHM3y-0000RK-Gr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 03:51:02 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eHM3w-0006kh-8G
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 03:51:02 +0000
In-Reply-To: <1510880948-154538-1-git-send-email-yunlong.song@huawei.com>
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
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

ping again...

On 2017/11/17 9:09, Yunlong Song wrote:
> This can help to find potential bugs on some corner case.
>
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fs/f2fs/gc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5d5bba4..c89128b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1035,6 +1035,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>   		goto stop;
>   	}
>   	if (!__get_victim(sbi, &segno, gc_type)) {
> +		f2fs_bug_on(sbi, !total_freed && has_not_enough_free_secs(sbi, 0, 0));
>   		ret = -ENODATA;
>   		goto stop;
>   	}

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
