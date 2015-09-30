From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH v2] f2fs: should get a victim from retrials
Date: Wed, 30 Sep 2015 17:00:57 +0800
Message-ID: <00f001d0fb5e$9ec48040$dc4d80c0$@samsung.com>
References: <1442862777-22537-1-git-send-email-jaegeuk@kernel.org>
	<20150928214335.GA19248@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZhDGn-0001FK-QN
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 09:01:49 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZhDGl-0004Fj-Nk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 09:01:49 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NVH029QQFQCFE40@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 18:01:40 +0900 (KST)
In-reply-to: <20150928214335.GA19248@jaegeuk-mac02.mot.com>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, September 29, 2015 5:44 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH v2] f2fs: should get a victim from retrials
> 
> Change log from v1:
>  o avoid __get_victim call twice, since each call registers the victim in bitmap
> 
> >From 45c3aaea805751e5c1899dd9c76d89e6f73a7a8f Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 18 Sep 2015 17:33:00 -0700
> Subject: [PATCH] f2fs: should get a victim from retrials
> 
> If we do not call get_victim first, we cannot get a new victim for retrial
> path.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
