Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0217CD6E4C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 31 May 2026 00:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YmzNjlN3NEw6gn5b/rArppdMSxlD29ufp9dsFDu4CQQ=; b=L9vYf8eek6znHW0XusXFAls3Ph
	cNunJTs0oiJBRd4+T3m17EcEnr49TVNM+JJyenFrVcchXemkkWhBFwOplaDSXrIA7T/uqUy/XdrrJ
	lYBXSmMN7S/MRR6k1jwEps6Kc6wut60AGCWta43bXagn8GEYayADYVjMYy8vRsj1SfK0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wTTmw-0002Jm-Lu;
	Sun, 31 May 2026 00:12:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wTTmv-0002Jg-8O
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 31 May 2026 00:12:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYvRVj4ATb1VjPqyrKnbeBCWG0iaq3Bc8et+a/muwak=; b=TMKki/0qrLSRxPth9U6mdfIrwZ
 PxZPLzMG50cixZTNvBjqwRrorAp0ZUqiVbqTeY2HGS/1kLciCzUr03oC//WGxXPYDVo+EWx2pBahd
 3mUt9rE9COb5YQ1U8D38Q95yasqV6QFb5bgttpvXA2L8duXZZat8LsnXqYZ2POTzZpKE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OYvRVj4ATb1VjPqyrKnbeBCWG0iaq3Bc8et+a/muwak=; b=OIm2xLNMvZVR+OJaL1X4jUuIyV
 hsMARmS+GrebxIVupdu6LyVxbMOOIxwIiyDqGMIkS2pSRQIROBQKyHKaUQB4dk9afVYIk99LGDhiP
 LgT4uDq3y5/nJ8k9WJiZkO3WiHdfIx2zSxwF21mNl1zvOlNkh4BaSUE3YD/Tcmj8q008=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wTTmu-000688-A4 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 31 May 2026 00:12:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FFDB6001A;
 Sun, 31 May 2026 00:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C321F00893;
 Sun, 31 May 2026 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780186329;
 bh=OYvRVj4ATb1VjPqyrKnbeBCWG0iaq3Bc8et+a/muwak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fHOhsAuR4ScpU7RKty78SP/q0nx98PvpFWPIMukzAHEP+/dxNLJI95BYxZOkZRH8b
 0vvtGETBPj6snAsl5sZla2ANtjpOu4hsZ5T9xZfqKEMyFTJ+hOr94AJt2anvzGK+2I
 UUkR+VjHrS2bRTK7MRYAYRcbwjVawM7kdJGKgjfyVuHrHvzAsPTa4LYjInu5Z7qURl
 uNsap2grrmNTO60WkFlgwkIZCj4q1gkDfjY+QhvWLXJjz4UkmrfX7fYLTkcA4ucLZJ
 K8wxewMF4nOOu52EePN9R+PXM0YUBOJ2WgVAEF3VTJ1jlevVgFJhgTDaF6fDHUvvrK
 pcE0/tyMGqKtg==
Date: Sun, 31 May 2026 00:12:07 +0000
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <aht812OhSPFqIBPK@google.com>
References: <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
 <ahaPDHiXcJoVShPv@infradead.org> <ahcU5xbVy7xjps02@google.com>
 <ahkl52N3RDcusCNd@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahkl52N3RDcusCNd@infradead.org>
X-Headers-End: 1wTTmu-000688-A4
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Bart Van Assche <bvanassche@acm.org>,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/28, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 03:59:35PM +0000, Jaegeuk Kim wrote:
> > F2FS merges bios before submit_bio, regardless of small or large folios,
> > since the block addresses are consecutive. So, I think IO subsystem was
> > working in full speed.
> 
> As does every other remotely modern file system.  But that merging is
> surprisingly expensive, which is why using folios gets really major
> performance improvements.
> 
> For one doing these checks to merge touch quite a few cache lines.
> Second, devices are often a lot more efficient if they see fewer SGL
> entries.  I.e. having a 1MB bio a single SGL tends to work better than
> having 256 of them.
> The same is true in the kernel code itself, both in the submission path
> (dma mapping and co), and even more so in the page cache handling
> both before submitting and in the completion path.
> 
> See Bart's patch about how long the walk of the bio_vecs in the f2fs
> completion path can take.  We had similar issues in XFS even in the
> workqueue completion path due to lack of rescheduling, and these simply
> go away when you do the folio manipulation in larger chunks (LAZY_PREEMPT
> would avoid the need to explicit rescheduling these days, but that just
> papers over the symptoms in this case).
> 

I see. That's also super helpful. Let me kick off the large folio support asap.
Thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
