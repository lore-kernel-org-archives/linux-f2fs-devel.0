From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/6] f2fs: add a kernel thread to issue discard commands
 asynchronously
Date: Fri, 13 Jan 2017 00:01:59 -0800
Message-ID: <20170113080159.GB31777@infradead.org>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
 <20170112224407.54026-5-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112224407.54026-5-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jan 12, 2017 at 02:44:06PM -0800, Jaegeuk Kim wrote:
> This patch adds a kernel thread to issue discard commands.
> It proposes three states, D_PREP, D_SUBMIT, and D_DONE to identify current
> bio status.

Why?  Instead of creating the complexity of a thread you should look
into issuing the discard bios asynchronously, which should help to
simplify a lot of the discard logic in f2fs.
