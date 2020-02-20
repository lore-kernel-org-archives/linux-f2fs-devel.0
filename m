Return-Path: <SRS0=SnCE=4I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77B3C11D0C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:02:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F756206F4;
	Thu, 20 Feb 2020 20:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lVGGmUzk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QpgWFKUq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/Ab8+bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F756206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4s1X-0004Je-AX; Thu, 20 Feb 2020 20:02:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+d8ceb162cb84e4d8f427+6024+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j4s1U-0004JD-Jf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Feb 2020 20:02:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=asXjJUPyTxLf/fjaD73hG4T2BQQMjNwUve1mlt++5Bg=; b=lVGGmUzklqq/UcVOmWLQFZQcGt
 7mSdxt/VJK+5Sqn3kz8PVmChBWIrACe/vuMeR7ZKhRHo9H7YT/7NumiDBRdm9v4BWh02FRZTZ/OfQ
 7ALIk0R9bKpZfAA+uzU+dtfHUNb25GkhNTwRsIKxqVRmdi7j6jiAugTYKoqwpnAUqiX4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=asXjJUPyTxLf/fjaD73hG4T2BQQMjNwUve1mlt++5Bg=; b=QpgWFKUqZ7iub609gUaLq6ZcRo
 nXbXPf70vyAMx56iPpYa4Ku8UHzSaZ64d5fXwretzq+0SiYZa/DQFxjEl2q5oCufq7AA62fiG491Q
 dx89wuxoqmLmWcose8qoOLWkuXydmiubclV074Hn51Aso9KAZEr3UcppgH+lbThsHiWk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j4s1T-00C9cy-LX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Feb 2020 20:02:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=asXjJUPyTxLf/fjaD73hG4T2BQQMjNwUve1mlt++5Bg=; b=I/Ab8+bwJavMuSdF6A7yoLoxpl
 I80eOjHHrc7YW4s1mRM3GXAWV63YYUGG6kYuZAbhKMD7o7inowQ7wkdtEhk0CShSQle+pUHSJSQ3R
 X5Ie4ceE4nw5O60QIoKVy+Nx7nLUPwXo7HXGU5sNQ/MNv7k7CTW5cYA2mGffcLjnMuopklxIrnEb5
 zXaF3Q4w6YT3XY3kUH+syaFGM+K+jajsEL8N7w0LjXwXSkPM4zCg+dqrmYKzt+1rJwJrKO5ulxHRb
 Yx2SJUtD5uEs/JDzQY6ckw9PLSkFVwKmtv7afz08IkWKilgFHxNduTmfFUEZJ2ZFaKnIsglqiJ94N
 iYbQPz8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4o3B-0005FU-UO; Thu, 20 Feb 2020 15:47:41 +0000
Date: Thu, 20 Feb 2020 07:47:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200220154741.GB19577@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-22-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j4s1T-00C9cy-LX
Subject: Re: [f2fs-dev] [PATCH v7 21/24] iomap: Restructure
 iomap_readpages_actor
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

On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By putting the 'have we reached the end of the page' condition at the end
> of the loop instead of the beginning, we can remove the 'submit the last
> page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> didn't return 0, which would lead to an endless loop.

I'm obviously biassed a I wrote the original code, but I find the new
very much harder to understand (not that the previous one was easy, this
is tricky code..).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
