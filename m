From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] f2fs: check bdi->dirty_exceeded when trying
 to skip data writes
Date: Wed, 2 Jul 2014 12:12:45 -0700
Message-ID: <20140702121245.b940538a410975ca91b40cfc@linux-foundation.org>
References: <1403956718-17575-1-git-send-email-jaegeuk@kernel.org>
	<20140701225420.6cc94fb5.akpm@linux-foundation.org>
	<20140702093126.GA25404@jmac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <akpm@linux-foundation.org>) id 1X2Pxd-0004rE-BJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Jul 2014 19:12:53 +0000
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X2Pxb-0001p4-Kl for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Jul 2014 19:12:53 +0000
In-Reply-To: <20140702093126.GA25404@jmac.local>
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

On Wed, 2 Jul 2014 02:31:26 -0700 Jaegeuk Kim <jaegeuk@kernel.org> wrote:

> > > --- a/fs/f2fs/node.c
> > > +++ b/fs/f2fs/node.c
> > > @@ -43,6 +43,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
> > >  		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >> 12;
> > >  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 2);
> > >  	} else if (type == DIRTY_DENTS) {
> > > +		if (sbi->sb->s_bdi->dirty_exceeded)
> > > +			return false;
> > >  		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
> > >  		res = mem_size < ((val.totalram * nm_i->ram_thresh / 100) >> 1);
> > >  	}
> > 
> > err, filesystems should not be playing around with this.
> > 
> > Perhaps VFS changes are needed.  Please tell us much much more about
> > what is going on here.
> 
> The f2fs has a feature which throttles IOs to merge bios in the fs level as much
> as possible by bypassing writepages in some cases.

OK, I just looked at fs/f2fs/data.c.  AFAICT it has basically
bypassed/reimplemented/worked around the VFS.

That may be good or it may be bad.  Maybe it indicates shortcomings in
the VFS, maybe it doesn't.  Presumably there were good reasons for this
design but I am unable to determine what they were, because the code is
undocumented.  No description of what it is trying to achieve or how or
why.  It's just a great blob of C statements.

This is all rather a shame, because perhaps there were opportunities
here to improve the core VFS.

Oh well, I think I'll pretend I never saw it.  Good luck!

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
