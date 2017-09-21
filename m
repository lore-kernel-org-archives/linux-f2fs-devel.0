From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Thu, 21 Sep 2017 10:48:09 -0400
Message-ID: <20170921144809.wv6546fqtentm7vv@thunk.org>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170920173831.GA7151@jaegeuk-macbookpro.roam.corp.google.com>
 <20170920183825.GD32076@ZenIV.linux.org.uk>
 <20170921003409.GA11365@jaegeuk-macbookpro.roam.corp.google.com>
 <20170921024251.GE32076@ZenIV.linux.org.uk>
 <20170921050237.GA28821@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921050237.GA28821@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Sep 20, 2017 at 10:02:37PM -0700, Jaegeuk Kim wrote:
> 
> Yes, and actually, android retries umount(2) for several seconds, if it gets
> failure. So, first I thought it'd be better to make umount() more deterministic.
> 
> I'm not sure how many times we can retry and wait for this. IMHO, it'd be better
> to use this together with the new flag, since this can detect unclosed namespace
> given successful umount(2).

Even if you could make umount wait for the binder deferred workqueue
to exit, if it takes time, it takes time.  And that's not the core
VFS's fault.  It's binder's.

So... why not fix this by adding a binder ioctl which forces its
workqueue to be flushed, and use that *before* you try calling mount?

If that binder ioctl takes minutes or hours to complete, then that's a
binder bug, and needs to be fixed in binder.

       	    	      	    	  - Ted
