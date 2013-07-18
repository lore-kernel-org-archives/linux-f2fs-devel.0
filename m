From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] f2fs: update file name in the inode block during
 f2fs_rename
Date: Thu, 18 Jul 2013 10:22:12 +0100
Message-ID: <20130718092211.GA4165@ZenIV.linux.org.uk>
References: <1374138684-28520-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374138684-28520-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jul 18, 2013 at 06:11:23PM +0900, Jaegeuk Kim wrote:
> The error is reproducible by:
> 
> After this, when we retrieve the inode->i_name of test2 by dump.f2fs, we get
> test1 instead of test2.
> This is because f2fs didn't update the file name during the f2fs_rename.

Er...  Correct me if I'm wrong, but f2fs appears to support link(2) and
if rename(2) creates some problem for dump.f2fs, I would expect an
equivalent link()+unlink() combination to do the same...
