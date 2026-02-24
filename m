Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAE5F3C991
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pkaYjNpcskouCDxCDeUwf3/UBMSt4DhH/0v4oXz/76E=; b=JFQg6fYd5p1ShQkr2D7NYW5rCP
	WRkTdq8w9HA10xNO2OM4XIkZdHw716lgt8D6MutC7M2jvZApoVIEUKbIB1eIfl4jopJGOJK9cvggc
	8Ki5LEIZkpLa53W3XKWWfb2AsQvdljFuM2vgfXPh6Y8yGSRhaaGku8D7HsLJubKf01WU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vuuP8-0001FV-49;
	Tue, 24 Feb 2026 15:32:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1vuuP6-0001FP-7T
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 15:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LCrtRQLNlXJ2+RMPTomjO9zvY5ULKnNAP+Rx2oaqJTY=; b=WGee/aooqJIxiwcy2wBabb/Eu1
 uyhw/xLG16AF37mVvayQARULoeXjt10BHIJ1HYIp1dIxlDJHkAx3VOcJTxI0TJ1j3Siuwxrw/PLl6
 b5Vmk+//ez++XhRbiy/bcDWLtna8/tM+IQdWcKtADfvnhmsdjPlMU175XHhoHXmvNjqs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LCrtRQLNlXJ2+RMPTomjO9zvY5ULKnNAP+Rx2oaqJTY=; b=W5+ykbzXmWO5vOzK2xTs+U/NB5
 ZkDRjD8pQ9MKeuVXjB88QzTi5k+k1OgPk32a9bYZ/cv7sD0f9JiaFNxGjH6ZVOjtbg5aeFQ3A2vuC
 52JL4Kuj64mGFlHtfp6cpBC0oT9Plj9KBeYqdq54iys1o9YbRU2yK8rjfV6+jWOvcusM=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vuuP5-0004hE-NK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 15:32:52 +0000
Received: from macsyma.thunk.org (pool-173-48-111-182.bstnma.fios.verizon.net
 [173.48.111.182]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61OFWSmh014511
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Feb 2026 10:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1771947151; bh=LCrtRQLNlXJ2+RMPTomjO9zvY5ULKnNAP+Rx2oaqJTY=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=iaInRZKzaFmwbD0wNIxEZWWMO9hrAn0VLeTMlSnaY8bAvNdERtlqSNJqsF2bJHGuX
 QFTUQ40h14UmMAB+ncnFFpT0n19A1u3+PcUUoB1Kvo7YBT1cJo6vxIluKw5TCdWwnQ
 CrPTx0zFGW8olNTbS6tCe7DuT9RnRtPPrbW83S4LbIRrCk6L537bh/PH5bXvI4LNZl
 5vv1Kp2MunTQo7PLw27xom0Qf25XsuYY+gdpSJSqBIpiHvqG+5D+UYF91Elf/qy57I
 lVz6s9o8sopQ3AAZbLd9bafx/4ccNWwFICzmU70GxeSbGtysyQjvMGflGIkzopWr5d
 wesJycyrLZSMw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
 id 712BC59B49DC; Tue, 24 Feb 2026 10:32:28 -0500 (EST)
Date: Tue, 24 Feb 2026 10:32:28 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260224153228.GC16846@macsyma-wired.lan>
References: <20260221204525.30426-1-ebiggers@kernel.org>
 <20260224145156.GA13173@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260224145156.GA13173@lst.de>
X-Headers-End: 1vuuP5-0004hE-NK
Subject: Re: [f2fs-dev] [PATCH] fsverity: add dependency on 64K or smaller
 pages
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Feb 24, 2026 at 03:51:56PM +0100, Christoph Hellwig wrote:
> Do we want to throw in the towel here for the forseable future and if we
> ever need to support fsverity on > 64k page size just do a on-disk
> version rev?
> 
> Because if so we could just simply the pending xfs fsverity support to
> drop all the offset adjustment and simplify it a lot..

I wholeheartedly agree.  Especially given the benefit of large folios,
increasing the base page size beyond 64k has enough downsides without
compelling upsides that can't be achieved via other means, I'm highly
skeptical that page sizes > 64k is going to be appealing for most
system designers.  So trying to design in support for this possibility
in fsverrity is not worth it.

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
