From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/6] f2fs: support goingdown for fs shutdown
Date: Thu, 8 Jan 2015 13:21:29 -0800
Message-ID: <20150108211853.GB74570@jaegeuk-mac02>
References: <1420740661-72288-1-git-send-email-jaegeuk@kernel.org>
 <1420740661-72288-2-git-send-email-jaegeuk@kernel.org>
 <54AEE06C.90806@sandeen.net>
 <20150108201843.GA74570@jaegeuk-mac02>
 <54AEE98D.5010103@sandeen.net>
 <20150108205416.GE25000@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150108205416.GE25000@dastard>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jan 09, 2015 at 07:54:16AM +1100, Dave Chinner wrote:
> On Thu, Jan 08, 2015 at 02:33:17PM -0600, Eric Sandeen wrote:
> > On 1/8/15 2:18 PM, Jaegeuk Kim wrote:
> > > On Thu, Jan 08, 2015 at 01:54:20PM -0600, Eric Sandeen wrote:
> > >> On 1/8/15 12:10 PM, Jaegeuk Kim wrote:
> > >>> This patch add an ioctl to shutdown f2fs, which stops all the further block
> > >>> writes after this point.
> > >>
> > >> would it make sense to just re-use the xfs ioctl nr, if the semantics are
> > >> the same?
> > > 
> > > The semantics are not same for now.
> > > In order to reuse xfs ioctl, it needs to support options for flushing logs.
> > 
> > the xfs iotl has 3 behaviors optional:
> > 
> > #define XFS_FSOP_GOING_FLAGS_DEFAULT            0x0     /* going down */
> > #define XFS_FSOP_GOING_FLAGS_LOGFLUSH           0x1     /* flush log but not data */
> > #define XFS_FSOP_GOING_FLAGS_NOLOGFLUSH         0x2     /* don't flush log nor data */
> > 
> > if f2fs currently supports a subset, you could just -EOPNOTSUPP on the others.
> 
> No, just do a default shutdown operation if the semantics cannot be
> supported.
> 
> 	- XFS_FSOP_GOING_FLAGS_DEFAULT ==
> 		consistent on disk before shutdown
> 			+ implemented by freeze/thaw/shutdown sequence
> 	- XFS_FSOP_GOING_FLAGS_LOGFLUSH ==
> 		consistent journal on disk before shutdown
> 			+ implemented by journal flush/shutdown sequence
> 	- XFS_FSOP_GOING_FLAGS_NOLOGFLUSH ==
> 		nothing consistent on disk before shutdown
> 			+ just a shutdown call.
> 
> f2fs can at least support XFS_FSOP_GOING_FLAGS_DEFAULT and
> XFS_FSOP_GOING_FLAGS_NOLOGFLUSH....
> 
> > If the semantics are completely different, maybe it shouldn't share the
> > name at all.  ;)
> 
> The semantics are quite clear and generic - when you look at what
> they actually mean rather than looking at the implementation.
> There's no need for new ioctls here.

I'll check it out.
Thank you, Dave and Eric. :)

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
