From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/3] f2fs crypto: use bounce pages from
	mempool first
Date: Mon, 25 May 2015 15:55:51 -0400
Message-ID: <20150525195551.GB16402@thunk.org>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
	<1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1YwyTj-0004qb-1l
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 May 2015 19:56:03 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YwyTf-0006cC-8J
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 May 2015 19:56:03 +0000
Content-Disposition: inline
In-Reply-To: <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, May 21, 2015 at 05:40:24PM -0700, Jaegeuk Kim wrote:
> If a lot of write streams are triggered, alloc_page and __free_page are
> costly called, resulting in high memory pressure.
> 
> In order to avoid that, let's reuse mempool pages for writeback pages.

The reason why the mempool pages was used as a fallback was because
once we are deep in the writeback code, handling memory allocation
failures is close to impossible, since we've already made enough
changes that unwinding them would be extremely difficult.  So the
basic idea was to use the mempool as an emergency reserve, since
Failure Is Not An Option, and the alternative, which is to simply loop
until the mm subsystem sees fit to give us a page, has sometimes led
to deadlock.

The primary source of write streams should be either (a) fsync
operations, or (b) calls from the writeback thread.  Are there any
additional sources for f2fs?  If they are calls from fsync operations,
and we have more than a threshold number of write operations in play,
we might want to think about blocking the fsync/fdatasync writeback,
**before** the operation starts taking locks, so other write
operations can proceed.  And the writeback thread should keep the
number of write operations to a reasonable number, especially given
that we are treating page encryption as a blocking operation.  Or is
there something else going on which is making this to be more of a
problem for f2fs?

Regards,

						- Ted

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
