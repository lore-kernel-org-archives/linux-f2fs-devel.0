From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: collect prefree segments to avoild
 write checkpoint fail
Date: Mon, 28 Aug 2017 17:52:46 +0800
Message-ID: <b0e3c139-1458-ff89-9ac8-8cba0ebef421@huawei.com>
References: <1503748019-152845-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dmGjL-0003Zh-3L
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Aug 2017 09:53:15 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dmGjJ-0003aA-Su
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Aug 2017 09:53:15 +0000
In-Reply-To: <1503748019-152845-1-git-send-email-yunlong.song@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlong,

On 2017/8/26 19:46, Yunlong Song wrote:
> In come corner case, the reserved segments are used to do gc, and there are
> not enough free segments for write checkpoint to finish its job, then the
> gc process will fail to change the prefree segments to free segments.

How about doing investigate that why we haven't enough free segment for GC?

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index cd147e7..c8a828f 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1056,6 +1056,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  	if (!sync) {
>  		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>  			segno = NULL_SEGNO;
> +			if (prefree_segments(sbi) &&
> +				has_not_enough_free_secs(sbi,
> +					reserved_sections(sbi), 0)) {
> +				ret = write_checkpoint(sbi, &cpc);
> +				if (ret)
> +					goto stop;
> +			}
>  			goto gc_more;
>  		}
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
