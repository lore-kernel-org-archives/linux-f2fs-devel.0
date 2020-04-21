Return-Path: <SRS0=/3/5=6F=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C5C54FCC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Apr 2020 05:42:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258A2214AF;
	Tue, 21 Apr 2020 05:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Y3/3uvh0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="DAuDqXIY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApJOmYR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258A2214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jQlft-0003GO-6O; Tue, 21 Apr 2020 05:42:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <akpm@linux-foundation.org>) id 1jQlfr-0003G8-Lu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Apr 2020 05:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yr6ssK8ab6EUKLC3DcpN5N3K3cf7FZNy+a4Rp1/y714=; b=Y3/3uvh0JpFcM1jpejuUi00Gtc
 avvxcvoSjwTL/klnt6JxIMY9ncJ2xP1NZ839eRebaTEyM1Q0A7pyv4+FKrDWoEPbrzFttRfhJ958i
 x4BkZsA9y7nTgZ555FnJwO0fmJfjcqpRUtfVInruM82ujso2doIj2DotfBxS62dm/liY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yr6ssK8ab6EUKLC3DcpN5N3K3cf7FZNy+a4Rp1/y714=; b=DAuDqXIYJS8UXrCTP0CBPvhKAN
 3ShWcc1zKg5PlXrkAmOqNDOlHkAHpz9TyksOPKc5KVGHp69W2OptAY7wfAzngluhWb5lSaT1fTV1S
 B8A6w2r/8d5FYIZij7z6llYuHi0zDH0Rrh6BCgPI8ZtLp9GoV0xjVqWciJiW89mLvvaU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jQlfq-00863U-Fl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Apr 2020 05:42:23 +0000
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7544A2084D;
 Tue, 21 Apr 2020 05:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587447732;
 bh=2gulgVkFfAjn3Pl1PNqXRXmkM/QzduOVT11dMu8o86o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ApJOmYR1uYAyNlSBQToll/A86aHlF3kQ/tdWHawXyGpKjOxTqiRWCqHSR3WazJzIA
 4L+nLEixqzeyYNqXfuV8TjK7idDUh5mHndFGgD9WMc/H8gSw+Vy/J9jJ49qwecfb3F
 M7IdSAdFh4D9we0/ZFSI3sw35uAquW5tJmZTokec=
Date: Mon, 20 Apr 2020 22:42:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Message-Id: <20200420224210.dff005bc62957a4d81d58226@linux-foundation.org>
In-Reply-To: <20200414150233.24495-20-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-20-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1jQlfq-00863U-Fl
Subject: Re: [f2fs-dev] [PATCH v11 19/25] erofs: Convert compressed files
 from readpages to readahead
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, 14 Apr 2020 08:02:27 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> 
> Use the new readahead operation in erofs.
> 

Well this is exciting.

fs/erofs/data.c: In function erofs_raw_access_readahead:
fs/erofs/data.c:149:18: warning: last_block may be used uninitialized in this function [-Wmaybe-uninitialized]
	*last_block + 1 != current_block) {

It seems to be a preexisting bug, which your patch prompted gcc-7.2.0
to notice.

erofs_read_raw_page() goes in and uses *last_block, but neither of its
callers has initialized it.  Could the erofs maintainers please take a
look?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
