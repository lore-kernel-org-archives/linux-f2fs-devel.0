From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid hungtask problem caused by
 f2fs_balance_fs
Date: Fri, 26 Feb 2016 23:54:02 +0800
Message-ID: <56D0751A.8090402@kernel.org>
References: <1456470819-30481-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1aZKil-0003z2-Sv
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 15:54:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aZKik-0003uJ-1G
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 15:54:23 +0000
In-Reply-To: <1456470819-30481-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, chao2.yu@samsung.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

On 2016/2/26 15:13, Yunlei He wrote:
> I came across a hungtask problem as below:
> 
> INFO: task 962 blocked for more than 120 s.
> 
> Call trace:
> [<ffffffc000085a24>] __switch_to+0x74/0x8c
> [<ffffffc000dd1434>] __schedule+0x3b4/0x8f4
> [<ffffffc000dd1998>] schedule+0x24/0x68
> [<ffffffc000dd1e80>] schedule_preempt_disabled+0x10/0x24
> [<ffffffc000dd04b4>] __mutex_lock_slowpath+0x154/0x26c
> [<ffffffc000dd0610>] mutex_lock+0x44/0x64
> [<ffffffc0003471d0>] f2fs_balance_fs+0x78/0x94
> [<ffffffc00032ca00>] f2fs_create+0x30/0x1d4
> [<ffffffc0001a5e40>] vfs_create+0xc8/0xf8
> [<ffffffc0001a7a34>] do_last.isra.43+0x608/0xc44
> [<ffffffc0001a8118>] path_openat.isra.44+0xa8/0x4b0
> [<ffffffc0001a92dc>] do_filp_open+0x2c/0x98
> [<ffffffc000198da0>] do_sys_open+0x104/0x1c8
> [<ffffffc000198e98>] SyS_openat+0xc/0x18
> 
> Besides, there are also lots of other operations were blocked
> by gc_mutex like here.
> 
> The comments said we should do GC or end up with checkpoint, if there
> are so many dirty dir/node pages without enough free segments. But should
> all theads wait for gc if the condition is not satisfied? Maybe if someone
> is gcing, they can by pass it.

I don't think so, once there is one thread goes into GC flow, if we don't block
all other foreground gc threads here, these concurrent threads may generate more
dirty node/dentry pages, which can easily lead sync_node_pages in GC or
checkpoint runs out of free sections.

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6f16b39..48ce7ab 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -345,8 +345,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>  	 * We should do GC or end up with checkpoint, if there are so many dirty
>  	 * dir/node pages without enough free segments.
>  	 */
> -	if (has_not_enough_free_secs(sbi, 0)) {
> -		mutex_lock(&sbi->gc_mutex);
> +	if (has_not_enough_free_secs(sbi, 0) &&
> +					mutex_trylock(&sbi->gc_mutex)) {
>  		f2fs_gc(sbi, false);
>  	}
>  }
> 

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
