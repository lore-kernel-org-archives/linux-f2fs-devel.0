From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: [PATCH] f2fs: convert inline_data for f2fs_fiemap
Date: Sat, 17 Oct 2015 00:57:13 +0200
Message-ID: <20151016225713.GB4666@schmorp.de>
References: <1445011637-16015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZnDwA-0005u7-Je
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Oct 2015 22:57:22 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZnDw8-0003kX-AW
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Oct 2015 22:57:22 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZnDw1-000702-Iu
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Oct 2015 22:57:13 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZnDw1-0000kD-Eb
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Oct 2015 22:57:13 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZnDw1-0001JM-E3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 17 Oct 2015 00:57:13 +0200
Content-Disposition: inline
In-Reply-To: <1445011637-16015-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

On Fri, Oct 16, 2015 at 09:07:17AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> For fiemap, we should convert inline_data for user.

Sorry for not answeriung your other mails, I'm busy, but I just saw this
patch:

> +	/* we don't need to use inline_data strictly */
> +	if (f2fs_has_inline_data(inode)) {
> +		ret = f2fs_convert_inline_inode(inode);

If that means that fiemap is no longer read-only but changes the layout, by
moving the data out of the inode, it's buggy - the correct way is to flag
those extents with FIEMAP_EXTENT_DATA_INLINE (and/or possibly other flags).

I didn't investigate the code, so maybe I am completely off here, just
guessing, really. If not, fiemap really is there to map the data extents, not
to de-optimise the filesystem. It's especially bad as fiemap is used by a lot
of tools to map disk layout.

If I am wrong, then please ignore my random mail here :)

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
