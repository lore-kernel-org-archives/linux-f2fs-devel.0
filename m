From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: introduce f2fs_issue_discard() to clean up
Date: Wed, 27 Nov 2013 11:31:17 +0300
Message-ID: <20131127083117.GT5443@mwanda>
References: <20131126145315.GA27436@elgon.mountain>
	<1385520381.2417.17.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1VlaWx-0008Un-GQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 08:31:31 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VlaWw-0007JP-Nd
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Nov 2013 08:31:31 +0000
Content-Disposition: inline
In-Reply-To: <1385520381.2417.17.camel@kjgkr>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, Nov 27, 2013 at 11:46:21AM +0900, Jaegeuk Kim wrote:
> Hi Dan,
> 
> Thank you for the report.
> 
> How about this?
> Thanks,

You've just disguised the bug instead of fixing it.  Later versions of
this static checker will complain about the new code as well.  We're
unlikely to support 18TB with f2fs so let's just leave the code as is
with the original warning.

regards,
dan carpenter



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
