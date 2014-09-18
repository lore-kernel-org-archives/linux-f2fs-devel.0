From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs: use meta_inode cache to improve roll-forward
	speed
Date: Wed, 17 Sep 2014 22:48:58 -0700
Message-ID: <20140918054858.GC1982@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <20140915193758.GA19290@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XUUaa-0007A6-HJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 05:49:08 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUUaZ-0004I2-JK for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 05:49:08 +0000
Content-Disposition: inline
In-Reply-To: <20140915193758.GA19290@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

I fixed this.

Thank you very much.

On Mon, Sep 15, 2014 at 10:37:58PM +0300, Dan Carpenter wrote:
> Hello Jaegeuk Kim,
> 
> The patch 17ef549eef6e: "f2fs: use meta_inode cache to improve
> roll-forward speed" from Sep 11, 2014, leads to the following static
> checker warning:
> 
> 	fs/f2fs/recovery.c:180 find_fsync_dnodes()
> 	warn: 'page' isn't an ERR_PTR
> 
> fs/f2fs/recovery.c
>    178  
>    179                  page = get_meta_page(sbi, blkaddr);
>    180                  if (IS_ERR(page))
>                             ^^^^^^^^^^^
> Is get_meta_page() supposed to return an ERR_PTR()?  The comment says
> "We guarantee no failure on the returned page."
> 
>    181                          return PTR_ERR(page);
>    182  
> 
> Also:
> fs/f2fs/recovery.c:446 recover_data() warn: 'page' isn't an ERR_PTR
> 
> regards,
> dan carpenter

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
