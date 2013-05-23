From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [f2fs-dev] [patch] f2fs: dereferencing an ERR_PTR
Date: Thu, 23 May 2013 13:12:40 +0300
Message-ID: <20130523101240.GG30128@mwanda>
References: <20130523100213.GA19107@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1UfSW0-0000hM-TQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 May 2013 10:12:56 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UfSW0-0004Zg-6C
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 May 2013 10:12:56 +0000
Content-Disposition: inline
In-Reply-To: <20130523100213.GA19107@elgon.mountain>
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

Btw, Linus's new Sparse changes don't like the f2fs's NEW_ADDR
macro.

#define NEW_ADDR                -1U

We use it like this:

	block_t src, dest;

	if (src != dest && dest != NEW_ADDR && dest != NULL_ADDR) {

block_t is 64 bits so probably the macro should probably be:

#define NEW_ADDR               ((block_t)-1)

I'm not able to test this so there may be some reason why changing
this breaks something.  In that case we could do:

#define NEW_ADDR               ((u32)(block_t)-1) /* explanation */

regards,
dan carpenter


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
