Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E22C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 06:55:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCyBw-00077e-Ge; Sun, 17 Jul 2022 06:55:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+15f41497fdf043877c84+6902+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1oCyBu-00077Y-ER
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 06:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X4YZxvL1EUK5zhn+ks8Yss/ZUVWfxwbXjHz41gAwFVw=; b=jiiZ+s8A4+1nbGyAKkOWwqohx0
 oEzkWdIFXAljLLN6iWxw2yaOFMk7VO4T9MyQkK5dZWHs1SmP/SeVghE1U2jq/0e+BEf+MyWd6B0G9
 KDC6AIvgOZpT6c55SLbTAgwRykTEC25q+2c3/8MDEv1yw3tFzavNxQc/1elVPBTqGMAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X4YZxvL1EUK5zhn+ks8Yss/ZUVWfxwbXjHz41gAwFVw=; b=gKzzaa9ENhaYU+lrH0lSBDtNpX
 ij6FuNcEwn7gJo87nBqV+yxYRKFEQlZiPHmJJ7LJ4qBYkhEq0Brvxrvp4bs5SE6tlR/+6QiIe7gTp
 EuC3TKn0zbjo6CV45Wl47Rfg6okGY/4dURJ/USjj3Y45R4GG6KMjosa0d0sI4VKOfu/M=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oCyBo-001c0O-3f
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 06:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=X4YZxvL1EUK5zhn+ks8Yss/ZUVWfxwbXjHz41gAwFVw=; b=JX8CEv3QH/31axHpg2Wm9uMOla
 FHVr5hLJ6aBBuPRYA0tMoC3JboIa0n7Am8wYtpolZ28OEyc1+FP+vSZgixrJC1z9V7uAF7VP65Nqn
 6oBkQmkl8WCnf/HCW9aagifKhsFRxcmMwY/qVtjRyxAaVP52XSWpGzKuPOiDo9dS2IafW2nH0hPz4
 WrCqRJpXQWtkpwv925R6W1McIWExRNgrysnz4IIXAk//Q6Sa1GbA3yO5r7RkwCe8OO2ogrI5h8VDb
 gdCGUlF5CPaV1q0E2E6dCiUIRZlnfwBqYC721FOnGzRe/7O/gQhyq7vNAWXddShgxx0Uz6KDFr3Y5
 H+GpUeKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oCyBU-005PCY-Gr; Sun, 17 Jul 2022 06:55:20 +0000
Date: Sat, 16 Jul 2022 23:55:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Message-ID: <YtOyWOKFN9ramUyb@infradead.org>
References: <20220716204353.22049-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220716204353.22049-1-fmdefrancesco@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1oCyBo-001c0O-3f
Subject: Re: [f2fs-dev] [PATCH] f2fs: Use memcpy_page() in f2fs_copy_page()
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
 Nick Terrell <terrelln@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 16, 2022 at 10:43:53PM +0200, Fabio M. De Francesco wrote:
>  static inline void f2fs_copy_page(struct page *src, struct page *dst)
>  {
> -	char *src_kaddr = kmap(src);
> -	char *dst_kaddr = kmap(dst);
>  
> -	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
> -	kunmap(dst);
> -	kunmap(src);
> +	memcpy_page(dst, 0, src, 0, PAGE_SIZE);

Please remove f2fs_copy_page entirely and open code this in the only
caller.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
