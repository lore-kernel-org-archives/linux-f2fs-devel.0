From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs updates for v4.5
Date: Thu, 14 Jan 2016 09:37:23 -0800
Message-ID: <20160114173723.GB54633@jaegeuk.gateway>
References: <20160113222353.GA51737@jaegeuk.gateway>
 <20160114095204.4ec98024@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160114095204.4ec98024@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Stephen,

On Thu, Jan 14, 2016 at 09:52:04AM +1100, Stephen Rothwell wrote:
> Hi Jaegeuk,
> 
> On Wed, 13 Jan 2016 14:23:53 -0800 Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.5
> 
> This contains 17 commits (of 87) that have never been in linux-next (but
> 3 are rebased and the rest probably will be in today).

I just forgot to push recent patches into dev branch which is used for
linux-next. I'll definitely take care of it in the next time.
Note that, however, recent patches are only internal f2fs changes, which would
not be broken by other components.

Thanks,

> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
