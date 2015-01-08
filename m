From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/6] f2fs: support goingdown for fs shutdown
Date: Fri, 9 Jan 2015 09:04:12 +1100
Message-ID: <20150108220412.GI25000@dastard>
References: <1420740661-72288-1-git-send-email-jaegeuk@kernel.org>
	<1420740661-72288-2-git-send-email-jaegeuk@kernel.org>
	<54AEE06C.90806@sandeen.net> <20150108201843.GA74570@jaegeuk-mac02>
	<54AEE98D.5010103@sandeen.net> <20150108205416.GE25000@dastard>
	<20150108211853.GB74570@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <david@fromorbit.com>) id 1Y9LBn-0003CH-2c
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 22:04:23 +0000
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9LBl-00080u-Gx for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 22:04:23 +0000
Content-Disposition: inline
In-Reply-To: <20150108211853.GB74570@jaegeuk-mac02>
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
Cc: linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Jan 08, 2015 at 01:21:29PM -0800, Jaegeuk Kim wrote:
> On Fri, Jan 09, 2015 at 07:54:16AM +1100, Dave Chinner wrote:
> > On Thu, Jan 08, 2015 at 02:33:17PM -0600, Eric Sandeen wrote:
> > > On 1/8/15 2:18 PM, Jaegeuk Kim wrote:
> > > > On Thu, Jan 08, 2015 at 01:54:20PM -0600, Eric Sandeen wrote:
> > > >> On 1/8/15 12:10 PM, Jaegeuk Kim wrote:
> > > >>> This patch add an ioctl to shutdown f2fs, which stops all the further block
> > > >>> writes after this point.
> > > >>
> > > >> would it make sense to just re-use the xfs ioctl nr, if the semantics are
> > > >> the same?
> > > > 
> > > > The semantics are not same for now.
> > > > In order to reuse xfs ioctl, it needs to support options for flushing logs.
> > > 
> > > the xfs iotl has 3 behaviors optional:
> > > 
> > > #define XFS_FSOP_GOING_FLAGS_DEFAULT            0x0     /* going down */
> > > #define XFS_FSOP_GOING_FLAGS_LOGFLUSH           0x1     /* flush log but not data */
> > > #define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH         0x2     /* don't flush log nor data */
> > > 
> > > if f2fs currently supports a subset, you could just -EOPNOTSUPP on the others.
> > 
> > No, just do a default shutdown operation if the semantics cannot be
> > supported.
> > 
> > 	- XFS_FSOP_GOING_FLAGS_DEFAULT ==
> > 		consistent on disk before shutdown
> > 			+ implemented by freeze/thaw/shutdown sequence
> > 	- XFS_FSOP_GOING_FLAGS_LOGFLUSH ==
> > 		consistent journal on disk before shutdown
> > 			+ implemented by journal flush/shutdown sequence

I should point out that this is really "consistent metadata on
disk before shutdown", so it really doesn't matter if your
filesystem has a journal or not, it can still be implemented.

Perhaps it woul dbe best to rename them for a generic ioctl
to FS_GOING_DOWN_SYNC, FS_GOING_DOWN_METADATA_METASYNC
and FS_GOING_DOWN_NOSYNC...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
