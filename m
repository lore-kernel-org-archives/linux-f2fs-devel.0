From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: write only the pages in range during
 defragment
Date: Mon, 14 Dec 2015 13:53:37 +0800
Message-ID: <001301d13633$df24d4e0$9d6e7ea0$@samsung.com>
References: <004a01d13631$1f332d00$5d998700$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8M5c-0001Yy-PQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 05:54:28 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8M5a-00055g-OP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 05:54:28 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZC00DUD3286640@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 14:54:18 +0900 (KST)
In-reply-to: <004a01d13631$1f332d00$5d998700$@samsung.com>
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
To: 'Fan Li' <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Monday, December 14, 2015 1:34 PM
> To: 'Jaegeuk Kim'
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: write only the pages in range during defragment
> 
> @lend of filemap_write_and_wait_range is supposed to be a "offset
> in bytes where the range ends (inclusive)". Subtract 1 to avoid
> writing an extra page.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
