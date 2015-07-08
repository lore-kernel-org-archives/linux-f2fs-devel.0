From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: Don't try to split extents shorter
 than F2FS_MIN_EXTENT_LEN
Date: Wed, 08 Jul 2015 18:26:06 +0800
Message-ID: <00bd01d0b968$9ceefdf0$d6ccf9d0$@samsung.com>
References: <000b01d0b954$943ecf00$bcbc6d00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZCmZD-0001J4-IB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 10:27:03 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZCmZB-0004g3-SV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 10:27:03 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NR5001TNZOUMXA0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jul 2015 19:26:54 +0900 (KST)
In-reply-to: <000b01d0b954$943ecf00$bcbc6d00$@samsung.com>
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
To: 'Fan Li' <fanofcode.li@samsung.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Wednesday, July 08, 2015 4:03 PM
> To: jaegeuk@kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: Don't try to split extents shorter than F2FS_MIN_EXTENT_LEN
> 
> Since only parts of extents longer than F2FS_MIN_EXTENT_LEN will
> be kept in extent cache after split, extents already shorter than
> F2FS_MIN_EXTENT_LEN don't need to try split at all.
> 
> 
> Signed-off-by: Fan Li <fanofcode.li@samsung.com>

Looks good to me.

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
