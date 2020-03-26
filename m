Return-Path: <SRS0=yNny=5L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D527C2D0ED
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:54:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9122083E;
	Thu, 26 Mar 2020 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VSvgVWGX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VaYiNuS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9122083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jHVmE-0003KW-J6; Thu, 26 Mar 2020 16:54:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dsterba@suse.cz>) id 1jHVmC-0003KB-40
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 16:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7FTumHUvlEQ3cryS5HPWUyQIF4nOOkDXXuri0HJYzJk=; b=VSvgVWGX2lPZmBJtLr0ql1CtHa
 xa0Ry0Yc2/nbN//GDBLurNprI5BLjZfev6tpO9F6isk+yDuw3EjYR5q0j6SQhzeNzUZqbfpLQY+UQ
 skCn4R7DYP5RylTJBMdhur16KnaR/C5fZc092WCta++pdySBsCz8bjl5P3SgpAlf06dY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7FTumHUvlEQ3cryS5HPWUyQIF4nOOkDXXuri0HJYzJk=; b=VaYiNuS2pt/ceahJ7ji6mO5cAi
 YYZmrSYBSjmbMWY0vIoclS8aUP/KWDN+GxglkXqzPsNGJCqY/yNUl3O8EaT0Jn7gnwJET8yyvUgaD
 tLQ8JEnzvoE9pp35UO44qBUDhD36lCpGzlHiyUelDBTg+njBgVogKLAZ+6Z43NVBuRvs=;
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jHVm8-004cqt-FY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 16:54:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9B509ADF1;
 Thu, 26 Mar 2020 16:54:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 350BDDA730; Thu, 26 Mar 2020 17:53:56 +0100 (CET)
Date: Thu, 26 Mar 2020 17:53:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200326165356.GI5920@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-18-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200323202259.13363-18-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1jHVm8-004cqt-FY
Subject: Re: [f2fs-dev] [PATCH v10 17/25] btrfs: Convert from readpages to
 readahead
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
Reply-To: dsterba@suse.cz
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Mar 23, 2020 at 01:22:51PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Implement the new readahead method in btrfs using the new
> readahead_page_batch() function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Sorry for late reply,

Reviewed-by: David Sterba <dsterba@suse.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
