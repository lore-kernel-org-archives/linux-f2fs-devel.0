From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: limit # of inmemory pages
Date: Thu, 19 Oct 2017 00:28:04 -0700
Message-ID: <20171019072804.GA16321@infradead.org>
References: <20171019021516.65627-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171019021516.65627-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Oct 18, 2017 at 07:15:16PM -0700, Jaegeuk Kim wrote:
> If some abnormal users try lots of atomic write operations, f2fs is able to
> produce pinned pages in the main memory which affects system performance.
> This patch limits that as 20% over total memory size, and if f2fs reaches
> to the limit, it will drop all the inmemory pages.

Can you please document your "atomic" writes and how they pin memory
in a mail to linux-abi?  And how they compare to my O_ATOMIC implement
as well as the papers it is based on?

I tried to take a quick look at the code and it looks very bogus to me
in addition to being sneaked in through fs-specific ioctls without any
review whatsoever.
