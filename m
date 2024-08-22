Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A71C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 03:28:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgyV2-00059u-0L;
	Thu, 22 Aug 2024 03:28:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1sgyV0-00059n-Gy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 03:28:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kssEsSuP13aZFqShrbOpvQvO30ul38vY5Tx7vPFUp3s=; b=EeLhz3Q/SRy3Cq1J2EAF3Yp3Wh
 AsI7seRSAhQsaSu1El+xl1rH8hP8jgV6o+NSjObuCbmU//sgqC2qUGGErkaqCQJuXl6Riva/stKNj
 IPF1LwfcEJxuhMeDTSPR+Zwkt+BZYsKPXCbmem0GvhrySjG+O8sFH3lRGHwUjIcCbHlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kssEsSuP13aZFqShrbOpvQvO30ul38vY5Tx7vPFUp3s=; b=YVr61aCdVCUxW/zDUBmWa7rlCf
 OiNrw7mBR/6udm0imipkKVoDOiHMGvOkQdzEROyu6jgpC35XuA4SjDlJ62kG+fAoeIj4AgHAJgQfo
 13wTXMOaqe0bxxiTzVPN4TPhY7LSAdPMHdl//jTGO3M98tg0DldJZjX0G+oPdz9dnKQU=;
Received: from [90.155.50.34] (helo=casper.infradead.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgyUz-0007v0-4p for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 03:28:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kssEsSuP13aZFqShrbOpvQvO30ul38vY5Tx7vPFUp3s=; b=Cg4y9nZ4qFrl/ncgnUKfZRN3o2
 gbFTXFDPS0tZtjgl3r/lBdSV8vafgujyuZG1OMKY56r/8OXarQOwa831CpF29c9CL/8Xc6KaS7nCp
 7DsEZ/Wig8/obDK5DV9KaXASEvTdlRxskNE37uf2hgIqndSvZb5fMJUUoangj9OntqWdWNf/eyDLv
 AINeazPwAhye5oShyuZIsIpYo7C3ELbufnFlb9pUxgA7Nw4qiZMzVo2ONiMLOKE5OBQo/ij+t2u+g
 KSaS75B+LnPiWo1AJgsJl+gcGKWh0NvUhsKviyVz0iEgOk4IgXcdflmJhM3ixCGOV0zIJe8lZ9i+7
 sx7DDrGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1sgyUj-0000000A27l-42sW;
 Thu, 22 Aug 2024 03:28:18 +0000
Date: Thu, 22 Aug 2024 04:28:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Li Zetao <lizetao1@huawei.com>
Message-ID: <ZsawUY25UW07__4G@casper.infradead.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-6-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240822013714.3278193-6-lizetao1@huawei.com>
X-Headers-End: 1sgyUz-0007v0-4p
Subject: Re: [f2fs-dev] [PATCH 05/14] btrfs: convert read_key_bytes() to
 take a folio
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
Cc: josef@toxicpanda.com, linux-f2fs-devel@lists.sourceforge.net, clm@fb.com,
 terrelln@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Aug 22, 2024 at 09:37:05AM +0800, Li Zetao wrote:
> @@ -762,7 +762,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  	 * [ inode objectid, BTRFS_MERKLE_ITEM_KEY, offset in bytes ]
>  	 */
>  	ret = read_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY, off,
> -			     folio_address(folio), PAGE_SIZE, &folio->page);
> +			     folio_address(folio), PAGE_SIZE, folio);

So how are we going to read into folios larger than PAGE_SIZE?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
