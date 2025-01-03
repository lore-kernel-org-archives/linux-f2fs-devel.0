Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F46E77188
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jan 2025 09:24:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tTdux-0003Nn-7J;
	Fri, 03 Jan 2025 09:24:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+c62633f7393a16751b0b+7803+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1tTduw-0003Nh-JE for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Jan 2025 09:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=etzicS1truGgMexfFfj9wDflIXJ9ASpBbjVMPUkz/BY=; b=BsoismcrIuo1J/Hub1q0ckObNk
 3cPFAwylzA4jPmFBS7z+I9/KHv5ykV7RbiXabV/CBGmuchUEKl5Z0ONI2oKSU40G49nfpKD/9rTW2
 fGdRx0FJLXi5IEDAcFbz+0MGHRTwqzL/ZCPvuE8bhZuSY6wz9YAZGRwdAh85bH49Rhi8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=etzicS1truGgMexfFfj9wDflIXJ9ASpBbjVMPUkz/BY=; b=BQQogi46DG6xJs49kh83k40HAA
 WtMC1d4gGe1VF42Xj/UpdOBpmmRPsbNwfAgzlkNYt8LGJNZOEXsfJgimPw+u8PmNGnae2h4mLRZ1V
 rGnOL4t40ZkR+PQF9hBsE3RWxk+UgAus9SYj9BfUmdA8+RzriRQ5fb0204FUSwzNZUj0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tTduu-00044g-Ng for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Jan 2025 09:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=etzicS1truGgMexfFfj9wDflIXJ9ASpBbjVMPUkz/BY=; b=esMlGAM2rkyVSfeBb0R45WFdSf
 fqwKO3yTxFtLE6lRELu0AVfJf7lF+MISvwhBkTg5vilGqqmDgwXVoyXmmqfagZ39HlLR4KQ7cHn1Y
 cJd68zOEjWlRV8mFqNqTb9yacCcuOYGScMRgDbsI/KJsJLq2BdYzBzOA8/jfvMZtZKqldvG9iFM3O
 CJm7i/OtDsFzpcOoO5rmjWit38rawfHIkx6ILifCp4o8DGyFuublNXjGuLOl1qg2yo4sNmZYM8SdR
 EpEhcGvSdlGQUisNhr+csfopasc10nUV8EZ0E2RDYEI+bamZdLGOMwrDBK0ZRvszSpCW/WH50RWWQ
 grhG0q9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tTduk-0000000CbDJ-0wg9; Fri, 03 Jan 2025 09:24:18 +0000
Date: Fri, 3 Jan 2025 01:24:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Z3eswqllW9LX2XMh@infradead.org>
References: <20241220172136.1028811-1-chullee@google.com>
 <Z2ketmZiWmUVddpt@infradead.org> <Z2mWf-pghAlHYJ8o@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z2mWf-pghAlHYJ8o@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1tTduu-00044g-Ng
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Introduce linear search for dentries
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Dec 23, 2024 at 04:57:35PM +0000, Jaegeuk Kim wrote:
> > That means you have really bad worst case behavior for negative lookups.
> > I don' think this is in any way a good idea.
> 
> No surprise. Please check:
> https://lore.kernel.org/lkml/Z1mzu4Eg6CPURra3@google.com/

Well, I think Linus finally gave in to revert the offending commit
after the usual case insensitivity rants?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
