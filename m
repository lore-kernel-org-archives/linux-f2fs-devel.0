From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: [PATCH 3/5] f2fs: report readonly status in ->fsync
Date: Sat, 26 Dec 2015 07:32:58 +0100
Message-ID: <20151226063258.GA4641@schmorp.de>
References: <016601d13e33$0ecdfd50$2c69f7f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1aCiQN-0002Oj-Jo
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 06:33:55 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aCiQL-0006NC-Ox
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 06:33:55 +0000
Content-Disposition: inline
In-Reply-To: <016601d13e33$0ecdfd50$2c69f7f0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Dec 24, 2015 at 06:07:25PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> Report readonly status of filesystem during fsync.

If this means that fsync returns EROFS when used on a file on a read-only
filesystem., then this looks buggy - EROFS is not documented for
fsync (only as "fd is bound to a special file which does not support
synchronization") for this condition, and I don't think other filesystems
do that (just tried xfs).

It also doesn't quite make sense - fsync should only fail when the file
couldn't be synced, but in most (probably all) cases, the file is already
synchronised, otherwise the filesystem shouldn't be RO.

I only looked at the diff, so if I missed the context and my reasoning
doesn't apply, forgive and ignore me :)

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
