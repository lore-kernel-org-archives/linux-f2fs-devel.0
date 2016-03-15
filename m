From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: support access control via key
	management
Date: Tue, 15 Mar 2016 09:37:25 -0700
Message-ID: <20160315163725.GA78436@jaegeuk.gateway>
References: <1457571168-56724-1-git-send-email-jaegeuk@kernel.org>
	<20160315072422.GB11669@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1afryQ-0005YM-UZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Mar 2016 16:37:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1afryO-000646-Q4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Mar 2016 16:37:34 +0000
Content-Disposition: inline
In-Reply-To: <20160315072422.GB11669@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello,

On Tue, Mar 15, 2016 at 12:24:22AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 09, 2016 at 04:52:48PM -0800, Jaegeuk Kim wrote:
> > Through this patch, user can assign its key into a specific normal files.
> > Then, other users who do not have that key cannot open the files.
> > Later, owner can drop its key from the files for other users to access
> > the files again.
> 
> No magic file system specific access control, please:

I agree that I must follow FS convention here.
But, in order to make this clear out, could you please elaborate why this is not
allowed?

I wrote this patch totally based on per-file encryption in which users cannot
access their files if they have no right key.
The only difference is that this controls user access with a key only, neither
encrypting file data nor dentries.

This was initiated by UX in android letting nobody be able to access the files
that owner wants to protect by passcode or fingerprint.

Does it make no sense to support this by filesystems?

Thanks,

> 
> Nacked-by: Christoph Hellwig <hch@lst.de>

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
