Return-Path: <SRS0=hT/8=4M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C52C38BFF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:37:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8864A21556;
	Mon, 24 Feb 2020 21:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="G3ZIU0sG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KfkJBryz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X8jrNEtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8864A21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j6LPp-0004xQ-61; Mon, 24 Feb 2020 21:37:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+fd4c774fa746ae91f5d1+6028+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j6LPn-0004x7-8u
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 21:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nX5VslAb9aYoRq0onwDHGJTJ67RlRcQ5wURtwjQgsok=; b=G3ZIU0sG9Vy20/JYEFx5XOfM9c
 bmw9FIAlTnXycknxACtuBpCFXC5nDZJK56rWKnYotP1rQZZQEcRIuqUqbQHP/Vbqx1Tupw7qUWmvt
 Kk1OhC7h3boZWIwD54/3m55A3+u8g/og2Wyr+iVEpp5ToDipGNLDkIh3FpfuH/EXlU74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nX5VslAb9aYoRq0onwDHGJTJ67RlRcQ5wURtwjQgsok=; b=KfkJBryzvjVioQVOJNSzVmdMVW
 9Ksmbm/CmkUfY3Vm0dX8gw8zY9ZdMwrCjOAX2C75mitbRoNg5/shomXK7SXMEF+Uy43fzcQGVy2Cg
 KpDBjE0jqjuvRmzy/EMSshBRO1dyvbgVUlbWpSpdTGzE+ISfpcKMRBLCTbQ0zVzE62XY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j6LPl-00FRj0-Df
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 21:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nX5VslAb9aYoRq0onwDHGJTJ67RlRcQ5wURtwjQgsok=; b=X8jrNEtXW298x3gA4/IDu/10Ny
 1ViCr7MxaOAVAjf+Zay51p9ufyNNeifHWxRgfL7eg/f6/9IGK8yNGMSs5mcRTo4GJfD5Oha50wx9X
 RoWUPQWYyRqvieERC9AWCihjU8tiBSlNZrctgEXFVEsQK7++p7wCg2aKVkS1CvjpiIwt9Ve8v+vRf
 D7/k++eIpijcp7XpCFPS+rlPj4VcVAUYvWzvnFBPmlk7Gt3lfaziHMCRv1B2QDfMJQkNJcugtekWK
 xrNSMkT+9Wb9QLRQJEabeqGGgvvnwCrUQqnrBXNB6655cSxapzIfAzu7myQkdoaNjUxv8uHXRfmBc
 zL8XhDxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6LPe-0005je-RR; Mon, 24 Feb 2020 21:37:14 +0000
Date: Mon, 24 Feb 2020 13:37:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200224213714.GE13895@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-9-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j6LPl-00FRj0-Df
Subject: Re: [f2fs-dev] [PATCH v7 08/24] mm: Remove 'page_offset' from
 readahead loop
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

On Wed, Feb 19, 2020 at 01:00:47PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Replace the page_offset variable with 'index + i'.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
