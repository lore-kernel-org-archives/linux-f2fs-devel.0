From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs crypto: filename encryption facilities
Date: Tue, 12 May 2015 14:38:57 +0300
Message-ID: <20150512113856.GA12780@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Ys8Wm-00063n-4d
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 11:39:12 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ys8Wl-0001Ym-7f
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 11:39:12 +0000
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

The patch c54316510133: "f2fs crypto: filename encryption facilities"
from Apr 26, 2015, leads to the following static checker warning:

	fs/f2fs/crypto_fname.c:189 f2fs_fname_decrypt()
	warn: passing __func__ while the format string already contains the name of the function 'f2fs_fname_decrypt'

fs/f2fs/crypto_fname.c
   187          ablkcipher_request_free(req);
   188          if (res < 0) {
   189                  printk_ratelimited(KERN_ERR
   190                          "%s: Error in f2fs_fname_decrypt (error code %d)\n",
                                              ^^^^^^^^^^^^^^^^^^
   191                          __func__, res);
                                ^^^^^^^^

   192                  return res;
   193          }

regards,
dan carpenter

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
