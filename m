Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22938CD98CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0dZWrImqu+YNskFQAKyK6dvVd5WQ1GUGeI1DvGSsqew=; b=Fxxz7cLl575FpSVGq9G0+KRxL+
	BTPluPtvSp/5XeblQSHwFH/d7bXOmK0ehwg/ok8lUvMZEe3rnk/zzyVU3qryTTg6U6QpHfhM/OLKc
	lo65+kuP8fS8Sy6B51WnhPn5DJMLvvqIUuUN9V7ZP633ZQDTe78314Tgt2grwkCwqpCY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ766-0004hq-8b;
	Mon, 15 Jun 2026 13:11:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wZ764-0004hX-8h
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:11:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=22OPDW7KhThB14/q+lFGtgMht0sHtu3wYiNykt/72lE=; b=ZkdmX3FY381sqOeuWdAvcn4SLe
 QNXLAUKHGoTdbAqZonQ18tzV76YbXxwSro2ire+j3S4XUsoAkmLUUnYh/AUXVXNjtYbBafGT8qj6l
 ecEyvlBNF1HIZ7u5ENYivkO9BxoOjqtJdhuLSqJwYwSSQpvqbQF33Ys9FURYbaFoUN40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=22OPDW7KhThB14/q+lFGtgMht0sHtu3wYiNykt/72lE=; b=QYM4fIqV3NJmGpT/NIlUzp+D9L
 83PyVI7Vceox8VIrOLHHSiL3La1Od8W3jx9aHWpBjfgo5Jb/rruf2xURF/sOMhyCEyxYvudyJ0yAY
 60CxZlW780JDdKFg6wCYuMI5yrSv5ZBK6AzFbANJXCdmXETYaLdP8YksbOh09fWr/NCI=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ762-0006Y3-Vx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:11:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=22OPDW7KhThB14/q+lFGtgMht0sHtu3wYiNykt/72lE=; b=t0Rl33Ng8c6venO86OcqjUGCt5
 BylC6s8LtwUX+FLEm3XpGJ3ofTvcEkOS+pcKntZyDQ7eqhIAFMRd18ZJgNmcqBuMvMZ9CHMSrq+m1
 0HwvjnrSZG98SGNy/sJdBFHdrjeNCXWhPd/2cxH3S4CfcePNRZ1TCoSmgTVXeK3tbbAsmuoLtIcQE
 p3WLz9Nr5znkd74ir87ge7muf9Ltb+VMsTdImfDEthtqrr5r+Qvt04j1XjYtbv3EIFXEMbPIP7IQ0
 alEZgPoHnv1RPMMgtmdsDVw0lzP2icMBgBbIifvinCnN5catvSrAO81s58b4gRJdTK+ugD+AkSvlL
 ZYwivFQw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wZ75r-00000008qMG-0kAC;
 Mon, 15 Jun 2026 13:11:11 +0000
Date: Mon, 15 Jun 2026 14:11:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ai_57zkSdVklsPuw@casper.infradead.org>
References: <20260615130822.2576088-1-chao@kernel.org>
 <20260615130822.2576088-5-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615130822.2576088-5-chao@kernel.org>
X-Headers-End: 1wZ762-0006Y3-Vx
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: use fscrypt_finalize_bounce_page()
 for cleanup
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
Cc: Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 15, 2026 at 09:08:21PM +0800, Chao Yu wrote:
> No logic changes.

This seems like a step backwards.  We should be looking to convert to
a future fscrypt_finalize_bounce_folio(), if anything.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
