Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31333C6FD1D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 23:37:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjqDM-0005At-3v;
	Tue, 04 Apr 2023 23:37:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pjqDJ-0005Aj-SZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 23:37:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=28csmTGeSXq8H7xfZ7A9tZkyNtsYsSc6KAk1TE12n9Q=; b=EdX6vL6wWXWIwaw9THiTGy+LiR
 q5SBVcqCFY55yRpgL37kLKsmIYI1rtyojiHkH3BwRW0S/cY1B7YIRfAgCVqC/QFkRuOejTnct26oZ
 d9uO0JbJkUWUoq21iIBxadBB8L6BHQtyhk/L6/UtGEzpm/Y7NefcMVcbg4UxEQ1OG7So=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=28csmTGeSXq8H7xfZ7A9tZkyNtsYsSc6KAk1TE12n9Q=; b=l4qjvQbNUvm0xcrDkmP7jqQ02W
 mQGXt+nkYWa584oGlBH8hEwIzFLxu1YxGhKYDGoNlAoBiSELxSg0KrlThGJDW4mpThcPqguEivWrW
 RS2sO8iv6rEsDsVpj24zqcO4Hd7PfdxZdF9Vmwp86S0Awqk+3zw3lpIG4J28bX1CaKx8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjqDJ-0002co-KM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 23:37:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3C02E63AAF;
 Tue,  4 Apr 2023 23:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D67C433EF;
 Tue,  4 Apr 2023 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680651435;
 bh=28csmTGeSXq8H7xfZ7A9tZkyNtsYsSc6KAk1TE12n9Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MzRMCxrEdCfSJr+egFiRRoe3pwGPEZcD99zxZrYbt5ciHtwXGms9CUOlfLkUIsf3n
 Dq43lH7ZE8DC7AIwuA0rGofhxf6xABvBNbtWaHUv+oOCfnPeR0ROwg+1Ai+ZlgQb5I
 +8wPKWKn9HJIM/PdRtaqDctfJPytasl9aS/ekuyXlrcTDKEKwpxvBRAlPUIIKaD2D3
 NPRMXTl4LyGxzqCx4Dp97UM9fJe1HBjc+21snGc7Qxw54p9XORNR8EB+byaaoavD+E
 VVQpmcJF+uIuCzlRajzE5SxibJTalb1plXMeva9WeuOTsFJBk66cqpXDXkODEpG4zU
 zFmJFk59vKE8w==
Date: Tue, 4 Apr 2023 16:37:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20230404233713.GF1893@sol.localdomain>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
X-Headers-End: 1pjqDJ-0002co-KM
Subject: Re: [f2fs-dev] [PATCH v2 00/23] fs-verity support for XFS
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org,
 damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net,
 hch@infradead.org, cluster-devel@redhat.com, dchinner@redhat.com,
 rpeterso@redhat.com, xiang@kernel.org, jth@kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.

Just to double check, did you verify that the tests in the "verity" group are
running, and were not skipped?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
