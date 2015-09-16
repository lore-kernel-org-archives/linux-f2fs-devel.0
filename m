From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 37/39] f2fs crypto: drop null test before
	destroy functions
Date: Wed, 16 Sep 2015 18:17:07 +0800
Message-ID: <000b01d0f068$f9695800$ec3c0800$@samsung.com>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
	<1442146532-9100-38-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Zc9nL-0005Tu-3j
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 10:18:31 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zc9nJ-0000Vv-6n
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 10:18:31 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUR00NBMLY0LIA0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 19:18:04 +0900 (KST)
In-reply-to: <1442146532-9100-38-git-send-email-Julia.Lawall@lip6.fr>
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
To: 'Julia Lawall' <Julia.Lawall@lip6.fr>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: sergey.senozhatsky@gmail.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Julia Lawall [mailto:Julia.Lawall@lip6.fr]
> Sent: Sunday, September 13, 2015 8:16 PM
> To: Jaegeuk Kim
> Cc: sergey.senozhatsky@gmail.com; kernel-janitors@vger.kernel.org; Changman Lee; Chao Yu;
> linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: [PATCH 37/39] f2fs crypto: drop null test before destroy functions
> 
> Remove unneeded NULL test.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@ expression x; @@
> -if (x != NULL)
>   \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
