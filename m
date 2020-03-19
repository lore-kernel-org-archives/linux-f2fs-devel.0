Return-Path: <SRS0=57LO=5E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E516C4332D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:20:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B21520739;
	Thu, 19 Mar 2020 10:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dDNm1fZT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ftlPzgYm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NPdqfWZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B21520739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jEsII-0000fg-9k; Thu, 19 Mar 2020 10:20:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+061b0704d8249feb4593+6052+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jEsIH-0000fR-AX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 10:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ntJd7dUM0sZh65THRmkRhW0Z2X4v3bgEZxiGC8V87b0=; b=dDNm1fZTOAoqQa9AYVL6mgQrrh
 1ZPyoUbkeaSOQC5zcRdhpJxdLbhhmvNJ9aUYpjzordxh1Ih5+ujfoID5O759SdqwwbYYdaCzjVKIW
 ThNJ6e0vrUHOORG7x7Waq16vo1OAGHAQ+CuP/8vPxaz55sb2Uuuo9YCOHPpqUrFgkZ5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ntJd7dUM0sZh65THRmkRhW0Z2X4v3bgEZxiGC8V87b0=; b=ftlPzgYmNVXnsGyRybm7fFpXvd
 5LpakRzOTfT3fmgkjz3Vo76vDO0sMTGoEVykSo3jDc2nu50/UiqXKbwAoOBCEwIlWGXTjKP4exM45
 G68vk7GzS8M6/Nm+cTPRVA8jPDsAgb0AxRv/xBpJyI47Ekw416ME6ZtKgNDWbPVO5aCA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jEsIF-008kMv-HD
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 10:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ntJd7dUM0sZh65THRmkRhW0Z2X4v3bgEZxiGC8V87b0=; b=NPdqfWZQW7ok68F99nZSWB4EiC
 iwCmPSaRU9YsXGBoldjY8WpNe37PvEZaNdwkLE3rFLqoiUMNDjhE9jkFexjMOPz/qBKa2JNDLDFP8
 VCNf4Go22JyscS7ePxXqYnql/ku5lrMhaj+rksUXN32t5uX1cDb8pk9Y+j4S57mNTCoQu8p15MGm4
 tmvLubpFBME8Ch87n5HtF2Js/k4HiXz0WzM3tA1LPvQSUfaPtAZdH/LH5uMVg8tpX7UiAEAEC7BxR
 aWnrppdR6e34JZBtLBap/q0wWpU1vRGQZFswa+BDAOmBy0xEFQYnQY5lnkECNrJkFChlgqQDEGnwO
 zjla2clQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jEsI2-0004IT-Ep; Thu, 19 Mar 2020 10:20:38 +0000
Date: Thu, 19 Mar 2020 03:20:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200319102038.GE3590@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jEsIF-008kMv-HD
Subject: Re: [f2fs-dev] [PATCH v8 00/25] Change readahead API
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Any plans to resend this with the little nitpicks fixed?  I'd love to
get this series into 5.7..


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
