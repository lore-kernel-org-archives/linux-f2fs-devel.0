From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] fscrypto: move ioctl processing more fully
 into common code
Date: Sat, 26 Nov 2016 19:09:01 -0500
Message-ID: <20161127000901.wuyl6t6wp6qhmkrs@thunk.org>
References: <1476723246-47420-1-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1cAn1r-0008KD-4y
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Nov 2016 00:09:11 +0000
Received: from imap.thunk.org ([74.207.234.97])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cAn1p-00026o-UI
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Nov 2016 00:09:11 +0000
Content-Disposition: inline
In-Reply-To: <1476723246-47420-1-git-send-email-ebiggers@google.com>
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
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Oct 17, 2016 at 09:54:06AM -0700, Eric Biggers wrote:
> In addition, make the common functions do the copies to and from
> userspace rather than duplicating this code within each filesystem, and
> memset the policy to 0 to make it clear there is no stack leak.

I don't see any point of doing this, given that we initialize all
parts of the fscrypt_policy structure; and since this structure is
part of UAPI, we can't change it without breaking userspace.

I'll apply this with the memset (and the above comment in the commit
description) removed.

					- Ted

------------------------------------------------------------------------------
