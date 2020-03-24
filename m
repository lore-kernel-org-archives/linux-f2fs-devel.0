Return-Path: <SRS0=nR8U=5J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FF3C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2020 08:38:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1447020724;
	Tue, 24 Mar 2020 08:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XvKqzTpz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="h7Qm8y+e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFzRIMRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1447020724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGf4e-0002Xc-HP; Tue, 24 Mar 2020 08:38:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+5af6361f56b5afa65be5+6057+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jGf4c-0002XP-RD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 08:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w0tf+LzLJgcsDnMH9vZGmgZTed6vh6jn/5MMwqLl++w=; b=XvKqzTpzYLGGhDYIorriSsHMmn
 U+xj7D0+Zj8hcH1AMOb2ePrj7hUh0nv+EnvQb0F0FjM3P9sNrSbQQGuyOE38yVu+OWNCoWDYZ2Y5S
 c/rEKoxR9I/c3kCNGSzHJ3O9pt6KYJXIEL8OOpUdacUGFZKIujZzs8cNBCg05a/2fKjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w0tf+LzLJgcsDnMH9vZGmgZTed6vh6jn/5MMwqLl++w=; b=h7Qm8y+efrBkTIUXCIkMFJsxw6
 9Sd36HRFi8WrGpVX+YOSRx7MoQN4Kp7YBcBoyXGxo9nHhVxkJMG3pNAjPixoylud4dv2BEjXuowsI
 OZsb4dCM7ZlY4Lx8wo6fnv15Wyf+k9XsvxISlYyIuUrWCWy0MBEqsMvecEKt/f1co4HM=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGf4b-001lR2-Ex
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 08:38:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=w0tf+LzLJgcsDnMH9vZGmgZTed6vh6jn/5MMwqLl++w=; b=IFzRIMRL9LS1VQlsAqCfwy+lvc
 a59rPM7MkWSfUYSOy84zBKgv1fR8cWlMLg1qWqcXZPMfObCwn/XHHNDlzD3Yiz2EICORO5Ksw2gzQ
 ER+Q12eJvjfUp/BZsuyRrZW+Y3cJO/m0CzGzidqSucoDuWOOuUrVBGoWR900mfu43SuaFxnV1B5gF
 RRqozVgDapH3/ealfBN7P+DO5Y1VXniV9PPFfXxQ99NjvGuZ7UgZDEc+BocOz+yIFT0e2NfwQtYFV
 R5dX+/pCSuO0lCHde6rD9OUloG7icXWWS8HJ/ytpMJIsU6Xsps1swne+8uunIuqh++NeH16bts4iN
 fnIeJjSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jGf4R-00029L-74; Tue, 24 Mar 2020 08:37:59 +0000
Date: Tue, 24 Mar 2020 01:37:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20200324083759.GA32036@infradead.org>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
 <20200320025255.1705972-2-tytso@mit.edu>
 <20200323175838.GA7133@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200323175838.GA7133@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jGf4b-001lR2-Ex
Subject: Re: [f2fs-dev] [PATCH 2/2] writeback,
 xfs: call dirty_inode() with I_DIRTY_TIME_EXPIRED when appropriate
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Mar 23, 2020 at 01:58:38PM -0400, Theodore Y. Ts'o wrote:
> Christoph, Dave --- does this give you the notification that you were
> looking such that XFS could get the notification desired that it was
> the timestamps need to be written back?

I need to look at it in more detail as it seems convoluted.  Also the
order seems like you regress XFS in patch 1 and then fix it in patch 2?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
