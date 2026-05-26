Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610CBCD5BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 02:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DfeMgib8+cyKuCBx1+EK85v+YPZCMH4nQMEZQfEpzI=; b=Y5iYzn9QMq7aCntWR0ANd7QGs+
	UCgfCqFOxEj1UzIIPCWz4CxmLvJywvFxvR/drZpYK+zUhyjO2p3CDRz9QgfVZENyoKye2J+TVW3mf
	FVy8gT19XFpCKMbynwUE5EzPHJ4HRkBbz54S1PQKI8B2Aw+ieQdWnqMjeo1Y3XTFRNsc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRhdz-0004hV-7D;
	Tue, 26 May 2026 02:35:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wRhdg-0004hA-4a
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 02:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D4dD+8LEduyXVpGhWEf1ps9qWelIM8St2vWZ5S4kbJY=; b=jVIl4v1fJ/g6zqQssMlYGRbx2t
 qJEGZOnMiPFsiK9RVppER5ci3ZxzHY5sLE2k0yQvwaVsHj8JOCMcCuesXW9V6O7/1sxHQznbDK8nJ
 GLaXYpkqswm9BTR6wc23G33z71fCjybdwmJ4TUb9E7km9fB1M5/1wNQMLn8YudOOK6dQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D4dD+8LEduyXVpGhWEf1ps9qWelIM8St2vWZ5S4kbJY=; b=EzM7vu4y65jcBWkiys/gYBORFe
 EramXbSR6jJ89NbZ7HG2OEdH+muSFTuE2xq4h5tuk5WcrX3o6H6MEXhklEk7P7mo/nDjNOATZRW2i
 qRefMjb+HgJhcYe7GO/X0l51ue3hSNstrn4ggaJ2+obefzzp/u6Rh7LgOvr/fvuf/8LM=;
Received: from [90.155.50.34] (helo=casper.infradead.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRhdc-0003ob-Ts for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 02:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=D4dD+8LEduyXVpGhWEf1ps9qWelIM8St2vWZ5S4kbJY=; b=eLzw/QYnYKRLpwb1HtjkmB49gg
 79llPF4Rp2oo/ORPrTJf1wdsRVK9y+gEym/90lmbGVl0hVBTWAVlznrPuCCq6lqb761iOT6PzSQa+
 lHRxIH5A3E90q8ZlWu8dmgw2j/rrqe9qN36OHf/QTDdcHCUj6wa3ORgJ1Ci3uVrCG3pqB/SjeDJTq
 dzYOnrS2GY+UMY9yrNe6KfY9e+x3smQJwUM5bDzukPyivYUtmHALfIsAlq5CBp0/SwjYterNTJZ6f
 fbJyGrAhlaegMFsv7ZHuVO8pnKafkyNOcC03PK+Rv5lMLUEzXNcviI2hdf/0+tJi6DxJr7S+VNIv8
 Ym0BEBJg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wRhdN-00000000WZ7-3iEx;
 Tue, 26 May 2026 02:35:10 +0000
Date: Tue, 26 May 2026 03:35:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ahUG3ZCnc1RQ0EL_@casper.infradead.org>
References: <ad30g9xMs9wNJhFb@infradead.org> <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahTzHyHBL8t0iNBR@google.com>
X-Headers-End: 1wRhdc-0003ob-Ts
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> Let me try to write more details, helped with Gemini.

This is garbage, and frankly disrespectful.  I'm not going to argue with
your AI bot.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
