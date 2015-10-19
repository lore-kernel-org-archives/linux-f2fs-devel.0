From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: convert inline_data for f2fs_fiemap
Date: Mon, 19 Oct 2015 11:50:18 -0700
Message-ID: <20151019185018.GA23660@jaegeuk-mac02.mot.com>
References: <1445011637-16015-1-git-send-email-jaegeuk@kernel.org>
	<20151016225713.GB4666@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZoFVu-0002wz-DQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:50:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZoFVs-0001sk-JN for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Oct 2015 18:50:30 +0000
Content-Disposition: inline
In-Reply-To: <20151016225713.GB4666@schmorp.de>
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

On Sat, Oct 17, 2015 at 12:57:13AM +0200, Marc Lehmann wrote:
> On Fri, Oct 16, 2015 at 09:07:17AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > For fiemap, we should convert inline_data for user.
> 
> Sorry for not answeriung your other mails, I'm busy, but I just saw this
> patch:
> 
> > +	/* we don't need to use inline_data strictly */
> > +	if (f2fs_has_inline_data(inode)) {
> > +		ret = f2fs_convert_inline_inode(inode);
> 
> If that means that fiemap is no longer read-only but changes the layout, by
> moving the data out of the inode, it's buggy - the correct way is to flag
> those extents with FIEMAP_EXTENT_DATA_INLINE (and/or possibly other flags).

Cool, I found out it. :)
I submitted a patch to support that.

Thanks,

> 
> I didn't investigate the code, so maybe I am completely off here, just
> guessing, really. If not, fiemap really is there to map the data extents, not
> to de-optimise the filesystem. It's especially bad as fiemap is used by a lot
> of tools to map disk layout.
> 
> If I am wrong, then please ignore my random mail here :)
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
