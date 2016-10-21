From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] f2fs: add fast path for find_next_{zero}bit
Date: Fri, 21 Oct 2016 03:35:37 -0700
Message-ID: <20161021103537.GA14327@infradead.org>
References: <20161021022847.55629-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161021022847.55629-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Oct 20, 2016 at 07:28:45PM -0700, Jaegeuk Kim wrote:
> This patch adds checking the first two bits when searching zero or one bits to
> avoid costly find_next_{zero}bit operations.

Please fix this in the generic iplementations instead of adding your
local workarounds.
