From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: combine huge num of discard rb tree
 consistence checks
Date: Mon, 15 May 2017 19:20:05 +0800
Message-ID: <c4cf1267-ed7e-2187-4b57-b79590679123@huawei.com>
References: <1494842477-14116-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dAE38-0001Il-34
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 May 2017 11:20:26 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dAE36-00087i-H4
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 May 2017 11:20:26 +0000
In-Reply-To: <1494842477-14116-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/5/15 18:01, Yunlei He wrote:
> Came across a hungtask caused by huge number of rb tree traversing
> during adding discard addrs in cp. This patch combine these consistence
> checks and move it to discard thread.

Need to remove all __check_rb_tree_consistence in __update_discard_tree_range.

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index de31030..878ac90 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -918,8 +918,6 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  			prev_dc->di.len += di.len;
>  			dcc->undiscard_blks += di.len;
>  			__relocate_discard_cmd(dcc, prev_dc);
> -			f2fs_bug_on(sbi,
> -				!__check_rb_tree_consistence(sbi, &dcc->root));
>  			di = prev_dc->di;
>  			tdc = prev_dc;
>  			merged = true;
> @@ -935,16 +933,12 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  			__relocate_discard_cmd(dcc, next_dc);
>  			if (tdc)
>  				__remove_discard_cmd(sbi, tdc);
> -			f2fs_bug_on(sbi,
> -				!__check_rb_tree_consistence(sbi, &dcc->root));
>  			merged = true;
>  		}
>  
>  		if (!merged) {
>  			__insert_discard_tree(sbi, bdev, di.lstart, di.start,
>  							di.len, NULL, NULL);
> -			f2fs_bug_on(sbi,
> -				!__check_rb_tree_consistence(sbi, &dcc->root));
>  		}
>   next:
>  		prev_dc = next_dc;
> @@ -983,6 +977,8 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
>  	int i, iter = 0;
>  
>  	mutex_lock(&dcc->cmd_lock);
> +	f2fs_bug_on(sbi,
> +		!__check_rb_tree_consistence(sbi, &dcc->root));
>  	blk_start_plug(&plug);
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>  		pend_list = &dcc->pend_list[i];
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
