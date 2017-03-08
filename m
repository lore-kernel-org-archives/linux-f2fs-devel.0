From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs_bug_on in init_dirty_segmap
Date: Wed, 8 Mar 2017 13:52:03 -0800
Message-ID: <20170308215203.GE5483@jaegeuk.local>
References: <20170308142432.GA31333@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cljVH-0004eV-Rg
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:52:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cljVG-0006qq-QK
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 21:52:15 +0000
Content-Disposition: inline
In-Reply-To: <20170308142432.GA31333@frolo.macqel>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Philippe De Muyter <phdm@macq.eu>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 03/08, Philippe De Muyter wrote:
> Hi f2fs developpers,
> 
> Please excuse my maybe dumb question.
> 
> I recently encountered a kernel panic at root mount time (thus making my
> system unusable, as my root partition is formatted as f2fs) due to the
> following segment in fs/f2fs/segment.c:init_dirty_segmap
> 
> 		if (valid_blocks > sbi->blocks_per_seg) {
>                         f2fs_bug_on(sbi, 1); <<<<<<<<<<<<<<<<<<<<
> 			continue;
> 		}
> 
> Is that really a condition requiring a kernel panic, or could a read-only
> mount be allowed ?

It would be helpful that you can remain your kernel and f2fs-tools version
information, as well as fsck.f2fs result.

You can get the latest f2fs-tools from
http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/log/?h=dev-test

Anyway, if you don't have time, you may have some options like:

1. disable F2FS_CHECK_FS in Kconfig
 : bypass BUG_ON here, so mount-ro would be preferable.

2. run fsck.f2fs
 : fix some inconsistency and let you mount your system again.

So, I think you'd better try #1 to retrieve your important data, and then
#2 to fix something wrong.

Thanks,

> 
> Philippe
> 
> -- 
> Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
> 
> ------------------------------------------------------------------------------
> Announcing the Oxford Dictionaries API! The API offers world-renowned
> dictionary content that is easy and intuitive to access. Sign up for an
> account today to start using our lexical data to power your apps and
> projects. Get started today and enter our developer competition.
> http://sdm.link/oxford
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
