From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: Change the timing of
 f2fs_wait_on_page_writeback
Date: Tue, 04 Aug 2015 18:00:45 +0800
Message-ID: <005701d0ce9c$83189230$8949b690$@samsung.com>
References: <000901d0ce76$64916f60$2db44e20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZMZ2H-0001qB-MX
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Aug 2015 10:01:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZMZ2F-0002r2-Qu
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Aug 2015 10:01:29 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSJ00L9BYI4Y7D0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Aug 2015 19:01:20 +0900 (KST)
In-reply-to: <000901d0ce76$64916f60$2db44e20$@samsung.com>
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
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Tuesday, August 04, 2015 1:28 PM
> To: jaegeuk@kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: Change the timing of f2fs_wait_on_page_writeback
> 
> some backing devices need pages to be stable during writeback. It doesn't
> matter if
> the page is completely overwritten or already uptodate, it needs to wait
> before write.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
