From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [GIT PULL] f2fs updates for v4.2
Date: Thu, 25 Jun 2015 07:29:46 +0100
Message-ID: <20150625062946.GU17109@ZenIV.linux.org.uk>
References: <20150624202401.GA40031@jaegeuk-mac02.mot.com>
 <CA+55aFycRo0ttWw5kAgf=tDrfz-hvhSsjveu9LqdXH-RNbXE3A@mail.gmail.com>
 <20150625043334.GT17109@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150625043334.GT17109@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jun 25, 2015 at 05:33:34AM +0100, Al Viro wrote:

> Said that, f2fs_symlink() looks odd - we create a directory entry *before*
> doing page_symlink().  And if it (or encryption) fails, I don't see anything
> that would remove that new directory entry.  What are we ending up with
> in such case?

PS: other page_symlink() users tend to do it first and if it fails we just
decrement link count and iput() the sucker.

	BTW, while grepping for that stuff...  Why do we have
->delete_inode() set to generic_delete_inode() on ramfs?  After all,
we never hash the inodes in there, so default will do nicely, and
it's kinder of branch prediction - we have
        if (op->drop_inode)
                drop = op->drop_inode(inode);
        else
                drop = generic_drop_inode(inode);
and generic_drop_inode() is inlined there...
