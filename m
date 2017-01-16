From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue discard commands
 asynchronously
Date: Mon, 16 Jan 2017 09:32:20 -0800
Message-ID: <20170116173220.GA2199@infradead.org>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
 <20170112224407.54026-5-jaegeuk@kernel.org>
 <20170113080159.GB31777@infradead.org>
 <20170113191211.GB1301@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170113191211.GB1301@jaegeuk.local>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, axboe@kernel.dk
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jan 13, 2017 at 11:12:11AM -0800, Jaegeuk Kim wrote:
> Previously, I've done to issue discard bios asynchronously. But the problem that
> I've got is that was not enough. When testing nvme SSD with noop IO scheduler,
> submit_bio() was blocked at every 8 async discard bios, resulting in very slow
> checkpoint process which blocks most of other FS operations.

Where does it block?  Are you running out of request?  What driver is
this on top of?
