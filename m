From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: use meta_inode cache to improve roll-forward
	speed
Date: Mon, 15 Sep 2014 22:37:58 +0300
Message-ID: <20140915193758.GA19290@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1XTc6N-0007Wy-26
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 19:38:19 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XTc6M-00028T-98
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Sep 2014 19:38:18 +0000
Content-Disposition: inline
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

Hello Jaegeuk Kim,

The patch 17ef549eef6e: "f2fs: use meta_inode cache to improve
roll-forward speed" from Sep 11, 2014, leads to the following static
checker warning:

	fs/f2fs/recovery.c:180 find_fsync_dnodes()
	warn: 'page' isn't an ERR_PTR

fs/f2fs/recovery.c
   178  
   179                  page = get_meta_page(sbi, blkaddr);
   180                  if (IS_ERR(page))
                            ^^^^^^^^^^^
Is get_meta_page() supposed to return an ERR_PTR()?  The comment says
"We guarantee no failure on the returned page."

   181                          return PTR_ERR(page);
   182  

Also:
fs/f2fs/recovery.c:446 recover_data() warn: 'page' isn't an ERR_PTR

regards,
dan carpenter

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
