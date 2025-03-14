Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60941C35FF1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Mar 2025 16:01:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tt7T5-0004ua-PE;
	Fri, 14 Mar 2025 16:01:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tt7T3-0004uC-OO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Mar 2025 16:01:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C0yYClMn1+x43vPQYH6dJTU2IcS5SituW9z569SSHiw=; b=GeSAPW99BFU38eZuq9L5bpXZ8Y
 tofS1+dGvKP8SPPaqd2IKIDrAZcXcOfRorWlpDCK0mOWyWk2T3LdjImoNrLC2sbfFBcLyZ/H+6hYo
 E7qfRy5uvpm+UmJYFIZP5SwWexHeVs5YS3lMvGRXLxdZD1/zkI9xRwKBtrcOuGDkKt28=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C0yYClMn1+x43vPQYH6dJTU2IcS5SituW9z569SSHiw=; b=CSqzkhPRDuifp7E00/hmlKCKMt
 Pe+luRuku/HXYtMXLeNwDjhUDMIANMSrinPvA6bnOOKnEbf6Rac1lNo7frCioS4XaUKO3/DFIKt6P
 xxn07r39Vx6deQcmmjq6RHWdmnhRI1D7QAkX+FJ1I9TnyAkfbkFqlWer7BmyfVl+/w7I=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tt7T1-0002bk-R1 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Mar 2025 16:01:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=C0yYClMn1+x43vPQYH6dJTU2IcS5SituW9z569SSHiw=; b=qn+0QgCAIUlOoSppaJolf+Pkup
 usBjsQ3GvMp19wz8LDTYZikllk+A4C1L7UMmAfXH0YdHKlFd35aU93LrtVQbVT2SowH4UoOCKllUp
 xq8UpFKffgvcVmEVGe+tx8iuYEIjD0A/SQYcgi20Dd1UGj/XlrTLD1chu48VYLJFKRZ6OMbBhPsCe
 Qxtu6q2Tgl4lxLmLIFKRmMORGX5j2vWg2mV/QCIXSJaSsPMKvN4y13KHJYEx0UPZ6R/0bvx9Oom3g
 1KLLLd4AUxZr7tN4ZKbt3zX7FclJPY5WMmkesGlHpkcHtYnBfZDp8SotwD4fnOkBTOzAMPNC4TEDE
 VeYQHyKg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tt7PO-00000002jck-2MIq; Fri, 14 Mar 2025 15:58:55 +0000
Date: Fri, 14 Mar 2025 15:57:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Z9RR2ubkS9CafUdE@casper.infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
 <Z9DSym8c9h53Xmr8@casper.infradead.org>
 <Z9Dh4UL7uTm3cQM3@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9Dh4UL7uTm3cQM3@google.com>
X-Headers-End: 1tt7T1-0002bk-R1
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 12, 2025 at 01:22:41AM +0000, Jaegeuk Kim wrote:
> On 03/12, Matthew Wilcox wrote:
> > On Tue, Mar 11, 2025 at 07:50:38PM +0000, patchwork-bot+f2fs@kernel.org wrote:
> > > Hello:
> > > 
> > > This series was applied to jaegeuk/f2fs.git (dev)
> > > by Jaegeuk Kim <jaegeuk@kernel.org>:
> > 
> > Thanks!
> > 
> > FWIW, I have a tree with 75 patches in it on top of this that do more
> > folio conversion work.  It's not done yet; maybe another 200 patches to
> > go?  I don't think it's worth posting at this point in the cycle, so
> > I'll wait until -rc1 to post, by which point it'll probably be much
> > larger.
> 
> Ok, thanks for the work! Will keep an eye on.

Unfortunately, I thnk I have to abandon this effort.  It's only going
to make supporting large folios harder (ie there would then need to be
an equivalently disruptive series adding support for large folios).

The fundamental problem is that f2fs has no concept of block size !=
PAGE_SIZE.  So if you create a filesystem on a 4kB PAGE_SIZE kernel,
you can't mount it on a 16kB PAGE_SIZE kernel.  An example:

int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
{
        struct f2fs_inode *ri;
        ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
        ri = F2FS_INODE(page);

so an inode number is an index into the filesystem in PAGE_SIZE units,
not in filesystem block size units.  Fixing this is a major effort, and
I lack the confidence in my abilities to do it without breaking anything.

As an outline of what needs to happen, I think that rather than passing
around so many struct page pointers, we should be passing around either
folio + offset, or we should be passing around struct f2fs_inode pointers.
My preference is for the latter.  We can always convert back to the
folio containing the inode if we need to (eg to mark it dirty) and it
adds some typesafety by ensuring that we're passing around pointers that
we believe belong to an inode and not, say, a struct page which happens
to contain a directory entry.

This is a monster task, I think.  I'm going to have to disable f2fs
from testing with split page/folio.  This is going to be a big problem
for Android.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
