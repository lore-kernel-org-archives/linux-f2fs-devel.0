Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDE2C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jun 2022 08:07:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nyqj5-0001oc-Gu; Wed, 08 Jun 2022 08:07:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+ba9ae8ab3d8ecaf97ba4+6863+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nyqj4-0001oW-9C
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jun 2022 08:07:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FHe9QWtfqKLPf3liBV9b4YYysNdz6TJZPv2RlJSFNxo=; b=kHQpC9LElVWi9Vpa8O0DcuU42X
 PsvpYPabFvS26rp1R0NzBV3HliAfbTL3uD1MrHrQio0MHdzXcKFyRMfx9Qx33qu32b6b0U4YLsHte
 TM0sfh4unjvGshvL8mRQXEvOa0wTwRpveTKPDzqIhG1BDI/apXLiP2fCvr7tKneI2NYo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FHe9QWtfqKLPf3liBV9b4YYysNdz6TJZPv2RlJSFNxo=; b=e64ymClBN6QBYl3HP+Fc/LI+lb
 dKg5dJOVDy0CTEodcM6c215j4httbKyYquVnmRnpgzqMJDHnE/JpOqWiG9x6p9qp0fiLnOpoqIxwi
 +5H4Ar7LfUdIhOuQyjH+2zZkAiwMt4j0zNAO/StEHcTcvq+nfemwlM4AWdCzeliF5TSQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nyqj4-009aCe-Dy
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jun 2022 08:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FHe9QWtfqKLPf3liBV9b4YYysNdz6TJZPv2RlJSFNxo=; b=rE8eAy8BnhO/uz/cOPnx8UhjAN
 oMvGKU56FernoImgpfLlk3BQh/CFcJRA4pawK69Hf0XfMgy7iNdxfJX1EO/aZC0ILffliqDfLrcv1
 mK9DeJH7OGatXD2YCTu+PsPPGT0W70LT5ii/RbRa1Jdfc1XZU8eOfnFRyejMASzpxhKqQnWsphP9b
 T+QQZKswmqu4Y84dTJy0wevs5sCY40Lii8Swq45uCU+6S053j8cyNLCKL3jVIYDAQThxi54ACP5g+
 ft1Jg5kECbmCdG40aX933ZgsA1UwamOP4geUlHX/USfvpuQaaqivpAgnSN89ea/zPtqMOGHXjCFx6
 OVoTk0Lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyqiy-00BpKC-SU; Wed, 08 Jun 2022 08:07:32 +0000
Date: Wed, 8 Jun 2022 01:07:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <YqBYxNPu3tLiN5kI@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-9-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220605193854.2371230-9-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nyqj4-009aCe-Dy
Subject: Re: [f2fs-dev] [PATCH 08/10] vmscan: Add
 check_move_unevictable_folios()
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
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jun 05, 2022 at 08:38:52PM +0100, Matthew Wilcox (Oracle) wrote:
> Change the guts of check_move_unevictable_pages() over to use folios
> and add check_move_unevictable_pages() as a wrapper.

The changes here look fine, but please also add patches for converting
the two callers (which looks mostly trivial to me).



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
