Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D87C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JhoF1AfQ4llhc5RJTNh+nTURGY0zn18AHB1q82OdooU=; b=UhemPK0rRI1N5PHgiAgPXxu5DY
	bmOn5g9ALIlJi1ZR/9bAfwx6jfUNvwGmoMaEoJvpUaOVX6ThEvg0dKA5a12gYXfexIK5y9HlDQjzH
	4pI/FKWjVARES9Md/inDUUFAbXyTyD+N9MJSX6E8wc/Vo8uI4B+Avvzi6bCTOc7eDI+g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8zgE-0001ow-25;
	Tue, 22 Sep 2026 12:33:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+a4e1fe537d2c1e8d4400+8430+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1x8zgC-0001og-Ok for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:33:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DoWMKpoGiRtUtawRlMT8UC8Ou0pBxNI+3BTSenoifKk=; b=auhh3Yc1Mt1CD5To8p0WKZIV/1
 DWLMXRY02K4IXzH6PlJG1oOChZCTGLec5ZYqNaR+kCpSkq7JrV0xdzt15FMALMjkjJd+2+iti8+sD
 edf7REF5qiOMgTngA6xygWlOYvXv+7cjYuaamzGR7CctnUQG1dwS9KdJ8VH6eQKrC8uE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DoWMKpoGiRtUtawRlMT8UC8Ou0pBxNI+3BTSenoifKk=; b=RU1H28oW64MCBSDz7TDjzt037s
 3WyKWQ3MO5GPiBy0GPWbOjHp0fw3Jwzai+UyISOF6R0+DB93Xrd7YnaOWBk29nhgbIHMYN6zxq/L3
 dGiP4UPKQznqeXf83ZYmldIZeqQk0t2xPsxvIRpiScNAsAJXhsqqN5Q0iQ2nxSjFzeVU=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8zgC-00089Y-7H for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:33:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DoWMKpoGiRtUtawRlMT8UC8Ou0pBxNI+3BTSenoifKk=; b=JlR7Kgn6Of7lIT5bj8t6yeRSIk
 ND1YN8FXctmH9e6xtJ+SWMF5boxLVQ3keTJNTnZdf+RIPtkp7HFem0/m73M18sFPaj4/IqH7ekL4T
 ifmPM09xiVhzHV7SiAjELUSWjC800HTLA7Jrnz5+cXE1jYeOmKIAf7KpiE33eYrZqdjGYkTt3mRyp
 7B5xtRCIlnQvgn4FAeo6MFxSr7BMukZBI6zsj+GvBis/72wfZTCBDtYWCzWx7aKWlNjiI3lNWVyVi
 fz+ZwmfUaMlUktkDRz5rGp90Uy0xr5uvVZjDszvJM1pITtocjKRbh1hbWbRP4v3dDjzjMFTpVLkJn
 sNGXOqzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x8zg5-00000005Jd2-2Ixo;
 Tue, 22 Sep 2026 12:32:53 +0000
Date: Tue, 22 Sep 2026 05:32:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <arJ1dfejt4DyCsvG@infradead.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-16-aalbersh@kernel.org>
 <arIszDCcy0VbRVFp@infradead.org>
 <arI-5Ejg0Xw7OVmH@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arI-5Ejg0Xw7OVmH@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1x8zgC-00089Y-7H
Subject: Re: [f2fs-dev] [PATCH v16 15/21] xfs: add fs-verity support
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, linux-ext4@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Sep 22, 2026 at 10:56:09AM +0200, Andrey Albershteyn wrote:
> On 2026-09-22 00:22:52, Christoph Hellwig wrote:
> > On Fri, Sep 18, 2026 at 01:15:27PM +0200, Andrey Albershteyn wrote:
> > > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > > +	xfs_trans_ijoin(tp, ip, 0);
> > > +
> > > +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));
> > 
> > We can't call truncate_inode_pages with the ilock held.
> > 
> > I also don't see what this is trying to protect to start with.
> > 
> 
> I added this to remove stale pages created post-EOF, so, writeback
> doesn't try to flush them latter (but now I see that writeback will
> fail to map them to extents anyway). Also, if EOF gets extended
> these pages would be exposed as they are up-to-date which would be
> unexpected garbage.

Yeah, but what is the ilock trying to protect against?  ilock is
the innermost sleeping lock and protects modifications to the
inode fields and the extent mapping.   Higher level synchronization
is done using the iolock and the mmaplock (which is already taken
here).



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
