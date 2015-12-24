From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/4] f2fs: return early when trying to read null
	nid
Date: Thu, 24 Dec 2015 13:49:24 +0800
Message-ID: <015401d13e0e$f214f8e0$d63eeaa0$@samsung.com>
References: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
 <1450923320-41113-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1450923320-41113-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, December 24, 2015 10:15 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/4] f2fs: return early when trying to read null nid
> 
> If get_node_page() gets zero nid, we can return early without getting a wrong
> page. For example, get_dnode_of_data() can try to do that.

Good catch!

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 341de5d..e17128d 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1059,6 +1059,9 @@ struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
>  {
>  	struct page *page;
>  	int err;
> +
> +	if (!nid)
> +		return ERR_PTR(-ENOENT);

How about expand to check upper and lower boundary:

	if (check_nid_range)
		return ERR_PTR(-ENOENT);

Thanks,

>  repeat:
>  	page = grab_cache_page(NODE_MAPPING(sbi), nid);
>  	if (!page)
> --
> 2.5.4 (Apple Git-61)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

