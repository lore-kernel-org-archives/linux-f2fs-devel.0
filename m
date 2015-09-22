From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: f2fs: reorganize f2fs_map_blocks
Date: Tue, 22 Sep 2015 21:21:01 +0800
Message-ID: <00d701d0f539$9eadb6b0$dc092410$@samsung.com>
References: <20150921162508.GD5648@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZeNW2-0001ps-Td
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 13:21:50 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZeNW0-0006R9-Tc
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 13:21:50 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NV202WXVYG4TF40@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 22:21:41 +0900 (KST)
In-reply-to: <20150921162508.GD5648@mwanda>
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
To: 'Dan Carpenter' <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, September 22, 2015 12:25 AM
> To: chao2.yu@samsung.com
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: re: f2fs: reorganize f2fs_map_blocks
> 
> Hello Chao Yu,
> 
> The patch bce86a6c64a7: "f2fs: reorganize f2fs_map_blocks" from Sep
> 11, 2015, leads to the following static checker warning:
> 
> 	fs/f2fs/data.c:653 f2fs_map_blocks()
> 	warn: was || intended here instead of &&?
> 
> fs/f2fs/data.c
>    650          if (maxblocks > map->m_len) {
>    651                  block_t blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
>    652
>    653                  if (blkaddr == NEW_ADDR && blkaddr == NULL_ADDR) {
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Impossible condition.

Thanks for pointing it out. :)

My v2 patch sent several days ago has fixed that issue.

Thanks,


------------------------------------------------------------------------------
