From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: check node id earily when
	readahead	NAT page
Date: Tue, 05 Jan 2016 17:10:26 +0800
Message-ID: <00a001d14799$025f1850$071d48f0$@samsung.com>
References: <009e01d14796$5f09a870$1d1cf950$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aGNe8-0000bP-6K
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 09:11:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aGNe6-0006k4-4C
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 09:11:16 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0H02VBD2TDX4A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 05 Jan 2016 18:11:06 +0900 (KST)
In-reply-to: <009e01d14796$5f09a870$1d1cf950$@samsung.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

This patch adds check for some missing cases in ("f2fs: return early
when trying to read null nid "). Merging into that patch or merging
separately is ok to me.

Thanks,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Tuesday, January 05, 2016 4:52 PM
> To: Jaegeuk Kim
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: check node id earily when readahead NAT page
> 
> Add node id check in ra_node_page and get_node_page_ra like get_node_page.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/node.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 6d5f548..c1ddf3d 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1041,6 +1041,10 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
>  	struct page *apage;
>  	int err;
> 
> +	if (!nid)
> +		return;
> +	f2fs_bug_on(sbi, check_nid_range(sbi, nid));
> +
>  	apage = find_get_page(NODE_MAPPING(sbi), nid);
>  	if (apage && PageUptodate(apage)) {
>  		f2fs_put_page(apage, 0);
> @@ -1108,6 +1112,7 @@ struct page *get_node_page_ra(struct page *parent, int start)
>  	nid = get_nid(parent, start, false);
>  	if (!nid)
>  		return ERR_PTR(-ENOENT);
> +	f2fs_bug_on(sbi, check_nid_range(sbi, nid));
>  repeat:
>  	page = grab_cache_page(NODE_MAPPING(sbi), nid);
>  	if (!page)
> @@ -1127,9 +1132,9 @@ repeat:
>  	end = start + MAX_RA_NODE;
>  	end = min(end, NIDS_PER_BLOCK);
>  	for (i = start + 1; i < end; i++) {
> -		nid_t tnid = get_nid(parent, i, false);
> -		if (!tnid)
> -			continue;
> +		nid_t tnid;
> +
> +		tnid = get_nid(parent, i, false);
>  		ra_node_page(sbi, tnid);
>  	}
> 
> --
> 2.6.3
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
