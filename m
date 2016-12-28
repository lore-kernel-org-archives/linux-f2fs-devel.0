From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 5/5] fscrypt: pass up error codes from
	->get_context()
Date: Tue, 27 Dec 2016 22:26:44 -0500
Message-ID: <20161228032644.hq5wi66y6rqlydka@thunk.org>
References: <1480965168-38747-1-git-send-email-ebiggers@google.com>
	<1480965168-38747-6-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1cM4tB-0005I6-5w
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 28 Dec 2016 03:26:53 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cM4tA-0002NT-HE
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 28 Dec 2016 03:26:53 +0000
Content-Disposition: inline
In-Reply-To: <1480965168-38747-6-git-send-email-ebiggers@google.com>
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

On Mon, Dec 05, 2016 at 11:12:48AM -0800, Eric Biggers wrote:
> It was possible for the ->get_context() operation to fail with a
> specific error code, which was then not returned to the caller of
> FS_IOC_SET_ENCRYPTION_POLICY or FS_IOC_GET_ENCRYPTION_POLICY.  Make sure
> to pass through these error codes.  Also reorganize the code so that
> ->get_context() only needs to be called one time when setting an
> encryption policy, and handle contexts of unrecognized sizes more
> appropriately.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied to the fscrypt branch.

					- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
