From: Tom Marshall <tom@cyngn.com>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions for f2fs
 encryption feature
Date: Fri, 15 May 2015 21:47:05 -0700
Message-ID: <20150516044704.GA27800@eden.sea.cyngn.com>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
 <20150513020208.GK15721@dastard>
 <20150513064802.GA48682@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150514003721.GN15721@dastard>
 <20150514015643.GA70216@jaegeuk-mac02>
 <5554D264.7070105@cyngn.com>
 <20150516011424.GB10530@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150516011424.GB10530@jaegeuk-mac02.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, May 15, 2015 at 06:14:24PM -0700, Jaegeuk Kim wrote:
> On Thu, May 14, 2015 at 09:50:44AM -0700, Tom Marshall wrote:
> > Please keep in mind that I'm also working on transparent
> > compression.  I'm watching this thread closely so that I can
> > implement a compression library alongside the crypto library.  If
> > there is any interest or benefit, I would be glad to work together
> > so that the two can be done cooperatively at the same time.
> 
> I can't imagine quickly how compression code can be shared with crypto.
> The basic approach for compression would be that X pages can be compressed into
> small number of pages, Y, which can be a X to Y mapping.
> But, this per-file encryption supports only 1 to 1 4KB mapping, so that it could
> be quite a simple implementation.

No, I don't intend to share actual code with crypto -- at least not much. 
I'm more interested in looking at how the crypto layer is implemented to
give me clues about how to implement a compression layer.

> Could you elaborate on your approach or design? Or, codes?
> Whatever, IMO, it needs to implement it by any filesystem first.

I don't really have any working code yet.  I will probably get to that in
the coming few weeks.  Right now I'm still working with the ugly VFS
stacking implementation that I posted initially.

The thing that I have done is dismissed the standard compression framing
formats.

zlib (and gzip) are designed for streaming and it is quite difficult to
implement random access on it.  See the example code in the zlib source,
zran.c.  It's not really tenable because 32kb of prior data is required to
be kept as priming information.  Even doing fully encapsulated blocks with
Z_FINISH, there is still no way to skip over data without decompressing it
first to build an index.

lz4 is somewhat better in that blocks are self contained.  But block lengths
must be read sequentially.  This means that reading an arbitrary position in
a file requires a proportional number of reads to find the desired block.

So, I am working with a simple framing format that I threw together.  The
header has a compression method (zlib or lz4), block size, original input
size, and a block map.
