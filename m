From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: general stability of f2fs?
Date: Mon, 10 Aug 2015 13:31:06 -0700
Message-ID: <20150810203106.GA4575@jaegeuk-mac02>
References: <20150808205003.GA6546@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZOtm0-0002Fc-QH
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 20:34:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZOtly-0007Yf-Ph for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 20:34:20 +0000
Content-Disposition: inline
In-Reply-To: <20150808205003.GA6546@schmorp.de>
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

Hi Marc,

I'm very interested in trying f2fs on SMR drives too.
I also think that several characteristics of SMR drives are very similar with 
flash drives.

So far, the f2fs has been well performed on embedded systems like smart phones.
For server environement, however, I couldn't actually test f2fs pretty much
intensively. The major uncovered code areas would be:
- over 4TB storage space case
- inline_dentry mount option; I'm still working on extent_cache for v4.3 too
- various sizes of section and zone
- tmpfile, and rename2 interfaces

In your logs, I suspect some fsck.f2fs bugs in a large storage case.
In order to confirm that, could you use the latest f2fs-tools from:
 http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git

And, if possible, could you share some experiences when you didn't fill up the
partition to 100%? If there is no problem, we can nicely focus on ENOSPC only.

Thanks,

On Sat, Aug 08, 2015 at 10:50:03PM +0200, Marc Lehmann wrote:
> Hi!
> 
> I did some more experiments, and wonder about the general stabiulity of f2fs.
> I have not managed to keep an f2fs filesystem that worked for longer than a
> few days.
> 
> For example, a few days ago I created an 8TB volume and copied 2TB of data to
> it, which worked until I hot the (very low...) 32k limit on the number of
> subdirectories.
> 
> I moved some directoriesd into a single subdirectory, and continued.
> Everything seemed fine.
> 
> Today I ran fsck.f2fs on the fs, which found 4 inodes with wrong link counts
> (generally higher than fsck counted). It asked me whether to fix this, which
> I did.
> 
> I then did another fsck run, and was greeted with tens of thousands of
> errors:
> 
> http://ue.tst.eu/f692bac9abbe4e910787adee18ec52be.txt
> 
> Mounting made the box unusable for multiple minutes, probably due to the
> amount of backtraces:
> 
> http://ue.tst.eu/6243cc344a943d95a20907ecbc37061f.txt
> 
> The data is toast (which is fine, I am still experimenting only), but this,
> the weird write behaviour, the fact that you don#t get signalled on ENOSPC
> make me wonder what the general status of f2fs is.
> 
> It *seems* to be in actual use for a number of years now, and I would expect
> small hiccups and problems, so backups would be advised, but this level of
> brokenness (I only tested linux 3.18.14 and 4.1.4) is not something I didn#t
> expect from a fs that is in development for so long.
> 
> So I wonder what the general stability epxectation for f2fs is - is it just
> meant to be an experimental fs not used for any data, or am I just unlucky
> and hit so many disastrous bugs by chance?
> 
> (It's really too bad, it's the only fs in linux that has stable write
> performance on SMR drives at this time).
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
