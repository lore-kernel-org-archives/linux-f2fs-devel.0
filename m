From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs updates for v4.2
Date: Wed, 24 Jun 2015 23:48:26 -0700
Message-ID: <20150625064522.GA44674@jaegeuk-mac02.mot-mobility.com>
References: <20150624202401.GA40031@jaegeuk-mac02.mot.com>
 <CA+55aFycRo0ttWw5kAgf=tDrfz-hvhSsjveu9LqdXH-RNbXE3A@mail.gmail.com>
 <20150625043334.GT17109@ZenIV.linux.org.uk>
 <20150625054917.GA43469@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150625063235.GV17109@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150625063235.GV17109@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jun 25, 2015 at 07:32:36AM +0100, Al Viro wrote:
> On Wed, Jun 24, 2015 at 10:50:10PM -0700, Jaegeuk Kim wrote:
> 
> > Right, I missed merging the fix-up patch in linux-next into my pull-request.
> > At a glance, I think there is no problem; except 80 column width, though.
> > 
> > Also, agreed that I need to take a look at deleting the dentry to deal with that
> > failure case.
> 
> 	Why not set the symlink up first and create a directory entry only
> if that succeeds?  Looks like it's less work that way...

Cause f2fs_add_link initializes some on-disk inode structures to be used when
writing data.

Maybe simply call f2fs_unlink?
