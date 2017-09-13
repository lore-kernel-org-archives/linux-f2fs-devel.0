From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Thu, 14 Sep 2017 00:04:26 +0100
Message-ID: <20170913230426.GN5426@ZenIV.linux.org.uk>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170913200941.39420-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Sep 13, 2017 at 01:09:41PM -0700, Jaegeuk Kim wrote:
> +	if (!retval && (flags & UMOUNT_WAIT)) {
> +		if (likely(!(current->flags & PF_KTHREAD)))
> +			task_work_run();

This is complete crap.  The same damn thing will be done by
caller of sys_umount() pretty much immediately afterwards.
I'm not sure what it is that you are trying to paper over,
but this is just plain wrong.

What _is_ the semantics of UMOUNT_WAIT?  What does it guarantee,
and what would be supplying it to umount(2)?
