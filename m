From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] f2fs: use rb_*_cached friends
Date: Fri, 11 Jan 2019 09:55:00 +0300
Message-ID: <20190111065500.GK1718@kadam>
References: <20181011122342.GA23299@mwanda>
 <de7d9aa6-b828-f2d9-4568-bfc758fad9d0@kernel.org>
 <20190110225119.GE149637@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan.carpenter@oracle.com>) id 1ghqiw-00008N-RH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Jan 2019 06:55:22 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ghqiu-00AxYr-Mh
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Jan 2019 06:55:22 +0000
Content-Disposition: inline
In-Reply-To: <20190110225119.GE149637@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

There have been a couple of these where we pass uninitialized memory to
another function which doesn't use it.  It's kind of obvious in
retrospect, but it hadn't occured to me that UBSAN would generate the
warning at the call site.  This will make us more inclined to silence
those warnings.

Thanks!

regards,
dan carpenter
