From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs updates for v4.2
Date: Wed, 24 Jun 2015 22:50:10 -0700
Message-ID: <20150625054917.GA43469@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <20150624202401.GA40031@jaegeuk-mac02.mot.com>
 <CA+55aFycRo0ttWw5kAgf=tDrfz-hvhSsjveu9LqdXH-RNbXE3A@mail.gmail.com>
 <20150625043334.GT17109@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150625043334.GT17109@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jun 25, 2015 at 05:33:34AM +0100, Al Viro wrote:
> On Wed, Jun 24, 2015 at 08:42:02PM -0700, Linus Torvalds wrote:
> > On Wed, Jun 24, 2015 at 1:25 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > >
> > > New features are:
> > >  o per-file encryption (e.g., ext4)
> > 
> > The new encrypted symlinks needed fixups for the changes that happened
> > meanwhile to the symlink handling. I did all that in my merge, and I
> > *think* I got it all right, but I would like you to check. In
> > particular, I hope you have a test-case and can actually give it a
> > whirl on that.
> > 
> > Al added to cc, just in case he could also check my merge resolution
> > of fs/f2fs/namei.c (the merge is commit cfcc0ad47f4c, I'll push it out
> > after I've finished the filesystem pulls)
> 
> FWIW, linux-next contains fixups for a bunch of such stuff,
> including f2fs one.  The only difference between your resolution and
> Stephen's fixup is
> static const char *f2fs_encrypted_follow_link(struct dentry *dentry,
> 					      void **cookie)
> vs.
> static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cookie)
> 
> Said that, f2fs_symlink() looks odd - we create a directory entry *before*
> doing page_symlink().  And if it (or encryption) fails, I don't see anything
> that would remove that new directory entry.  What are we ending up with
> in such case?

Thanks Al,

Right, I missed merging the fix-up patch in linux-next into my pull-request.
At a glance, I think there is no problem; except 80 column width, though.

Also, agreed that I need to take a look at deleting the dentry to deal with that
failure case.

Thanks,
