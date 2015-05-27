From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs crypto: use bounce pages from mempool first
Date: Wed, 27 May 2015 14:18:54 -0700
Message-ID: <20150527211641.GA1397@jaegeuk-mac02.mot.com>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
 <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
 <20150525195551.GB16402@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150525195551.GB16402@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, May 25, 2015 at 03:55:51PM -0400, Theodore Ts'o wrote:
> On Thu, May 21, 2015 at 05:40:24PM -0700, Jaegeuk Kim wrote:
> > If a lot of write streams are triggered, alloc_page and __free_page are
> > costly called, resulting in high memory pressure.
> > 
> > In order to avoid that, let's reuse mempool pages for writeback pages.
> 
> The reason why the mempool pages was used as a fallback was because
> once we are deep in the writeback code, handling memory allocation
> failures is close to impossible, since we've already made enough
> changes that unwinding them would be extremely difficult.  So the
> basic idea was to use the mempool as an emergency reserve, since
> Failure Is Not An Option, and the alternative, which is to simply loop
> until the mm subsystem sees fit to give us a page, has sometimes led
> to deadlock.

So, in the current flow,

  ciphertext_page = mempool_alloc(f2fs_bounce_page_pool, GFP_NOFS);

  if (WARN_ON_ONCE(!ciphertext_page))
    ciphertext_page = mempool_alloc(f2fs_bounce_page_pool,
                                            GFP_NOFS | __GFP_WAIT);
                                                      ^^^^^^^^^^^^
Was it intended                                       __GFP_NOFAIL?

Anyway, f2fs handles ENOMEM in ->writepage by:

...
redirty_out:
  redirty_page_for_writepage();
  return AOP_WRITEPAGE_ACTIVATE;
}

> 
> The primary source of write streams should be either (a) fsync
> operations, or (b) calls from the writeback thread.  Are there any
> additional sources for f2fs?  If they are calls from fsync operations,
> and we have more than a threshold number of write operations in play,
> we might want to think about blocking the fsync/fdatasync writeback,
> **before** the operation starts taking locks, so other write
> operations can proceed.  And the writeback thread should keep the
> number of write operations to a reasonable number, especially given
> that we are treating page encryption as a blocking operation.  Or is
> there something else going on which is making this to be more of a
> problem for f2fs?

The problem that I'd like to address here is to reduce the call counts of
allocating and freeing a number of pages in pairs.

When I conduct xfstests/224 under 1GB DRAM, I've seen triggering several oom
killers, and in that moment, a huge number of inactive anonymous pages are
registered in the page cache. Not sure why those pages are not reclaimed
seamlessly though.

Neverthelss, once I changed the flow to reuse the pages in the mempool for
encryption/decryption, I could have resolved that issue.
And, I thought that there is no reason to allocate new pages for every requests.

For general purpose, it may need an additional mempool too.

Thanks,
