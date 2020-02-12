Return-Path: <SRS0=+fGn=4A=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91047C2BA83
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:13:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F792073C;
	Wed, 12 Feb 2020 18:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="OYAEYgSR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dUCQ5O6e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kfnqaCCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F792073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j1wW6-0000eK-11; Wed, 12 Feb 2020 18:13:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+0636056a4212f82c3197+6016+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j1wW4-0000eB-Cf
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Feb 2020 18:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=exbKuTmB3BypNRUAcUVWw3Jh2/ptObaFi+H8fsEcxKE=; b=OYAEYgSRI4HC+QwnJkvBE9C8P2
 O/7JEOQHMDZ9OSz+BIA2LRw+0/dtNyCsLir4EJ+n0XD6cBEMdrWblcO2/GHgoyarPQDGp5wkDsCtQ
 jh0xovhGUyB5h0NETYpaK8bEhaWaZx2Bqcb3D4Uy4vg495qgOMzAVbF2Ke0ZqcYcSt4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=exbKuTmB3BypNRUAcUVWw3Jh2/ptObaFi+H8fsEcxKE=; b=dUCQ5O6eNjOxlEr/5h7NCp3FcX
 gA9ttKzsCeID+y0PAOY24cNSDSn9/1DW0wodKcLLJeX2kRJNXdvOCPhygD/7Mvu1kGKFGOzeo2H5X
 2oCzRstr/MgQqvYg0fOh+pQ4CFdovwQoqkzyQm+TzMAKnh4Umras+LblnYUt70IETXAc=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j1wW3-001WeD-7I
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 12 Feb 2020 18:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=exbKuTmB3BypNRUAcUVWw3Jh2/ptObaFi+H8fsEcxKE=; b=kfnqaCCT7YWX4nBMwDXdhFflTO
 GchhyNM5fm8RyKBM+/aj2h5Cuth7F4gsvGUO233CoUs/Jc9bqjOOO2tU2zM+ICd06jmGSkWZW4I/k
 xootPKLT7JvmY10K4LD5LdaVgfHHT0ofNUFoWq5s1wu7sfUCSds7gSMPkAVFGx2h9sDVnMvdbrMha
 UadJrwNB6Pd5MIPsfdkJ9ZHiYkkYTQ7iAJMXyfRnyQMqUJ9hPSorBBhCtwBP1k4l7m7L1NJA23Q6E
 DLvyHLGiztgzg8AQ6OWjDLFqLL/ytC981/NRCevE1vjEixMjTUWdlDnFOHo9gKGpBWg4t+WsmRGt9
 Qmymo12A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j1wVu-0002f2-F4; Wed, 12 Feb 2020 18:13:30 +0000
Date: Wed, 12 Feb 2020 10:13:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200212181330.GB9756@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-3-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200211010348.6872-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j1wW3-001WeD-7I
Subject: Re: [f2fs-dev] [PATCH v5 02/13] mm: Ignore return value of
 ->readpages
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

On Mon, Feb 10, 2020 at 05:03:37PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We used to assign the return value to a variable, which we then ignored.
> Remove the pretence of caring.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
