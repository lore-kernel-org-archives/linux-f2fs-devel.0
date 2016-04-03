From: Eric Biggers <ebiggers3@gmail.com>
Subject: A few more filesystem encryption questions
Date: Sun, 3 Apr 2016 00:58:33 -0500
Message-ID: <20160403055833.GA3214@zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers3@gmail.com>) id 1amb3a-0006nc-3Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Apr 2016 05:58:42 +0000
Received: from mail-ig0-f194.google.com ([209.85.213.194])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1amb3Z-0005F3-DS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Apr 2016 05:58:42 +0000
Received: by mail-ig0-f194.google.com with SMTP id sy18so7732232igc.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 02 Apr 2016 22:58:41 -0700 (PDT)
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org
Cc: tytso@mit.edu, mhalcrow@google.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

Hello,

A few more questions about the new filesystem encryption code:

I found that a process without access to the master encryption key can read a
file's full decrypted contents, provided that the file was opened recently by a
process with access to the key.  This is true even if the privileged process
merely opened and closed the file, without reading any bytes.  A similar story
applies to filenames; a 'ls' by a process able to decrypt the names reveals them
to all users/processes.  Essentially, it seems that despite the use of the
kernel keyrings mechanism where different users/processes can have different
keys, this doesn't fully carry over into filesystem encryption.  Is this a known
and understood limitation of the design?

The design document states that an encryption policy can be changed "if the
directory is empty or the file is 0 bytes in length".  However, the code doesn't
allow an existing encryption policy to be changed.  Which behavior was intended?

I had brought up the question of the endianness of the XTS tweak value.  I also
realized that since the page index is used, the XTS tweak will be dependent on
PAGE_SIZE.  So the current behavior is that an encrypted filesystem can only be
read on a device with the same endianness _and_ PAGE_SIZE.  Is is the case that
due to the early Android users, it is too late to start using the byte offset
instead of the PAGE_SIZE?  What about if the XTS tweak was fixed as the number
of 4096-byte blocks from the start of the file as a le64 --- is that what the
existing users are expected to be doing in practice?  Are there any
architectures with PAGE_SIZE < 4096 for which that value wouldn't work?

Eric

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785471&iu=/4140
