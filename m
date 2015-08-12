From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs: callers take care of the page from bio error
Date: Wed, 12 Aug 2015 10:18:37 -0700
Message-ID: <20150812171837.GB27478@jaegeuk-mac02.mot.com>
References: <20150812104009.GB22571@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZPZfr-0003Wm-QV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Aug 2015 17:18:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZPZfp-00025u-QU for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Aug 2015 17:18:47 +0000
Content-Disposition: inline
In-Reply-To: <20150812104009.GB22571@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

On Wed, Aug 12, 2015 at 01:40:10PM +0300, Dan Carpenter wrote:
> Hello Jaegeuk Kim,
> 
> The patch 86531d6b84bc: "f2fs: callers take care of the page from bio
> error" from Jul 15, 2015, leads to the following static checker
> warning:
> 
> 	fs/f2fs/node.c:1042 ra_node_page()
> 	warn: 'err' can be either negative or positive
> 
> fs/f2fs/node.c
>   1025  void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
>   1026  {
>   1027          struct page *apage;
>   1028          int err;
>   1029  
>   1030          apage = find_get_page(NODE_MAPPING(sbi), nid);
>   1031          if (apage && PageUptodate(apage)) {
>   1032                  f2fs_put_page(apage, 0);
>   1033                  return;
>   1034          }
>   1035          f2fs_put_page(apage, 0);
>   1036  
>   1037          apage = grab_cache_page(NODE_MAPPING(sbi), nid);
>   1038          if (!apage)
>   1039                  return;
>   1040  
>   1041          err = read_node_page(apage, READA);
>   1042          f2fs_put_page(apage, err ? 1 : 0);
> 
> In the old code we took errors into consideration but now we treat them
> as LOCKED_PAGE.  Is that intentional?  A lot of the other callers in
> that patch still check for errors...

This is just for read-ahead node page function.
So, yes, if it returns LOCKED_PAGE or any error, the page must be unlocked
via f2fs_put_page(1).
Otherwise, end_io will unlock the page.

Hmm, any workaround to avoid that warning?

Thanks,

> 
>   1043  }
> 
> regards,
> dan carpenter

------------------------------------------------------------------------------
