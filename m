From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/5] f2fs: use blk_plug in all the possible paths
Date: Mon, 18 Jul 2016 20:59:52 -0700
Message-ID: <20160719035952.GB24437@infradead.org>
References: <20160715004629.43143-1-jaegeuk@kernel.org>
 <20160715004629.43143-5-jaegeuk@kernel.org>
 <20160715022132.GA1513@infradead.org>
 <20160715030502.GB44979@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160715030502.GB44979@jaegeuk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jul 14, 2016 at 08:05:02PM -0700, Jaegeuk Kim wrote:
> >From kernel guys working on android.

Well, until it's mainline it simply doesn't matter, so NAK to this
patch.  Tying power behavior to plugs also sounds pretty broken, so we'd
probably come up with something better if they bothered to actually
submit their patches upsteam or at least explaining what they want
to archive.
