From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Patch "Revert "f2fs: fix to clear PG_checked flag in
 set_page_dirty()"" has been added to the 4.18-stable tree
Date: Sun, 11 Nov 2018 06:35:21 -0800
Message-ID: <20181111143521.GA21748@kroah.com>
References: <154190097675163@kroah.com>
 <CAD14+f1scE6Xuurjx+UrBwyrR7x6PG6w6kzoxWoVVUJ5QBJ8Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <SRS0=XqPF=NW=linuxfoundation.org=gregkh@kernel.org>)
 id 1gLqpp-0006Wa-4e
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Nov 2018 14:35:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gLqpk-00E4gD-22
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Nov 2018 14:35:33 +0000
Content-Disposition: inline
In-Reply-To: <CAD14+f1scE6Xuurjx+UrBwyrR7x6PG6w6kzoxWoVVUJ5QBJ8Ow@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable-commits@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sun, Nov 11, 2018 at 06:13:14PM +0900, Ju Hyung Park wrote:
> Hi,
> 
> This bug was present only in 4.19.
> Is it still applicable to older branches?
> 
> Thanks.
> 
> On Sun, Nov 11, 2018, 12:26 PM <gregkh@linuxfoundation.org wrote:
> 
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     Revert "f2fs: fix to clear PG_checked flag in set_page_dirty()"
> >
> > to the 4.18-stable tree which can be found at:
> >
> > http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      revert-f2fs-fix-to-clear-pg_checked-flag-in-set_page_dirty.patch
> > and it can be found in the queue-4.18 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> >
> > From 164a63fa6b384e30ceb96ed80bc7dc3379bc0960 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Tue, 16 Oct 2018 19:30:13 -0700
> > Subject: Revert "f2fs: fix to clear PG_checked flag in set_page_dirty()"
> >
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> >
> > commit 164a63fa6b384e30ceb96ed80bc7dc3379bc0960 upstream.
> >
> > This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.

This commit was backported to 4.14.70 and 4.18.8 so it should also be
reverted there, right?  That is why I added it to those queues.

If this is incorrect, please let me know.

thanks,

greg k-h
