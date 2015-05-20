From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4] f2fs crypto: check encryption for tmpfile
Date: Tue, 19 May 2015 22:01:25 -0700
Message-ID: <20150520050125.GB56982@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
 <1432082606-55975-3-git-send-email-jaegeuk@kernel.org>
 <20150520044604.GD2871@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150520044604.GD2871@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, May 20, 2015 at 12:46:04AM -0400, Theodore Ts'o wrote:
> On Tue, May 19, 2015 at 05:43:25PM -0700, Jaegeuk Kim wrote:
> > This patch adds to check encryption for tmpfile in early stage.
> 
> Don't you also need a call to ext4_inherit_context(dir, inode) here?
> (I need to fix this for ext4 as well).

Actually this should be:

	err = f2fs_get_encryption_info(inode);   <- for inode.
	if (err)
		goto out;

In f2fs, f2fs_do_tmpfile calls f2fs_inherit_context already. :)

> 
> 					- Ted
