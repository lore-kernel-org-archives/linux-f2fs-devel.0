Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A8EC7618D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Mar 2023 13:43:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1peFnX-0001pJ-Bk;
	Mon, 20 Mar 2023 13:43:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+c562255d70dcb65b4262+7148+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1peFnU-0001pD-1p for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Mar 2023 13:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lyaRvsye6sWCYUaK2r7kITb5Cun3WkrtNnMFlhr/WZs=; b=YzckCFwBVoMJ36QoP6apKBGOkg
 6TEbnJ0PDAeEi9mZ4kv0qVUv1zMzE/vpA/P9FdR8rs+Y6Ke8PuEkkoSoNEQn+BJa4xAPAJCKplEc3
 5Btf6VPqbqi9tgsajktgG5jHt5yy4MeL0N8eNzLvTnlZaNKvoAUsstdX4R0sifqrz9vs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lyaRvsye6sWCYUaK2r7kITb5Cun3WkrtNnMFlhr/WZs=; b=nJhdn4b5BNgtlO2+CTvlNPsoyA
 NixzcpggC+4Qhyx9/lM9Nt9bOyyNWapJ5O25ZxPymJBQd/k6D8rDXxNCUZ5rxVtOGQMS4b/uuG9eh
 zmNaq7uEuidK73DdZp/LaRoBdFCcLdVech0JMfrvMNAyqKwaeoCMhlyVjGQg6ZD6KSOY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1peFnU-000144-5E for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Mar 2023 13:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lyaRvsye6sWCYUaK2r7kITb5Cun3WkrtNnMFlhr/WZs=; b=BN6jRCUiL5YXWEQuJl9pMl5886
 K4uUNDR9EKK7rheJ/M/Ig50O9RvfiuWlggLqjqsXM77Wlx5UG3DJpT2/u05D4hI+cXFNHzF2nB/Ca
 IWb5oHndufarTQI8vZUVq3lpXW7kZ1O5LqeTr9hbeVSl3I15sp1wxMRB44IKU3c8AXTOhksjBBy+k
 jZPBO1Q4JX88AMgaSIW1Ft1w3TSUbv2gFFZ5ISdOWq+8uoWfLJrFrQInZKbJC7EyX+dxuYWFgoIvH
 I/My94HTVPUF9KZKE7ldXlAJGHZTcZUQUR8RHWsouypLxmGjgr1XQMJVoe5Cp5NQ6mtp6hm6qS172
 4bnXPsyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1peFnI-009Dkw-1x; Mon, 20 Mar 2023 13:43:24 +0000
Date: Mon, 20 Mar 2023 06:43:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <ZBhi/OSEak3QPryb@infradead.org>
References: <20230316093632.25929-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230316093632.25929-1-frank.li@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1peFnU-000144-5E
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to wait page writeback
 in f2fs_write_raw_pages()
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
Cc: liyangtao <11127627@bbktel.com>, hanqi@vivo.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 16, 2023 at 05:36:32PM +0800, Yangtao Li wrote:
> +		if (PageWriteback(cc->rpages[i])) {
> +			if (wbc->sync_mode != WB_SYNC_NONE)
> +				f2fs_wait_on_page_writeback(cc->rpages[i],
> +						DATA, true, true);
> +			else
> +				goto continue_unlock;

Please avoid the else by doing the goto in the branch:

		if (PageWriteback(cc->rpages[i])) {
			if (wbc->sync_mode == WB_SYNC_NONE)
				goto continue_unlock;
			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true,
						    true);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
