From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 3/5] fscrypt: use EEXIST when file
 already uses different policy
Date: Tue, 27 Dec 2016 21:29:24 -0500
Message-ID: <20161228022924.2dobpfyxyfce2gby@thunk.org>
References: <1480965168-38747-1-git-send-email-ebiggers@google.com>
	<1480965168-38747-4-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1cM3zf-00044z-QM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 28 Dec 2016 02:29:31 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cM3ze-0003Y3-Ut
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 28 Dec 2016 02:29:31 +0000
Content-Disposition: inline
In-Reply-To: <1480965168-38747-4-git-send-email-ebiggers@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@google.com>
Cc: David Gstir <david@sigma-star.at>, Richard Weinberger <richard@nod.at>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

On Mon, Dec 05, 2016 at 11:12:46AM -0800, Eric Biggers wrote:
> As part of an effort to clean up fscrypt-related error codes, make
> FS_IOC_SET_ENCRYPTION_POLICY fail with EEXIST when the file already uses
> a different encryption policy.  This is more descriptive than EINVAL,
> which was ambiguous with some of the other error cases.
> 
> I am not aware of any users who might be relying on the previous error
> code of EINVAL, which was never documented anywhere.
> 
> This failure case will be exercised by an xfstest.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied to the fscrypt branch, thanks.

						- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
