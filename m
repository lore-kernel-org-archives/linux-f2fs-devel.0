From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: general stability of f2fs?
Date: Mon, 10 Aug 2015 22:53:32 +0200
Message-ID: <20150810205332.GA4911@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZOu4l-0007tH-Ie
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 20:53:43 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZOu4h-0005gJ-VN
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 20:53:43 +0000
Content-Disposition: inline
In-Reply-To: <20150810203106.GA4575@jaegeuk-mac02>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On Mon, Aug 10, 2015 at 01:31:06PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> I'm very interested in trying f2fs on SMR drives too.
> I also think that several characteristics of SMR drives are very similar with 
> flash drives.

Indeed, but of course there isn't an exact match for any characteristic.
Also, in the end, drive-managed SMR drives will suck somewhat with any
filesystem (note that nilfs performs very badly, even thought it should be
better than anything else till the drive is completely full).

Now, looking at the characteristics of f2fs, it could be a good match for
any rotational media, too, since it writes linearly and can defragment. At
least for desktop or similar loads (where files usually aren't randomly
written, but mostly replaced and rarely appended).

The only crucial ability it would need to have is to be able to free large
chunks for rewriting, which should be in f2fs as well.

So at this time, what I apparently need is mkfs.f2fs -s128 instead of -s7.

Unfortunately, I probably can't make these tests immediately, and they do
take some days to run, but hopefully I cna repeatmy experiments next week.

> - over 4TB storage space case

fsck limits could well have been the issue for my first big filesystem,
but not the second (which was only 128G in size to be able to utilize it
within a reasonable time).

> - inline_dentry mount option; I'm still working on extent_cache for v4.3 too

I only enabled mount options other than noatime for the 128G filesystem,
so it might well have cauzsed the trouble with it.

Another thing that will seriously hamper adoption of these drives is the
32000 limit on hardlinks - I am hard pressed to find any large file tree
here that doesn't have places with of 40000 subdirs somewhere, but I guess
on a 32GB phone flash storage, this was less of a concern.

In any case, if f2fs turns out to be workable, it will become the fs of
choice for me for my archival uses, and maybe even more, and I then have
to somehow cope with that limit.

> In your logs, I suspect some fsck.f2fs bugs in a large storage case.
> In order to confirm that, could you use the latest f2fs-tools from:
>  http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git

Will do so.

Is there a repository for out-of-tree module builds for f2fs? It seems
kernels 3.17.x to 4.1 (at least) have a kernel bug making reads to these SMR
drives unstable (https://bugzilla.kernel.org/show_bug.cgi?id=93581), so I
will have to test with a relatively old kernel or play too many tricks.

And I suspect from glancing over patches (And mount options) that there
have been quite some improvements in f2fs since 3.16 days.

> And, if possible, could you share some experiences when you didn't fill up the
> partition to 100%? If there is no problem, we can nicely focus on ENOSPC only.

My experience was that f2fs wrote at nearly maximum I/O speed of the drives.
In fact, I couldn't saturate the bandwidth except when writing small files,
because the 8 drive source raid using xfs was not able to read files quickly
enough. After writing an initial tree of >2TB

Directory reading and mass stat seemed to be considerably slower and take
more time directly afterwards. I don't know if that is something that
balancing can fix (or improve), but I am not overly concerned about that,
as the difference to e.g. xfs is not that big (roughly a factor of two),
and thes eoperations are too slow for me on any device, so I usually put a
dm-cache in front of such storage devices.

I don't think that I have more useful data to report - if I used 14MB
sections, performance would predictably suck, so the real test is still
outstanding. Stay tuned, and thanks for your reply!

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
