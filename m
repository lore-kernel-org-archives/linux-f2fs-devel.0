Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8F2C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jun 2022 21:18:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nzm14-0000Bl-OJ; Fri, 10 Jun 2022 21:18:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <willy@infradead.org>) id 1nzm12-0000BR-KG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jun 2022 21:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dPCOWM5CyDEIdIuBSxjePp4f8SSu/SKCJnmsXTUdDp0=; b=fSD302bkf2VotQjHrdyj1JnrgB
 F7+l4tXRjBGLNe9WEsZpiUhXKqVA9CnudMsSasEWCTPS+fJKud8scLFh9cgJpO2cf3Ac4Z2ZUa3rH
 zuNOIbHP9/LqSFFX6mw5tGWIzt7HOztk/o2CnYNJ/EA+uKLvCsdBBchU3JAUzTSYweqE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dPCOWM5CyDEIdIuBSxjePp4f8SSu/SKCJnmsXTUdDp0=; b=f74siJPKDZECnZJwrbCnctVGNH
 XRicI7cfFDR6tVB5mhw770ya1mP7AfNitIViDzBCyUU5cCScTf9OdseLNNVSncx/yfiVcYnrtIQUh
 Apq1O1kBGPozJl4ROBGf165WE/FIUOEjdkeG27xOXg1a3ne20OfNXVVkcmpDtlWWiZN0=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nzm0y-00EFnx-2f
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jun 2022 21:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dPCOWM5CyDEIdIuBSxjePp4f8SSu/SKCJnmsXTUdDp0=; b=H/uguj+Wl5DQo9Vix4WTb9P9Qz
 L3+C24pFO0kvbIu1KKcP4oVLAW0MPkjH36cSK+5oKXA61lH8Ik4WuTBYal6HxocDDl+IvIKG4CCwL
 qMYlFEtD8mXy6yOt5Sgb3+UVlhpMqyWoPpvjDn3H3qAjkbV7cG6coeM3c8vmcNboFD8Xoap0GQfCH
 198oRccDnDnojUeQZLgFD8CTZuFsqMSEqnlQmY48fZ9D/l9Bs8bop7G9eLDZqxL2TbtpRPL1eiwtg
 Fc6e9lthrSLvnei2DS7h37o1aENF/y3X0CXCwJvu6vkLxR7ewRCMntvOhjp1rS4ybHxIfs6En+aMm
 PTXk3bZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nzm0e-00El5e-Cd; Fri, 10 Jun 2022 21:17:36 +0000
Date: Fri, 10 Jun 2022 22:17:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Message-ID: <YqO08Dsq8ZcAcWDQ@casper.infradead.org>
References: <20220605193854.2371230-7-willy@infradead.org>
 <20220610155205.3111213-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220610155205.3111213-1-sumanthk@linux.ibm.com>
X-Headers-End: 1nzm0y-00EFnx-2f
Subject: Re: [f2fs-dev] [PATCH 06/10] hugetlbfs: Convert
 remove_inode_hugepages() to use filemap_get_folios()
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
Cc: linux-nilfs@vger.kernel.org, gor@linux.ibm.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 gerald.schaefer@linux.ibm.com, linux-ext4@vger.kernel.org,
 agordeev@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 10, 2022 at 05:52:05PM +0200, Sumanth Korikkar wrote:
> To reproduce:
> * clone libhugetlbfs:
> * Execute, PATH=$PATH:"obj64/" LD_LIBRARY_PATH=../obj64/ alloc-instantiate-race shared

... it's a lot harder to set up hugetlb than that ...

anyway, i figured it out without being able to run the reproducer.

Can you try this?

diff --git a/mm/filemap.c b/mm/filemap.c
index a30587f2e598..8ef861297ffb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2160,7 +2160,11 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		if (xa_is_value(folio))
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
-			*start = folio->index + folio_nr_pages(folio);
+			unsigned long nr = folio_nr_pages(folio);
+
+			if (folio_test_hugetlb(folio))
+				nr = 1;
+			*start = folio->index + nr;
 			goto out;
 		}
 	}


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
