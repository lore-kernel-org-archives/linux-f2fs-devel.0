Return-Path: <SRS0=e6wk=JE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252C1C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Apr 2021 15:04:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C501261262;
	Wed,  7 Apr 2021 15:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C501261262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lU9jT-0001rX-PW; Wed, 07 Apr 2021 15:04:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1lU9jM-0001qA-AZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Apr 2021 15:04:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xP0skvSevFXPIPz7nwsCa/l4rgTsu7hcso8RBaxkAKM=; b=Poz+Ht5tCNJne3QZwRNEs+um7Q
 mf1sCUigUnB3kkgrdwBAb+/NzHMBQLYI/tWDzp9ahduwrWfcGwlkqZw2c32K52oJvVS/wA7errQ2p
 R4GobFIdItlqEjyucyl1GtQSNk7aG61sIQXkLFYp4hYNZA69erwvDzGxOkyBqiba2V2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xP0skvSevFXPIPz7nwsCa/l4rgTsu7hcso8RBaxkAKM=; b=H
 +Q2gj2X3I2lnsU5OEEZulQ9o0xg0MWyoruUQQIavkC1kYY0npn3v99OE1nXiOl4M+b2CVzwhb7oDQ
 3E9XC0jzMZ+bEio3CUpzCQNacubqI2LuTPdaXP7QWxGDJ1Q8CM7Kpc6H1TyjhAxgFiFdKyMiHthc+
 zMAadiVpACotDGFA=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lU9jC-00069j-Lx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Apr 2021 15:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=xP0skvSevFXPIPz7nwsCa/l4rgTsu7hcso8RBaxkAKM=; b=G65HT/hYsV2PC0JfbVcRjbrAaM
 2qnuynyb98y9h16CjkDW5FUwrfeDMjPqDLerhaFdypS0t4PMtnhgVQ2s1ERiRSRtKxCea4NypMIeN
 0MBTjwAqBYpIKaiMtQjIpApA8+tKbi832ZTZxIXpvrisYvKQq7Dhe2DWlBjjZUDvS3JxpqrrGNWI9
 +CyZ//KmXVI4Og3mlXceAvpIqVbNzSRZTvw6ZRe1EJUxCAaN2VgK0M0anqObGU58cR0yZo+C11pM6
 3s+J6oJiQLDCbP/b2gld+mVCH2qvmgnMR8ZZvQKIKICAKe6dC7rWu+L4jyR1AWHzVmLCDEygq4jHi
 IQh2zCow==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lU9hn-00Edoc-Vw; Wed, 07 Apr 2021 15:03:06 +0000
Date: Wed, 7 Apr 2021 16:02:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Daeho Jeong <daehojeong@google.com>
Message-ID: <20210407150255.GE2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1lU9jC-00069j-Lx
Subject: [f2fs-dev] Why use page_cache_ra_unbounded?
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
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


commit 5fdb322ff2c2b4ad519f490dcb7ebb96c5439af7
Author: Daeho Jeong <daehojeong@google.com>
Date:   Thu Dec 3 15:56:15 2020 +0900

    f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE

+       page_cache_ra_unbounded(&ractl, len, 0);

/**
 * page_cache_ra_unbounded - Start unchecked readahead.
 * @ractl: Readahead control.
 * @nr_to_read: The number of pages to read.
 * @lookahead_size: Where to start the next readahead.
 *
 * This function is for filesystems to call when they want to start
 * readahead beyond a file's stated i_size.  This is almost certainly
 * not the function you want to call.  Use page_cache_async_readahead()
 * or page_cache_sync_readahead() instead.
 *
 * Context: File is referenced by caller.  Mutexes may be held by caller.
 * May sleep, but will not reenter filesystem to reclaim memory.
 */

Why?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
