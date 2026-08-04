Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55567C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/dpDqYPdYjhGAN6pQEXvmua3pw01hqb8HSP5JGXi35o=; b=FL/zWsIhW2hr8EciaYs70ifV+9
	ldRV7mdIXCG5w5VCfyCDBWqNgtF0CG05XRteEj3gDmyvTv+wOxtKS5mmAizUil/JVhqpCWKq6dLP2
	wcsspMeu85cEIte4pWe138aDL2vW2BqD2TrV5r5yOOSuvTxi2TED5TzchA7oQQDo/xAQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrKou-0004zX-9n;
	Tue, 04 Aug 2026 19:29:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wrKot-0004zR-9B
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 19:28:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WP6wjE7qBnj/GunjrqvRBraBLVBkydynCewnbZ45t5E=; b=BgA29t4GJQw1kWQL1G7qzBSoKL
 Gt+c56Jdwa1LK5YZrHxWfC0QY7fwFDjHmyQDSwMyXpb1pDGrJuaEUxunwVIYp0x9TLPaTr/+52jvd
 si/72C6ZopKRAAOqo9TJJ78pWKE4fiA0yDsCSk5kiz/6HTuDh/0OAQjEYEpJ0p6vFqFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WP6wjE7qBnj/GunjrqvRBraBLVBkydynCewnbZ45t5E=; b=AbdRF0id4Nl351omkHc/NoU7yS
 82VnV/jBtiyXk1nQkaJvRTz4ll8+zJYaSInPi+C/BS7q4RtBxxtm6R2fr4w0xxEWFBEfNwhgJ35a9
 L10EQN4VfMKUf6paJPMo6dBLjaFZWnEGxTTZVD4hWlVlkT5KeUa5xTu1I97S378TbM/M=;
Received: from [90.155.50.34] (helo=casper.infradead.org)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrKov-000315-5E for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 19:28:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WP6wjE7qBnj/GunjrqvRBraBLVBkydynCewnbZ45t5E=; b=IPOxK2kIjgPlxLgyvM+ibdufZV
 qhsZVGcuyTtaA3Pir2gF5JgsdoJrPXPRwOoFEIs4vLeWpzMOp2IlvrfnQCn6TauSmBSLIN5+SYmO4
 TyEWBwu6aV+rF2IyBtnbK3VjfRVkrMuFT9GfKrqwWgsSAZgroNijF/7kF0nFQM8g+aFSn1R44SMUu
 zT0iPzhgk/5R7cFv+K+DW3KSU4e6n+QqQ83UtnFyNsJuX1N8NAXlkZBMG3du1L8Uly/1tclAZtiB6
 GWcrf1cPozqPOjPAxleYmJW4CemcXafgGTzCoyywXua2bXD4ev8sEkIKxsshSTmXZynSWbbYAyDFO
 6NbjtFDA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wrKol-00000004bOs-1Zgg;
 Tue, 04 Aug 2026 19:28:51 +0000
Date: Tue, 4 Aug 2026 20:28:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <anI9cztkOa1yg7yv@casper.infradead.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
 <anIzawflI11C0FT2@casper.infradead.org>
 <20260804185603.GP3556460@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804185603.GP3556460@frogsfrogsfrogs>
X-Headers-End: 1wrKov-000315-5E
Subject: Re: [f2fs-dev] [PATCH v14 05/21] fsverity: improve flushing
 performance of fsverity_fill_zerohash
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 04, 2026 at 11:56:03AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 04, 2026 at 07:46:03PM +0100, Matthew Wilcox wrote:
> > On Mon, Aug 03, 2026 at 10:07:55PM +0200, Andrey Albershteyn wrote:
> > > The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> > > flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> > > systems. Open code folio mapping and flushing to copy all digests at
> > > once.
> > 
> > Have you looked at the implementations of flush_dcache_folio()?  On
> > any architecture we actually care about, all it does is set one bit
> > in folio->flags noting that the folio will need to be flushed if
> > it's going to be accessed by userspace.
> > 
> > But, um, do we support mapping folios containing fsverity data into
> > userspace?  Can't we just delete the calls to flush_dcache_folio()?
> 
> I don't think programs are allowed to mmap the fsverity data, right?
> I know there's an ioctl that effectively allows read()ing it.

read() is fine, there's no user/kernel d-cache aliasing problem with
read().  It's just mmaps that are problematic.

See Documentation/core-api/cachetlb.rst where it talks about
flush_dcache_folio().


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
