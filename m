From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: make discard command directly
Date: Thu, 12 Jan 2017 06:10:10 -0800
Message-ID: <20170112141010.GA25952@infradead.org>
References: <20170112004848.37202-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112004848.37202-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Jan 11, 2017 at 04:48:48PM -0800, Jaegeuk Kim wrote:
> This can reduce the backporting efforts.

NAK.  For one that is not a valid excuse for anything, and second
your remove respecting the granularity.
