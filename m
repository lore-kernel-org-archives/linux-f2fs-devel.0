From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions
 for f2fs encryption feature
Date: Wed, 13 May 2015 18:56:43 -0700
Message-ID: <20150514015643.GA70216@jaegeuk-mac02>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
	<1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
	<20150513020208.GK15721@dastard>
	<20150513064802.GA48682@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150514003721.GN15721@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YsiOQ-0007VV-M9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 01:56:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsiOO-0005Fz-9n for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 01:56:58 +0000
Content-Disposition: inline
In-Reply-To: <20150514003721.GN15721@dastard>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, May 14, 2015 at 10:37:21AM +1000, Dave Chinner wrote:
> On Tue, May 12, 2015 at 11:48:02PM -0700, Jaegeuk Kim wrote:
> > On Wed, May 13, 2015 at 12:02:08PM +1000, Dave Chinner wrote:
> > > On Fri, May 08, 2015 at 09:20:38PM -0700, Jaegeuk Kim wrote:
> > > > This definitions will be used by inode and superblock for encyption.
> > > 
> > > How much of this crypto stuff is common with or only slightly
> > > modified from the ext4 code?  Is the behaviour and features the
> > > same? Is the user API and management tools the same?
> > > 
> > > IMO, if there is any amount of overlap, then we should be
> > > implementing this stuff as generic code, not propagating the same
> > > code through multiple filesystems via copy-n-paste-n-modify. This
> > > will simply end up with diverging code, different bugs and feature
> > > sets, and none of the implementations will get the review and
> > > maintenance they really require...
> > > 
> > > And, FWIW, this is the reason why I originally asked for the ext4
> > > encryption code to be pulled up to the VFS: precisely so we didn't
> > > end up with a rapid proliferation of individual in-filesystem
> > > encryption implementations that are all slightly different...
> > 
> > Totally agreed!
> > 
> > AFAIK, Ted wants to push the codes as a crypto library into fs/ finally, so
> > I believe most part of crypto codes are common.
> 
> Can I suggest fs/crypto/ if there are going to be multiple files?

No problem at all. I'll do.

> 
> > But, in order to realize that quickly, Ted implemented the feature to finalize
> > on-disk and in-memory design in EXT4 as a first step.
> > Then, I've been catching up and validating its design by implementing it in
> > F2FS, which also intends to figure out what crypto codes can be exactly common.
> 
> Excellent. That will make it easier and less error prone for other
> filesystems to implement it, too!
> 
> > As Ted mentioned before, since next android version tries to use per-file
> > encryption, F2FS also needs to support it as quick as possible likewise EXT4.
> 
> Fair enough.
> 
> > Meanwhile, surely I've been working on writing patches to push them into fs/;
> > currenlty, I did for cryto.c and will do for crypto_key.c and crypto_fname.c.
> > But, it needs to think about crypto_policy.c differently, since it may depend
> > on how each filesystem stores the policy information respectively; we cannot
> > push all the filesystems should use xattrs, right?
> 
> All filesystems likely to implement per-file crypto support xattrs,
> and this is exactly what xattrs are designed for. e.g. we already
> require xattrs for generic security labels, ACLs, etc. Hence
> per-file crypto information should also use a common, shared xattr
> format. That way it only needs to be implemented once in the generic
> code and there's very little (hopefully nothing!) each filesystem
> has to customise to store the crypto information for each file.

Ok, I see. Let me take a look at that too.
Thank you for sharing your thoughts. :)

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
