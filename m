From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fscrypto: move ioctl processing more fully
 into common code
Date: Sat, 26 Nov 2016 20:20:48 -0800
Message-ID: <20161127042048.GA34163@google.com>
References: <1476723246-47420-1-git-send-email-ebiggers@google.com>
	<20161127000901.wuyl6t6wp6qhmkrs@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers@google.com>) id 1cAqxZ-0004ja-SJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Nov 2016 04:21:01 +0000
Received: from mail-pg0-f51.google.com ([74.125.83.51])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cAqxZ-0000HP-30
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Nov 2016 04:21:01 +0000
Received: by mail-pg0-f51.google.com with SMTP id p66so43736320pga.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 26 Nov 2016 20:21:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161127000901.wuyl6t6wp6qhmkrs@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sat, Nov 26, 2016 at 07:09:01PM -0500, Theodore Ts'o wrote:
> On Mon, Oct 17, 2016 at 09:54:06AM -0700, Eric Biggers wrote:
> > In addition, make the common functions do the copies to and from
> > userspace rather than duplicating this code within each filesystem, and
> > memset the policy to 0 to make it clear there is no stack leak.
> 
> I don't see any point of doing this, given that we initialize all
> parts of the fscrypt_policy structure; and since this structure is
> part of UAPI, we can't change it without breaking userspace.
> 
> I'll apply this with the memset (and the above comment in the commit
> description) removed.
> 
> 					- Ted

I guess I'm okay with that, since struct fscrypt_policy won't have any padding
bytes because its members are all bytes.  Plus it's marked __packed, though I
think that was a mistake given that the struct isn't stored on disk directly.

Eric

------------------------------------------------------------------------------
