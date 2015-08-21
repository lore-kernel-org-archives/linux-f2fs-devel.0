From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 9/9] f2fs: update extent tree in batches
Date: Fri, 21 Aug 2015 20:54:44 +0800
Message-ID: <021801d0dc10$a4d36810$ee7a3830$@samsung.com>
References: <017d01d0da71$5780e8d0$0682ba70$@samsung.com>
	<20150820174738.GD42028@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZSlr7-0007QL-FG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Aug 2015 12:55:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZSlr5-0006UJ-GK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Aug 2015 12:55:37 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTF029INNWFX1C0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Aug 2015 21:55:27 +0900 (KST)
In-reply-to: <20150820174738.GD42028@jaegeuk-mac02.mot-mobility.com>
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

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, August 21, 2015 1:48 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 9/9] f2fs: update extent tree in batches
> 
> Hi Chao,
> 
> On Wed, Aug 19, 2015 at 07:21:48PM +0800, Chao Yu wrote:
> > This patch introduce a new helper f2fs_update_extent_tree_range
> > which can update extent nodes in extent tree in batches.
> >
> > Now, we use the function to invalidate blocks in batches instead of
> > invalidating them one by one when truncating blocks.
> 
> IMO, it's not clear the benefit of this patch in terms of performance and code
> readability versus risky code changes.

This is only used in truncate path, IMO, in theory, we can gain benefit from
this batch mode operation when truncating frequently.

I will test the patch for numbers.

Thanks,


------------------------------------------------------------------------------
