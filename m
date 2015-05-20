From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs crypto: add rwsem to avoid data races
Date: Tue, 19 May 2015 17:38:59 -0700
Message-ID: <20150520003859.GA55280@jaegeuk-mac02.mot.com>
References: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
 <20150519142943.GE20421@thunk.org>
 <555B4A32.3000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555B4A32.3000302@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, May 19, 2015 at 10:35:30AM -0400, nick wrote:
> 
> 
> On 2015-05-19 10:29 AM, Theodore Ts'o wrote:
> > On Mon, May 18, 2015 at 10:36:41PM -0700, Jaegeuk Kim wrote:
> >> Previoulsy, fi->i_crypt_info was not covered by any lock, resulting in
> >> memory leak.
> >>
> >> This patch adds a rwsem to avoid leaking objects on i_crypt_info.
> >>
> >> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > 
> > I'm not sure we need an rwsem to fix this issue.  In terms of
> > serializing the creation and deletion of the structure, it should be
> > possible to use an cmpxchg() on the pointer itself.  (e.g., if we lose
> > the race on the creation side, we just release our structure and use
> > the one that the winner allocated).
> > 
> > If we do end up needing to serialize access to the tfm in the
> > i_crypt_info object for datapath reads/writes, then we might need a
> > mutex, but I think that should be it, no?
> > 
> > 	       	     	   	       - Ted
> > 
> I have to agree with Ted here, as mutual exclusion locking is ideal
> for the scenario here of a reader vs writer exclusion. My only concern

What I'm saying is writer vs writer actually.

> is that can there be many readers to one writer here as if so reader/writer
> spin locks may be better.

I could write another patch using a rwlock by removing needless down_write for
f2fs_free_encryption_info.

Thanks,

> Nick  
