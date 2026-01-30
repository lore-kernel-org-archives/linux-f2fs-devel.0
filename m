Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1373BD73EB7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUWapz2AEDKxEsXa5KefRItXjQg0KbRireAQa7IZNRE=; b=JoCOPmw+SlmqzwrsXpe8T/c1NB
	jV3KFEvlz8K1Be+2g2sFYljCyv8dQM/dT5UavjCSFFJtDpKWg5lb6HmXbOHzDYfA+L74Zk1oaX1du
	xE+jPKQIWBQOtD0NIk9uxpUWlur6aAAwXRJD6QzGX5F9xQH/e731S32aKydeMkmYV9eU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vlhQS-0002OX-TX;
	Fri, 30 Jan 2026 05:52:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vlhQQ-0002OH-VY
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 05:52:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mEHKxi4SFADuK0sR3mVEZtFcwJ2A43Diwr9KJqKLbSo=; b=WtW4yADqFz/EF9ngEVSdu79Whl
 Q4BVdXpq/nQydYzR89+Z5UnHf2FVXK4cgBB7+tDK1xIatAT7InHGq7YoVMmlI/Jnbkoj4mudkGK2F
 HO+v+hQx3iB9Ux4SnzuVDZyUwomFMxPyiJxkiMVzuhM1uTvM5vggOx+UEIePiIKkhN9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mEHKxi4SFADuK0sR3mVEZtFcwJ2A43Diwr9KJqKLbSo=; b=mOswSDWemlnU+N5lU7e3fpKRNp
 XcrZlU4+sxsCY3+keL50CmbbZ7ORnWWE5duaHasuyNncOvG3JtDnoLoIRH7Hov441HnYND9L62ipY
 cpnoQ3rsfayUUq3i34LmEa+bhzxJezHuPGjUb/JROWXKSUBdCaNHOFrhdTdSBSuLZfjk=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vlhQR-0001qN-80 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 05:52:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E26A168B05; Fri, 30 Jan 2026 06:51:57 +0100 (CET)
Date: Fri, 30 Jan 2026 06:51:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260130055157.GB622@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
 <20260128152630.627409-9-hch@lst.de> <20260128225602.GB2024@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128225602.GB2024@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vlhQR-0001qN-80
Subject: Re: [f2fs-dev] [PATCH 08/15] fsverity: kick off hash readahead at
 data I/O submission time
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jan 28, 2026 at 02:56:02PM -0800, Eric Biggers wrote:
> On Wed, Jan 28, 2026 at 04:26:20PM +0100, Christoph Hellwig wrote:
> > Currently all reads of the fsverity hashes is kicked off from the data
> > I/O completion handler, leading to needlessly dependent I/O.  This is
> > worked around a bit by performing readahead on the level 0 nodes, but
> > still fairly ineffective.
> > 
> > Switch to a model where the ->read_folio and ->readahead methods instead
> > kick off explicit readahead of the fsverity hashed so they are usually
> > available at I/O completion time.
> > 
> > For 64k sequential reads on my test VM this improves read performance
> > from 2.4GB/s - 2.6GB/s to 3.5GB/s - 3.9GB/s.  The improvements for
> > random reads are likely to be even bigger.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: David Sterba <dsterba@suse.com> [btrfs]
> 
> Unfortunately, this patch causes recursive down_read() of
> address_space::invalidate_lock.  How was this meant to work?

It worked by the chances that multiple down_read generally work.
Except when they don't and we have a write queued up in between,
but nothing in xfstests hits that.

I'll look into reworking it to avoid that.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
