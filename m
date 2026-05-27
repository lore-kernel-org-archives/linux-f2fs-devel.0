Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C0ECD5BD5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqT/b+cEcx/iPLnyQg6s9vsFYvAZsYkBhzv+fceV7lM=; b=LnVHKGyddCDnk8F61bkPT54J5g
	a3k9VStf5gJoWGjmxFDjRapdmVvINOLakCD0uBGsjcQjZCZqQ74zdcMu4VvoolVrf3Kl6PViDvayQ
	q+x9bVA2z/HtlwNAjx+fOq0VWAZl7qQA4xTPavu23vitkZamBcgVg/MMaEJxfGrkhcL0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wS7oh-0005lQ-6O;
	Wed, 27 May 2026 06:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e9735a96feccf8b5d28d+8312+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wS7oJ-0005jY-Kw for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nWhD6NqGWQeaAF9weLMiDIdx5fT308tj+4gRK0S0CiQ=; b=QhSmoyYdnOeIrhXIrp1ItQhpIh
 mR+7eBlslp3IHVf0U+KMhFkwy7krikZRh+bVjgHDhBDfBjV21xUZ8+0XEUA5v21cARhjYP/NjvJ+y
 kraXjZm1LBSvQJG/eh6Q26AIc852TAclWLb/Bljdcrcdp1nP3KVgSRWOe/EN+RrhX/qY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nWhD6NqGWQeaAF9weLMiDIdx5fT308tj+4gRK0S0CiQ=; b=Idgl4Vt9/GVa5C81wlL01vSq5S
 LlQJ2dvh1P4u5+H2wlxAi10WQrRdi5aj6l3OimQzWNu5sE6Zmvgtx6nqV5hCMvi3EKXCq8EOVej2w
 ttQq8UmOT/l5Wlh3ZFTyIKo5jponRawoIc/qlxsGIeOMmvINGZ78mcbWtFH2X32Hl3hQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS7oI-0004yE-DO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nWhD6NqGWQeaAF9weLMiDIdx5fT308tj+4gRK0S0CiQ=; b=NUzqHve8UC+23s3rUSjCC3Rq5Z
 KvOYLnH5KIouDOlaogy7L0fmNrUmy3yijttvpBzJWa34SwE6Ts5eOS5uZ1zQ1kwMkiH0FCTME1B5v
 343TQK3949E+T+zXA3en4J0yTTU2Y5tU6fB5QuMbUJd/5ETZzIpFVCEHjbHjZalxiwm0udRHofEPu
 JoJ9lz+Twd7M0Ycq+jimrec5bxUKNGPtkxkW4SYh78xE5r/tNgL3P1R+4wRRh5mkSL2rn9+oLSsUi
 pm7o2iyAxQC9R6MV1khw1ig6MyNgg3P6JHfeaFj5IfJeeQlXPWtEWzFdtFA8ygTTVW300stpZHCo6
 RoL2an7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wS7o6-00000003PEM-0j4G;
 Wed, 27 May 2026 06:31:58 +0000
Date: Tue, 26 May 2026 23:31:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Message-ID: <ahaP3p1ZTBIDAuhH@infradead.org>
References: <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <ahYWKH9-ybDlZuJd@google.com>
 <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wS7oI-0004yE-DO
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 Akilesh Kailash <akailash@google.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 26, 2026 at 08:21:43PM -0500, Theodore Tso wrote:
> The bottom line is if it's right after device boot, there are simple
> techniques that don't require hacking up the f2fs.  But in the
> demand-loaded case, calling compact_memory() is the last thing you'll
> want to do.  You're better either asking the mm to allocate the 4k
> pages, or do whatever compaction it can do to just free up 2GB worth
> of folios.  (Calling compact_memory() is overkill, and only makes
> sense in the context of benchmark / proof of concept demo.)

Or have a lot of clean pagecache using higher order folios that can
you can instantly reclaim?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
