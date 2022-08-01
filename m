Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1ACC19F2C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Aug 2022 18:23:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oIa4f-00038j-5T; Mon, 01 Aug 2022 18:23:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+ddfeeeb461a4d68a1acf+6917+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1oIa4c-00038c-OV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Aug 2022 18:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gPdrcUpLAcK6oYiMvTryLalqWjaKI86cW7a7OxyjYBc=; b=Reg4bcevZJfGuzc7M4//rsjFO4
 wPZpyQ8mLc4UU1rH45tcvtpysj8xGg8UhBn/jwWh3NfEKRAMFje44UiGQnR0TYJPoUHbh8guzoZDK
 Py+yStqIFmcAmNrmJPlN96pyXTFCKrIibY20lwHAO1pkpFLd8bDMd6hSA0LZ0r//snWI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gPdrcUpLAcK6oYiMvTryLalqWjaKI86cW7a7OxyjYBc=; b=EQvIvmywyVqKGJvpe2pQ/r5SLi
 ePFsmT5H03r/X77e3Ss0N160g0FX5UkrIxjMDiWmoo3W11iBrBqq+V+tJmTDu0fhY1Th9r5n80ivD
 FDOIZL6Z9e+HfoR/Dwtsf4Nrm6zVGXGUIbMslsmKEmjubcg74nHs9FklqVgZz7xPIxQw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oIa4X-00HZNz-Jv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Aug 2022 18:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=gPdrcUpLAcK6oYiMvTryLalqWjaKI86cW7a7OxyjYBc=; b=B5vl6MV01f/2wsZuU83jCIsej1
 U299QIo1COaVF7aXM9uJlLZiiGM0UvF8xSkDc7PnV0FKYOwLUtgucDSqkdxayzPd66P0kl8xXWV3G
 pz/AKuSK30hVgEO8cqKR5A7M1zGlUADU2IvkTOSiILaS+avAYlubQ+41FXmq5ILrVNK6q2BtlPd6e
 3OIbmSDROAXhg/b+u1xyQw2UKzpjtB5XuLvzeC5P+UTmJ3CkKSwl9zI61UMd+CYrroe+CGN9TOugy
 otP9rE4j0YeT5fkj99FRn3tNsPQkCyU3BXtGNOYxXCA5y2FHKMiF8vGFaH5LvsvHZ9hwSUYVOUjyc
 XWNbuFlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oIa4E-008sGW-NW; Mon, 01 Aug 2022 18:23:02 +0000
Date: Mon, 1 Aug 2022 11:23:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: studentxswpy@163.com
Message-ID: <YugaBtQcoR4XhXiQ@infradead.org>
References: <20220801092202.3134668-1-studentxswpy@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220801092202.3134668-1-studentxswpy@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1oIa4X-00HZNz-Jv
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Replace kmalloc() with
 f2fs_kmalloc
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
Cc: Hacash Robot <hacashRobot@santino.com>, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 01, 2022 at 05:22:02PM +0800, studentxswpy@163.com wrote:
> From: Xie Shaowen <studentxswpy@163.com>
> 
> replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.

For that removing f2fs_kmalloc entirely would be way better.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
