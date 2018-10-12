From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] f2fs: use rb_*_cached friends
Date: Fri, 12 Oct 2018 17:18:18 +0300
Message-ID: <20181012141818.c2y7moxclp5xhv54@mwanda>
References: <20181011122342.GA23299@mwanda>
 <de7d9aa6-b828-f2d9-4568-bfc758fad9d0@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan.carpenter@oracle.com>) id 1gAyH3-0004Vb-Ic
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Oct 2018 14:18:41 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gAyH0-001Eqk-72
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Oct 2018 14:18:41 +0000
Content-Disposition: inline
In-Reply-To: <de7d9aa6-b828-f2d9-4568-bfc758fad9d0@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Fri, Oct 12, 2018 at 10:00:20PM +0800, Chao Yu wrote:
> 
> So finally, we will initialize leftmost's value here, anyway, I think there is
> such place we use an uninitialized variable.
> 
> BTW, do we have any chance to detect such case in smatch?
> 

Thanks for taking a look at this!  I think that's probably a bit
complicated for Smatch...

regards,
dan carpenter
