From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] fscrypt: remove filesystem specific build
 config option
Date: Thu, 24 Jan 2019 10:29:50 -0800
Message-ID: <20190124182949.GB10448@gmail.com>
References: <20190110233230.GA23953@roeck-us.net>
 <20190111010116.GG149637@gmail.com>
 <20190124050337.GD8785@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124050337.GD8785@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Guenter Roeck <linux@roeck-us.net>, Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jan 24, 2019 at 12:03:37AM -0500, Theodore Y. Ts'o wrote:
> On Thu, Jan 10, 2019 at 05:01:17PM -0800, Eric Biggers wrote:
> > 
> > Indeed, Chandan Rajendra sent out a new version of the patch which fixes the
> > problem (by removing the 'select BLOCK' from fs/ubifs/Kconfig), but it never
> > made it into the fscrypt tree and hence never made it into linux-next.
> > 
> > Ted, what you are planning to do with the fscrypt tree following the fsverity
> > discussion?  IMO, we should keep the fsverity stuff in its own branch, separate
> > from any fscrypt changes.  As a suggestion, in the branch "fscrypt" of my
> > linux.git repo [1], I applied just these four patches on top of v5.0-rc1 and
> > resolved the conflicts with them no longer being on top of fsverity...
> 
> Sorry, I was on vacation last week and I've been catching up on things
> this week.  I've reset the master branch on my fscrypt.git tree so
> that it has what you have on your fscrypt branch, rebased to 5.0-rc3.
> 
> Also, as we had talked about earlier, it probably makes sense to set
> up jointly maintained git tree for fscrypt and fsverity.  My proposal
> is that we set up a new fscrypt.git tree, at
> /pub/scm/fs/fscrypt/fscrypt.git, that would be owned by the "FSCRYPT
> group", with group membership being ebiggers, jaeguk, and tytso.
> We'll have to figure out ways that we can jointly update the git tree
> without stepping on each other, probably using a group chat.  Does
> that sound good to you?
> 

Hi Ted, that sounds good to me.  I assume you know how to get that set up?
Also, should I go ahead and send a patch that adds myself to the MAINTAINERS
file?

- Eric
