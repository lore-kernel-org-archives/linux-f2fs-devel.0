From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/3] f2fs: enhance the bit operation for SSR
Date: Wed, 09 Dec 2015 14:06:36 +0800
Message-ID: <014f01d13247$dd727e30$98577a90$@samsung.com>
References: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a6XuU-0001eB-Ke
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 06:07:30 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a6XuS-00066s-PG
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 06:07:30 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZ2009ZAUC5BX50@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 15:07:21 +0900 (KST)
In-reply-to: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 08, 2015 6:53 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/3] f2fs: enhance the bit operation for SSR
> 
> This patch enhances the existing bit operation when f2fs allocates SSR
> blocks.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
