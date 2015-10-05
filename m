From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: dir_level explained?
Date: Mon, 5 Oct 2015 16:05:12 -0700
Message-ID: <20151005230353.GB7635@jaegeuk-mac02.mot.com>
References: <20151004095647.GC3177@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZjEos-0002kt-Ee
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 23:05:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZjEor-0001dF-AL for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 23:05:22 +0000
Content-Disposition: inline
In-Reply-To: <20151004095647.GC3177@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Sun, Oct 04, 2015 at 11:56:47AM +0200, Marc Lehmann wrote:
> Hi!
> 
> In all my tests I intentionally didn't play with dir_level, to get an idea of
> baseline performance. I also wasn't worried because my standard response to
> slow random reads is dmcache, but now that I realised I can't use dmcache
> with these drives, I got more interested in dir_level.
> 
> If I understand it correctly, higher values of dir_level potentially waste
> more space but gain performance. However, I have no clue about what the
> trade-off really is.

The default directory structure consists of multi-level hash tables [1].
Each level represents a hash table, and when the level increases, f2fs
constructs a bigger hash table. Its height depends on the number of hash
collisions and there-in directory entries. So, normally, we expect lookup
overhead is O(logN).

However, if we assume a directory will have huge number of directory entries,
one big hash table would be perferable initially. In this case, you can increase
dir_level to obtain O(1).

So, dir_level indicates the base height when building a directory structure.
For example, if all the file names are less than 8 bytes long, you can set
dir_level as N to cover roughly 428*2^N entries in a big hash table.

[1] https://en.wikipedia.org/wiki/F2FS

> 
> Could you explain what kind of extra space usage I can expect from higher
> levels of dir_level, or what the values mean?
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
