Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280ACC7115B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7zCpYBjH8ETyalGDWl6OJ5NeYZ1ShVOjRzl2U1l7x0=; b=mAkFS+mhqfGetopzjN09+SXBQm
	3U57RZpzchCjoese7AvtuVxYxX0UNC52xoKDOiLLylFu6y9i+pEog3v4Od4zQCuOd8lov0u49XqiC
	za/oxR6IPXACPdPFywNctsaAXI9BB0lFcv08zYa2ZaKuZgR9VEFP3ixSw8q3f6cyHxDc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uTgCy-0004Wv-G9;
	Mon, 23 Jun 2025 12:23:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1uTgCv-0004Wj-N0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jun 2025 12:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3oCr8/2E/ECUGMdCQG5uK2s/rAaWdb4SF8d9yHw1SGc=; b=kkXKOLO30oPkWqsRNUQw+fmhTv
 R7UXILYO8LiDkbldPxk2A2omLVXeU5vgT0Z/Ig+kVv6vPe6SLUvEpxCNzoZPNwHsoVMbNo8tcI/ue
 p0DoQi4KbCh8RYfc6H14B0pVaroufRiMcbG1RJtp7mMjggLapNeWZpbg7B7jFrNHUA5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3oCr8/2E/ECUGMdCQG5uK2s/rAaWdb4SF8d9yHw1SGc=; b=lloKabP4j7UknWFQk2el2Ob2ya
 V+Jrw1BTKzDITy7XHukQVlFMoh07+8LRWzWDR/OmR74sy2Z8/VDctMeT1KyreIeuBVyZgGIp4ubBl
 ao0xdPYtDkOLA9eK9wPdafny2IjxGuaOrufIEy7WlW3ns1lTVSbUw/1KCJ1yE2cSXxWQ=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uTgCv-0007yF-9i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jun 2025 12:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3oCr8/2E/ECUGMdCQG5uK2s/rAaWdb4SF8d9yHw1SGc=; b=LnNB/HnRw1ZuK8fdt8rSMJ2ZYs
 q+mW5oayHUBd2qfRNZL5j0uUh9ko/ejIS840XHJrbvp0XXsnPshvxo22sJ2/tdoYi6ERn4uQPoids
 wWMoD9y+CL3Eubvm4JTJtsfBUMB3K5F7LRxS8wdG6bSZK4z6byuJQYa85lbqNFDJRZj4Ia/+OYd8d
 9ipCORuobaKsyF0cXHA8WHbUY6oPA7b/XkqQtx4BeOji44BWo4jJcuXOvV5cy7UrNymptQgKKmQ04
 nj/lr96lizIJt52vWyInxpNXHVuHv8TrB4k/r+WH2R08hi5XIz+wWuYWais41pGsOlRtF3aaeYV3n
 Lx7l0xHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1uTgCR-00000003OC9-0JQF;
 Mon, 23 Jun 2025 12:22:59 +0000
Date: Mon, 23 Jun 2025 13:22:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Message-ID: <aFlHIjLBwn3LQFMC@casper.infradead.org>
References: <20250623093939.1323623-4-shivankg@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250623093939.1323623-4-shivankg@amd.com>
X-Headers-End: 1uTgCv-0007yF-9i
Subject: Re: [f2fs-dev] [PATCH V2 1/2] mm/filemap: Add NUMA mempolicy
 support to filemap_alloc_folio()
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
Cc: kvm@vger.kernel.org, david@redhat.com, linux-mm@kvack.org,
 jaegeuk@kernel.org, zbestahu@gmail.com, dhavale@google.com,
 linux-bcachefs@vger.kernel.org, xiang@kernel.org, josef@toxicpanda.com,
 dsterba@suse.com, linux-coco@lists.linux.dev, jefflexu@linux.alibaba.com,
 pankaj.gupta@amd.com, vbabka@suse.cz, clm@fb.com, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 lihongbo22@huawei.com, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 23, 2025 at 09:39:41AM +0000, Shivank Garg wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Add a mempolicy parameter to filemap_alloc_folio() to enable NUMA-aware
> page cache allocations. This will be used by upcoming changes to
> support NUMA policies in guest-memfd, where guest_memory needs to be
> allocated according to NUMA policy specified by the VMM.
> 
> All existing users pass NULL maintaining current behavior.

I don't want to see this as a separate series.  I want to see it as part
of the series that introduces the user.

Andrew, please drop these two patches from your tree.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
