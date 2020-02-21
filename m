Return-Path: <SRS0=zARH=4J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8854C35646
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:00:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740DA222C4;
	Fri, 21 Feb 2020 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="it9bmh64";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="DZXahgA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740DA222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j56yo-0006VN-4m; Fri, 21 Feb 2020 12:00:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dsterba@suse.cz>) id 1j56yn-0006V7-1d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 12:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fqnvcmg7I8fi0RmeFxwBC2P5aoh+9brAjYCJV7Sk1LM=; b=it9bmh645K6c28Fv7gzWJMVAAi
 BpmdeXRZY1yexVwUZz/aQUKY3V4CAgKkHSAE61SjpLRcyfXqtuvoeSS7m4Vk2/i32vigSxl9e+4Aw
 ED7PVocsYe44nzRzIH9AubSRt6l9TlOnWNvwiuZcEmHQL/nZHxLcB8twIx4v96KEKLM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:Message-ID:
 Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fqnvcmg7I8fi0RmeFxwBC2P5aoh+9brAjYCJV7Sk1LM=; b=DZXahgA9xYHjp8q1XbMm8slNo3
 Km0LL5Knh4PCCbEtRZ5Iayw9/t4Zlh7E6wHDdX2/2aw3kjzgrp87Cg5b9L/48Gc3YoarRYfyziqiP
 8C4iZgBsASJAMVxr6c9C3hUwqU7tqwLwtkYw2jlF0sPAId2oU2E0nLEs3B2NqN0MyBbM=;
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j56yl-002hfx-2w
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 12:00:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9004EAF2B;
 Fri, 21 Feb 2020 12:00:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id B113FDA70E; Fri, 21 Feb 2020 12:59:58 +0100 (CET)
Date: Fri, 21 Feb 2020 12:59:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200221115957.GE2902@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
References: <20200219210103.32400-1-willy@infradead.org>
 <20200220175400.GB2902@twin.jikos.cz>
 <20200220223909.GB24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200220223909.GB24185@bombadil.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Headers-End: 1j56yl-002hfx-2w
Subject: Re: [f2fs-dev] [PATCH v7 00/23] Change readahead API
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
Cc: linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 dsterba@suse.cz, linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Feb 20, 2020 at 02:39:09PM -0800, Matthew Wilcox wrote:
> > >  - Now passes an xfstests run on ext4!
> > 
> > On btrfs it still chokes on the first test btrfs/001, with the following
> > warning, the test is stuck there.
> 
> Thanks.  The warning actually wasn't the problem, but it did need to
> be addressed.  I got a test system up & running with btrfs, and it's
> currently on generic/027 with the following patch:

Thanks, with the fix applied the first 10 tests passed, I'll let the
testsuite finish and let you know if ther are more warnings and such.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
