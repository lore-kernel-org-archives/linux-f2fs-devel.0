Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64E4C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jun 2022 08:19:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nyquR-0007CP-J6; Wed, 08 Jun 2022 08:19:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+ba9ae8ab3d8ecaf97ba4+6863+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nyquQ-0007By-L2; Wed, 08 Jun 2022 08:19:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WeN0C3DdlZFELzEbLwkwOePH1x8klG/LHokEE+8tpD8=; b=Cjg83eYVRY7pudhHM5hgmXh9p9
 t5496jGBKIO2xwQmxGVyRzNOe4DVMRaQKGaEjSYaIkswHDXG3LvPjRRkX/k7aQq+AsDVog7965jKj
 44GQSLoF/poRlKiiV7R0XdDf7mDOqbendkRP8mQiSJIknCwhT9tcoO/9ARhbnfs1m1Ec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WeN0C3DdlZFELzEbLwkwOePH1x8klG/LHokEE+8tpD8=; b=CkaFwd58U7ayQ6l9/ZqJUrjOdh
 ei2DkBpZFfa0VsFmjGZDzpGtlm9r0GxHjEd6aqWOHkvFeVsKDwXOGgqcctjChlBQoFZ8bycgIm2AR
 bb6A7t6WojAXpFX6l1ohT0smwDt6lRyFHN9dJVUFfNb6K0UTLbZml+3dvjGyFhSyhzpg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nyquQ-009amW-E0; Wed, 08 Jun 2022 08:19:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WeN0C3DdlZFELzEbLwkwOePH1x8klG/LHokEE+8tpD8=; b=wsH9uiJgejXz47LPZei+oWZJ8A
 IZnlV7edXHL4ha1oTvUSLDvPACCVildTVD97JYH+YvS9NQD9RErL2PLvTzmcgr4cEZ8aBBtU7ZwCY
 aHPMjH7G+wdRRxpAX/QKY6yOL0jhQ2PN0eLeui9tcc/n9UU64j1idJz8iDtPo/1JxWLSpPRJL94f5
 NWFciD5tp8SfpISOi+rfKNtyER4G/F9X18tK/5bl3JEm66RhJ8d/wiXf7827VEZC+s/qMucFL87VG
 yj+VOb/XYsvobGBH3310knK3mTGpH5ks9wfGuRdLMe9BXnPKMkPuVQyYjxoDqSve7J4GXAN4+E9b2
 URgJZjTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyquJ-00Btm1-BQ; Wed, 08 Jun 2022 08:19:15 +0000
Date: Wed, 8 Jun 2022 01:19:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <YqBbg4zoiHg8z5Jj@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-10-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nyquQ-009amW-E0
Subject: Re: [f2fs-dev] [PATCH 09/20] mm/migrate: Add filemap_migrate_folio()
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
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 06, 2022 at 09:40:39PM +0100, Matthew Wilcox (Oracle) wrote:
> There is nothing iomap-specific about iomap_migratepage(), and it fits
> a pattern used by several other filesystems, so move it to mm/migrate.c,
> convert it to be filemap_migrate_folio() and convert the iomap filesystems
> to use it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
