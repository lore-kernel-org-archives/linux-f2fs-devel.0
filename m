From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [f2fs-dev] [patch] f2fs: dereferencing an ERR_PTR
Date: Fri, 24 May 2013 14:23:41 +0300
Message-ID: <20130524112340.GA23932@mwanda>
References: <20130523100213.GA19107@elgon.mountain>
	<20130523101240.GG30128@mwanda> <1369367168.10521.13.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Ufq6P-0005f6-2G
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 11:24:05 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ufq6M-0000sj-FD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 11:24:05 +0000
Content-Disposition: inline
In-Reply-To: <1369367168.10521.13.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, May 24, 2013 at 12:46:08PM +0900, Jaegeuk Kim wrote:
> From ded3c78fcb6dd8c39a8664471544942e51ff9faf Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Date: Fri, 24 May 2013 12:41:04 +0900
> Subject: [PATCH] f2fs: align data types between on-disk and in-memory
> block
>  addresses
> Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
> linux-f2fs-devel@lists.sourceforge.net
> 
> The on-disk block address is defined as __le32, but in-memory block
> address,
> block_t, does as u64.
> 
> Let's synchronize them to 32 bits.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>

What you say sounds good to me.  Could you give me the reported-by
tag instead of the Signed-off-by?  The Signed-off-by means it went
through my hands and it's intended as sort of a legal thing like
signing a document.

regards,
dan carpenter

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
