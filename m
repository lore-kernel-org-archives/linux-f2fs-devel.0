From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [f2fs-dev] [PATCH] f2fs crypto: add rwsem to avoid data races
Date: Wed, 20 May 2015 08:38:30 -0400
Message-ID: <20150520123830.GE2871@thunk.org>
References: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
 <20150519142943.GE20421@thunk.org>
 <555B4A32.3000302@gmail.com>
 <20150520003859.GA55280@jaegeuk-mac02.mot.com>
 <20150520043518.GC2871@thunk.org>
 <20150520045554.GA56982@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150520045554.GA56982@jaegeuk-mac02.hsd1.ca.comcast.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: nick <xerofoify@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, May 19, 2015 at 09:55:54PM -0700, Jaegeuk Kim wrote:
> 
> Looking at a glance, it's mostly same as what I wanted. The key is to share
> ci->ci_ctfm for regular file and the other dir/symlink files.
> So, ext4_get_encryption_info will handle most of cases.

Yeah, I noticed after sending out my changes that your patches did
something really similar in that regard.  "Great minds run in the same
channels", as the (very) old saying goes...

> In ext4_readdir, it also needs ext4_get_encryption_info?

No, it not needed because when the directory is opened using
opendir(3), we'll end up calling ext4_get_encryption_info() in
ext4_file_open() --- yes, the name is a little misleading, but it gets
used for all ext4 open(2)'s.

One of the things which I've been mildly concerned about is that in
the no key case, we end up calling ext4_get_encrpyion_info() over and
over again, which means we end up calling request_key() over and over
again as well.  On the other hand, we do want to use the key as soon
as it becomes available, there isn't a good way of doing a negative
cache on the unavailability of the logon key that could be reliably
revoked the moment the user does have the key --- and the no-key case
isn't the common one, so I haven't worried too much about it.  But I
did want to remove it from the readdir() path, since it also means
that we don't have to worry about oddities stemming from half the
files being returned in encrypted form, and half the files in
plaintext, because the user inserted an encryption key in the while
there was an "ls" running in the background.

Cheers,

						- Ted
