Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DEFFCC9DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2026 08:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YumJijyFFyFS/AXXyBfx63kTkSBs51bV8am++fIiKEs=; b=YDkoicLTq4gH+oFecptccDeKss
	AiE7jF+Bbc2DAcR7Hb8LiVfMlz3i/m15M7EMjAc6UFL2Ovw8UQOYTKY4lQfZtwgEGaUxCmR8gk87n
	CtlmWdHXr3TqcD6PHbQ2d+k07JICDNsZ4hKlF5P0aPhac2uiILXbgO2q1ADsJffqECd0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzsix-00024s-9M;
	Tue, 10 Mar 2026 08:45:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vzsiw-00024m-MJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 08:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2GTo/UKEXmNc6/moESIzVvtsJWPxVqrpeu18Y9/uTE0=; b=VUBemvd8Clfa3zsPirhosHDn9n
 HN9WBzsZIf1Xt5LxhaMw6Ax+1DHt/yFRcV+V2o8w1uwrhZeg8LtzO6vQ9PawHPRqwdPqr1uCsjG+m
 v+6l2K6MBUVhqEgApW6MwELcoJXxf8P3bplIZxuxXIxb4vIW3uBJQM+f68oB+z5YSQMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2GTo/UKEXmNc6/moESIzVvtsJWPxVqrpeu18Y9/uTE0=; b=fZQDK1tIsuGYW7NOGurlJK3sVA
 P8LoRPpOvZmsFAkG28P6oCFr4glOw8AA8M74+qvajdeMYuLe7l7Mqe74YeXnAmMDQfovh1zynMZ7a
 /2L62vs3kziZqfQpqcUz9FDyENp8O0UHIu/B9RM1R12ijuULs/k4PRhn5i4Oe+dQyKvA=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vzsiw-0008OT-WF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 08:45:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CA0EC68D07; Tue, 10 Mar 2026 09:45:42 +0100 (CET)
Date: Tue, 10 Mar 2026 09:45:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260310084542.GC17112@lst.de>
References: <20260309192355.176980-1-aalbersh@kernel.org>
 <20260309192355.176980-10-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260309192355.176980-10-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vzsiw-0008OT-WF
Subject: Re: [f2fs-dev] [PATCH v4 09/25] iomap: issue readahead for fsverity
 merkle tree
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Mar 09, 2026 at 08:23:24PM +0100, Andrey Albershteyn wrote:
> Issue reading of fsverity merkle tree on the fsverity inodes. This way
> metadata will be available at I/O completion time.

The change itself looks good, but we'll also need this for
iomap_readahead and not just iomap_read_folio.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
