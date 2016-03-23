From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: [PATCH] f2fs: give RO message when recovering
 superblock
Date: Wed, 23 Mar 2016 22:10:48 +0100
Message-ID: <20160323211048.GA7279@schmorp.de>
References: <1458765499-22921-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1aiq3N-0000ln-Ir
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 21:10:57 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aiq3M-0003sS-Ca
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 21:10:57 +0000
Content-Disposition: inline
In-Reply-To: <1458765499-22921-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Mar 23, 2016 at 01:38:19PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> When one of superblocks is missing, f2fs recovers it with the valid one.
> But, even if f2fs is mounted as RO, we'd better notify that too.

(I have written this in my other mail, but in case you didn't see it, because
it wasn't directly sent to you, I replied directly).

Basically all other filesystems do not treat "ro" as anything but as a vfs
flag - the mounted volume will be readonly, but they will happily write to
the volume for recovery or integrity purposes. This has been extensively
discussed on lkml in the past and it was decided that overloading "ro" to
have two different meanings is bad.

If f2fs wants to suppress writes, it should use the norecovery option to
decide, not the ro option. This is the behaviour that other filesystems
follow (at least extN, xfs).

Unless f2fs has a very good reason (which I don't think it has), it should
behave like the other filesystems, and treat "ro" merely as a vfs flag to
suppress writing.

There is a third reason to not change the meaning: typically, the root fs
is mounted ro first and later rw. Therefore f2fs must make sure to have
full integrity on a ro mount, even if that means writing to the backing
store. It isn't acceptable to make ro mounts fail when rw mounts would
work, for example, when upgrading the kernel and rebooting.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
