Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C218CC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 May 2023 03:31:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1IkK-00072R-9T;
	Tue, 23 May 2023 03:31:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1q1IkC-00072F-65
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 03:31:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/hND79jypjGMxrh+L0AHfmoXlB7jfnZF846f0hmvk3s=; b=hgJ3wX0NE77KzfbMgEDZhGME7o
 o+ANtI3+C9txyFHoacTotazhDe+URi1Xwy5agbND/PqCQBmm/KznpT63vqOlOpQzdNdkeslM63T/6
 EpibaURFwkUV4P92MUmXQdPxLyYNUV8sD6Lxj+Np1NgQUXJiGjkMrP8ZzjD+jZEU2NlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/hND79jypjGMxrh+L0AHfmoXlB7jfnZF846f0hmvk3s=; b=NN7saOTmdx2zeEIux9PRQK4ZqP
 6ElbGZlb66dwE+qXjJ0lieNIQxTwN7CIbQ0wli7cIKc1FiZpzMYcj85aeXFAp/UufFUT/T+rbdgrA
 RU8graY792oeBiGFfIilJrGZpdFabuL0jQaCuUeNBYJKHn+wE1D41HVyE6KAl93RkkDA=;
Received: from [90.155.50.34] (helo=casper.infradead.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1Ik5-00061u-Lo for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 03:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/hND79jypjGMxrh+L0AHfmoXlB7jfnZF846f0hmvk3s=; b=HROkOeYJgsW515w412weVmp0+i
 YEdCM3PRHJ8yLIzdBSb+Xne+pGdopXsi8JnT0CNNfg9oYv05lkYp5Nceqaag93z1O8A122qkxCVFv
 +izmJgPDGdRSRSfuroAjrwUvFuFU9Sr+1LDaSOnQuHT4rkaVFrGW9ZqvWG2nbNXKaUr5oZDVJK11I
 RyvLNOj1PcX4LwBEV/FegrIgbBdhvp7j2y31h8Wy7rSvHujrlGbNAYVSA0t7gLYx6nDhZYo2aTnwG
 2e2CzusZB4FwcCAcoisC1TopNtNPBuTbaa+4Xz1KrGZTS3PUwYf30EPvOgjalWOatycvM59In4SD4
 sazxHniQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1q1Ijb-009k51-9e; Tue, 23 May 2023 03:30:51 +0000
Date: Tue, 23 May 2023 04:30:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <ZGwza3fdkBHyVG3+@casper.infradead.org>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-9-hch@lst.de>
 <20230523010627.GD11598@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230523010627.GD11598@frogsfrogsfrogs>
X-Headers-End: 1q1Ik5-00061u-Lo
Subject: Re: [f2fs-dev] [PATCH 08/13] iomap: assign
 current->backing_dev_info in iomap_file_buffered_write
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
Cc: NeilBrown <neilb@suse.de>, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Andreas Gruenbacher <agruenba@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, May 22, 2023 at 06:06:27PM -0700, Darrick J. Wong wrote:
> On Fri, May 19, 2023 at 11:35:16AM +0200, Christoph Hellwig wrote:
> > Move the assignment to current->backing_dev_info from the callers into
> > iomap_file_buffered_write to reduce boiler plate code and reduce the
> > scope to just around the page dirtying loop.
> > 
> > Note that zonefs was missing this assignment before.
> 
> I'm still wondering (a) what the hell current->backing_dev_info is for,
> and (b) if we need it around the iomap_unshare operation.
> 
> $ git grep current..backing_dev_info
[results show it only set, never used]
> 
> AFAICT nobody uses it at all?  Unless there's some bizarre user that
> isn't extracting it from @current?
> 
> Oh, hey, new question (c) isn't this set incorrectly for xfs realtime
> files?

Some git archaelogy ...

This was first introduced in commit 2f45a06517a62 (in the
linux-fullhistory tree) in 2002 by one Andrew Morton.  At the time,
it added this check to the page scanner:

+                               if (page->pte.direct ||
+                                       page->mapping->backing_dev_info ==
+                                               current->backing_dev_info) {
+                                       wait_on_page_writeback(page);
+                               }

AFAICT (the code went through some metamorphoses in the intervening
twenty years), the last use of it ended up in current_may_throttle(),
and it was removed in March 2022 by Neil Brown in commit b9b1335e6403.
Since then, there have been no users of task->backing_dev_info, and I'm
pretty sure it can go away.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
