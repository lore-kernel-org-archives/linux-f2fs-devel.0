Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E7AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Jul 2022 05:15:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oDJ5s-0004sq-UR; Mon, 18 Jul 2022 05:14:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+3efd80ad8b751f8326f0+6903+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1oDJ5q-0004sk-Gg
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jul 2022 05:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aW5Ij3XO4BWUbbucP/uRK4gxCB
 HzjjNX6nMl0+WYnUotf3qVuAd91G0xrSa1ljWndldhWkWy0LK33RNE25LMhJsFWa4Mr+0Q6kbDXZm
 LEhpxOHF64PJM9MlwOYpiHy79zSIXPadegZIEIXAsm3Jj6C97VTh/hEDjpKEwNqoGTME=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=IK1OoUma4G2a/wb4EWqSG0dScx
 by3OeacbjWjGsH2czcZQ4QjsOOLUZ6oL4XRBccqxsxYQV7aRRQMBwfF0Az2kA03MjSo00Y87TwsY/
 ClhM8beuIaX+jHKj8APQxivYG+eREDk6iO1Qk03cSrBYiL3mVSqFUPn1rZOmEcAKtO5c=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oDJ5p-002NQD-H5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jul 2022 05:14:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MpWfwnFI4L7u6BjQmafCf5yMR6
 98EDGXQeXwnfR7fOTAApIbdG89qe5f0WwILst9u7UbWxJPk3EsB9Zbj5Cps8+6+8hNAbTFFiJI78O
 rfMsjRD54GNNCIWZbhRT11GsmAvfPn1sutn45qW0ypU5FwyYRC6zKSa4eqDtMpWZ0k3q/H6+a3IFX
 syNLKG0CRy57ubKeA44YAldh4FqUqVY2CIIkzBwkEgSfcy3wYCG8d/CpAuekcINu2f0IA/nDJgLuS
 KuMPv4V1rlJlbPKSQVXno2yp1STIPB18WhZg003a/I/b1IMR4gflnlCTnY0RqzRdxUYWQiHHeeY72
 y5bC+g2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oDJ5W-00B0lT-Lj; Mon, 18 Jul 2022 05:14:34 +0000
Date: Sun, 17 Jul 2022 22:14:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Message-ID: <YtTsOpjbEgpZbgKA@infradead.org>
References: <20220717083613.3861-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220717083613.3861-1-fmdefrancesco@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1oDJ5p-002NQD-H5
Subject: Re: [f2fs-dev] [PATCH] f2fs: Delete f2fs_copy_page() and replace
 with memcpy_page()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, Nick Terrell <terrelln@fb.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
