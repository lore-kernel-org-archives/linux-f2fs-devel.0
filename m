From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions
 for f2fs encryption feature
Date: Sat, 16 May 2015 09:24:03 -0400
Message-ID: <20150516132403.GA2998@thunk.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
	<1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
	<20150513020208.GK15721@dastard>
	<20150513064802.GA48682@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150514003721.GN15721@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1Ytc4e-0000y8-DG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 May 2015 13:24:16 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Ytc4a-000301-MK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 16 May 2015 13:24:16 +0000
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
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, May 14, 2015 at 10:37:21AM +1000, Dave Chinner wrote:
> > 
> > AFAIK, Ted wants to push the codes as a crypto library into fs/ finally, so
> > I believe most part of crypto codes are common.
> 
> Can I suggest fs/crypto/ if there are going to be multiple files?

Yes, I think we definitely want to do this as fs/crypto; it makes
things a bit more straightforward on a number of fronts; not just from
a Makefile point of view, but also in setting up a separate tree to
push into linux-next.

> > But, in order to realize that quickly, Ted implemented the feature to finalize
> > on-disk and in-memory design in EXT4 as a first step.
> > Then, I've been catching up and validating its design by implementing it in
> > F2FS, which also intends to figure out what crypto codes can be exactly common.
> 
> Excellent. That will make it easier and less error prone for other
> filesystems to implement it, too!

Yeah, that's why I figured it would be easier to get it into ext4 and
f2fs first.  We can keep the functions in sync for a release or so,
and then we can start creating patches that gradually move each of
fs/{ext4,f2fs}/{crypto,crypo_fname,crypto_policy}.c, etc. into a
common fs/crypto directory.  I'm sure there will be a bit of
refactoring that will be necessary as we go along, but it will be a
lot easier to validate that we've gotten things once we have to file
systems both depending on the common code.

If Michael and I had tried to create fs/cryto up-front, I'm *sure* we
would have gotten a number of things wrong.  :-)

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

Yes, absolutely.  What's going to be more difficult in the long run is
when we want to support per-block data integrity, using (for example)
AES/GCM, which will require 32 bytes of per-block "authentication tag"
(think Message Authentication Code) that have to be committed
atomically with the data block write.

Quite frankly, this is going to be much easier for COW file systems
like f2fs and btrfs.  I have some ideas about how to do this for
update-in-place file systems (using either a compression hack and/or
storing two generations worth of authentication tag per block), but
it's not pretty.  (Or in the case of ext4 we could use
data=journalling mode, but that's even less pretty from a performance
standpoint.)

Cheers,

					- Ted

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
