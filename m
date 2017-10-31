From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v2] f2fs: collect prefree segments to avoild
 write checkpoint fail
Date: Tue, 31 Oct 2017 09:33:54 +0800
Message-ID: <e7966d00-c63c-060b-2b1d-c9a9cb134b3b@huawei.com>
References: <1503748019-152845-1-git-send-email-yunlong.song@huawei.com>
 <1504267219-76575-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1e9LSb-00056m-6m
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 01:35:21 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e9LSZ-0006ji-RF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Oct 2017 01:35:21 +0000
In-Reply-To: <1504267219-76575-1-git-send-email-yunlong.song@huawei.com>
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

ping...

On 2017/9/1 20:00, Yunlong Song wrote:
> In come corner case, the reserved segments are used to do gc, and there are
> not enough free segments for write checkpoint to finish its job, then the
> gc process will fail to change the prefree segments to free segments.
>
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fs/f2fs/gc.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index cd147e7..6552b04 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1056,6 +1056,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>   	if (!sync) {
>   		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>   			segno = NULL_SEGNO;
> +#ifndef CONFIG_F2FS_CHECK_FS
> +			if (prefree_segments(sbi) &&
> +				has_not_enough_free_secs(sbi,
> +					reserved_sections(sbi), 0)) {
> +				ret = write_checkpoint(sbi, &cpc);
> +				if (ret)
> +					goto stop;
> +				sec_freed = 0;
> +			}
> +#endif
>   			goto gc_more;
>   		}
>   

-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
