From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] f2fs crypto: add rwsem to avoid data races
Date: Tue, 19 May 2015 10:29:43 -0400
Message-ID: <20150519142943.GE20421@thunk.org>
References: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, May 18, 2015 at 10:36:41PM -0700, Jaegeuk Kim wrote:
> Previoulsy, fi->i_crypt_info was not covered by any lock, resulting in
> memory leak.
> 
> This patch adds a rwsem to avoid leaking objects on i_crypt_info.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

I'm not sure we need an rwsem to fix this issue.  In terms of
serializing the creation and deletion of the structure, it should be
possible to use an cmpxchg() on the pointer itself.  (e.g., if we lose
the race on the creation side, we just release our structure and use
the one that the winner allocated).

If we do end up needing to serialize access to the tfm in the
i_crypt_info object for datapath reads/writes, then we might need a
mutex, but I think that should be it, no?

	       	     	   	       - Ted
