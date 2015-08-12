From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: callers take care of the page from bio error
Date: Wed, 12 Aug 2015 21:23:40 +0300
Message-ID: <20150812182340.GI32040@mwanda>
References: <20150812104009.GB22571@mwanda>
	<20150812171837.GB27478@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1ZPagt-0000LY-Uk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Aug 2015 18:23:55 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPagr-0002s9-VG
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Aug 2015 18:23:55 +0000
Content-Disposition: inline
In-Reply-To: <20150812171837.GB27478@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, Aug 12, 2015 at 10:18:37AM -0700, Jaegeuk Kim wrote:
> >   1041          err = read_node_page(apage, READA);
> >   1042          f2fs_put_page(apage, err ? 1 : 0);
> > 
> > In the old code we took errors into consideration but now we treat them
> > as LOCKED_PAGE.  Is that intentional?  A lot of the other callers in
> > that patch still check for errors...
> 
> This is just for read-ahead node page function.
> So, yes, if it returns LOCKED_PAGE or any error, the page must be unlocked
> via f2fs_put_page(1).
> Otherwise, end_io will unlock the page.
> 
> Hmm, any workaround to avoid that warning?
> 

No, it's fine.  Just ignore it.

regards,
dan carpenter


------------------------------------------------------------------------------
